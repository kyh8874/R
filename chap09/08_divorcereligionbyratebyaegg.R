library(tidyverse)
load("koweps/welfare.rda")


#종교유무 와 이혼율(use group_by)
welfare %>% filter(!is.na(group_marriage)) %>% 
    filter(!is.na(religion)) %>% 
    select(religion,group_marriage) %>% 
    group_by(religion,group_marriage) %>%  #tibble group => religion,group_marriage정보가 있음
    summarise(n=n()) %>% #하위 tibble group=> group_marriage 정보가 없어짐==>religion 그룹만남음
    mutate(total=sum(n)) %>%  #religion 그룹으로 각행에 ==> sum값.. 
    mutate(pct=round(n/total*100,1)) %>% 
    filter(group_marriage =='divorce') ->divorceratiobyreligion1

divorceratiobyreligion1 %>% 
     ggplot(aes(religion,pct))+geom_col()
    


#종교유무 와 이혼율(use count)
welfare %>% filter(!is.na(group_marriage)) %>% 
    filter(!is.na(religion)) %>%  
    count(religion,group_marriage) %>% 
    group_by(religion) %>%    # sum은 group정보를 갖지않아서 만들어 준다 count는 그룹정보가 없다
    mutate(total=sum(n)) %>% 
    mutate(pct=round(n/total*100,1)) %>% 
    filter(group_marriage =='divorce')->divorceratiobyreligion2

all(divorceratiobyreligion1==divorceratiobyreligion2)

library(sqldf)
sqldf("
      select  religion , group_marriage, count(group_marriage) as n from welfare
        where religion not null and group_marriage not null
        group by religion,group_marriage
      ")->group_a

sqldf("
      select  religion, sum(n) as total from group_a
        group by religion
      ")->group_b

sqldf("
      select  a.religion , group_marriage, n , total , round(1.0*n/total*100,1) as ratio
        from group_a a, group_b b
        where  a.religion = b.religion and group_marriage ='divorce'
      ")->divorceratiobyreligion3

sqldf("
      select  a.religion , group_marriage, n , total , round(1.0*n/total*100,1) as ratio
        from (
               select  religion , group_marriage, count(group_marriage) as n from welfare
                  where religion not null and group_marriage not null
                  group by religion,group_marriage
             ) a ,
            (
               select  religion, sum(n) as total from group_a
                  group by religion
            ) b
        where  a.religion = b.religion and group_marriage ='divorce'
      ")->divorceratiobyreligion3

    all(divorceratiobyreligion1==divorceratiobyreligion3)

    divorceratiobyreligion1 %>% 
        ggplot(aes(religion,pct))+geom_col()
    
    #divorcebyreligionbyageg
    welfare %>% filter(!is.na(ageg)) %>% 
        filter(!is.na(religion)) %>% 
        filter(!is.na(group_marriage)) %>% 
        group_by(ageg,religion,group_marriage) %>% 
        summarise(n=n()) %>% 
        mutate(total=sum(n)) %>% 
        mutate(ratio=n/total*100) %>% 
        filter(group_marriage=="divorce") ->divorcebyreligionbyageg1
    
    divorcebyreligionbyageg1
    
    divorcebyreligionbyageg1 %>% 
        ggplot(aes(ageg,ratio, fill=religion))+
        geom_col(position="dodge")+
        scale_x_discrete(limits=c('young','middle','old')) + 
        labs(x="ageg",y="ratio",title="Divoce ratio by ageg by religion")
    
    welfare %>% filter(!is.na(ageg)) %>% 
        filter(!is.na(religion)) %>% 
        filter(!is.na(group_marriage)) %>% 
        count(ageg,religion,group_marriage) %>% 
        group_by(ageg,religion) %>% 
        mutate(total=sum(n)) %>% 
        mutate(ratio=n/total*100) %>% 
        filter(group_marriage=="divorce") ->divorcebyreligionbyageg2
    
    divorcebyreligionbyageg2
    
    divorcebyreligionbyageg2 %>% 
        ggplot(aes(ageg,ratio, fill=religion))+
        geom_col(position="dodge")+
        scale_x_discrete(limits=c('young','middle','old')) + 
        labs(x="ageg",y="ratio",title="Divoce ratio by ageg by religion")
    
    sqldf(" select a.ageg, a.religion, group_marriage, n , total, 1.0*n/total*100 as ratio 
       from
         (select ageg, religion, count(*) as total from welfare
             where ageg not null and religion not null and group_marriage not null
             group by ageg, religion) a,
         (select ageg,religion,group_marriage, count(*) as n  from welfare
             where ageg not null and religion not null and group_marriage not null
             group by ageg,religion,group_marriage) b
      where a.ageg=b.ageg and a.religion=b.religion and group_marriage = 'divorce'
    ")->divorcebyreligionbyageg3
    
     divorcebyreligionbyageg3
    
     divorcebyreligionbyageg3 %>% 
         ggplot(aes(ageg,ratio, fill=religion))+
         geom_col(position="dodge")+
         scale_x_discrete(limits=c('young','middle','old')) + 
         labs(x="ageg",y="ratio",title="Divoce ratio by ageg by religion")
    
    
    
    
    
    
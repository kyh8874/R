library(tidyverse)
library(gridExtra)
klosa=read_csv("Data/klosa.csv")

klosa %>% filter((year==2006 & age < 56) |
                     (year==2008 & age < 58) |  
                     (year==2010 & age < 60) |  
                     (year==2012 & age < 62) |  
                     (year==2014 & age < 64) |  
                     (year==2016 & age < 66)) %>% 
    select(year,gender,age,ageg,emp,present_ecotype,earned,adl,iadl) %>% mutate(tfr="45to55") -> r1


klosa %>% filter((year==2006 & age > 55 & age < 66) |
                     (year==2008 & age > 57 & age < 68) |  
                     (year==2010 & age > 59 & age < 70) |  
                     (year==2012 & age > 61 & age < 72) |  
                     (year==2014 & age > 63 & age < 74) |  
                     (year==2016 & age > 65 & age < 76)) %>% 
    select(year,gender,age,ageg,emp,present_ecotype,earned,adl,iadl) %>% mutate(tfr="56to65") -> r2


klosa %>% filter((year==2006 & age > 65 & age < 76) |
                     (year==2008 & age > 67 & age < 78) |  
                     (year==2010 & age > 69 & age < 80) |  
                     (year==2012 & age > 71 & age < 82) |  
                     (year==2014 & age > 73 & age < 84) |  
                     (year==2016 & age > 75 & age < 86)) %>% 
    select(year,gender,age,ageg,emp,present_ecotype,earned,adl,iadl) %>% mutate(tfr="66to75") -> r3


klosa %>% filter((year==2006 & age > 75 & age < 86) |
                     (year==2008 & age > 77 & age < 88) |  
                     (year==2010 & age > 79 & age < 90) |  
                     (year==2012 & age > 81 & age < 92) |  
                     (year==2014 & age > 83 & age < 94) |  
                     (year==2016 & age > 85 & age < 96)) %>% 
    select(year,gender,age,ageg,emp,present_ecotype,earned,adl,iadl) %>% mutate(tfr="76to85") -> r4


klosa %>% filter((year==2006 & age > 85 & age < 96) |
                     (year==2008 & age > 87 & age < 98) |  
                     (year==2010 & age > 89 & age < 100) |  
                     (year==2012 & age > 91 & age < 102) |  
                     (year==2014 & age > 93 & age < 104) |  
                     (year==2016 & age > 95 & age < 106)) %>% 
    select(year,gender,age,ageg,emp,present_ecotype,earned,adl,iadl) %>% mutate(tfr="86to95") -> r5

rbind(r1,r2,r3,r4,r5) -> klosabyage

klosa %>% filter((year==2006 & age > 95 & age < 106) |
                     (year==2008 & age > 97 & age < 108) |  
                     (year==2010 & age > 99 & age < 110) |  
                     (year==2012 & age > 101 & age < 112) |  
                     (year==2014 & age > 103 & age < 114) |  
                     (year==2016 & age > 105 & age < 116)) %>% 
    select(year,gender,age,ageg,emp,present_ecotype,earned,adl,iadl) %>% mutate(tfr="96to115") -> r6

rbind(r1,r2,r3,r4,r5,r6) -> klosabyage

klosabyage %>% mutate(present_ecotype=ifelse(present_ecotype==1, "Employment",
                                             ifelse(present_ecotype==2,"Jobless","Inactive"))) %>% 
    group_by(age,tfr,present_ecotype) %>% 
    summarise(n=n()) %>% 
    mutate(total=sum(n)) %>% 
    mutate(pct=round(n/total*100,1))->ecoact_ageg_year


ggplot(ecoact_ageg_year[ecoact_ageg_year$tfr=="45to55",],aes(age,pct,color=present_ecotype))+
    geom_line() +
    labs(y="Ratio",x="Age",title="45~55s Group") + 
    scale_color_manual( values=c("Blue","Red","Green"),
                        name = ("Type"),
                        labels = c("Employment","Jobless","Inactive"))-> p1
ggplot(ecoact_ageg_year[ecoact_ageg_year$tfr=="56to65",],aes(age,pct,color=present_ecotype))+
    geom_line()+
    labs(y="Ratio",x="Age",title="56~65s Group") + 
    scale_color_manual( values=c("Blue","Red","Green"),
                        name = ("Type"),
                        labels = c("Employment","Jobless","Inactive")) -> p2
ggplot(ecoact_ageg_year[ecoact_ageg_year$tfr=="66to75",],aes(age,pct,color=present_ecotype))+
    geom_line()+
    labs(y="Ratio",x="Age",title="66~75s Group") + 
    scale_color_manual( values=c("Blue","Red","Green"),
                        name = ("Type"),
                        labels = c("Employment","Jobless","Inactive")) -> p3
ggplot(ecoact_ageg_year[ecoact_ageg_year$tfr=="76to85",],aes(age,pct,color=present_ecotype))+
    geom_line()+
    labs(y="Ratio",x="Age",title="76~85s Group") + 
    scale_color_manual( values=c("Blue","Red","Green"),
                        name = ("Type"),
                        labels = c("Employment","Jobless","Inactive")) -> p4
ggplot(ecoact_ageg_year[ecoact_ageg_year$tfr=="86to95",],aes(age,pct,color=present_ecotype))+
    geom_line()+
    labs(y="Ratio",x="Age",title="86~95s Group") + 
    scale_color_manual( values=c("Blue","Red","Green"),
                        name = ("Type"),
                        labels = c("Employment","Jobless","Inactive")) -> p5

grid.arrange(p1, p2, p3, p4, p5, top="Economic Activity", nrow = 3)  


#1.2 성별 경제활동

klosabyage %>% mutate(present_ecotype=ifelse(present_ecotype==1, "Employment",
                                             ifelse(present_ecotype==2,"Jobless","Inactive"))) %>% 
    select(age,gender,tfr,present_ecotype) %>% 
    group_by(age,gender,tfr,present_ecotype) %>% 
    summarise(n=n()) %>% 
    mutate(total=sum(n)) %>% 
    mutate(pct=round(n/total*100,1)) ->ecoact_gender

ggplot(ecoact_gender[ecoact_gender$tfr=="45to55" & ecoact_gender$gender=="male",],aes(age,pct,color=present_ecotype))+
    geom_line()+
    labs(y="Ratio",x="Age",title="45~55s Male Group") + 
    scale_color_manual( values=c("Blue","Red","Green"),
                        name = ("Type"),
                        labels = c("Employment","Jobless","Inactive")) -> g1

ggplot(ecoact_gender[ecoact_gender$tfr=="45to55" & ecoact_gender$gender=="female",],aes(age,pct,color=present_ecotype))+
    geom_line()+
    labs(y="Ratio",x="Age",title="45~55s Female Group") + 
    scale_color_manual( values=c("Blue","Red","Green"),
                        name = ("Type"),
                        labels = c("Employment","Jobless","Inactive")) -> g2

grid.arrange(g1, g2, top="Economic Activity", ncol = 2)  


ggplot(ecoact_gender[ecoact_gender$tfr=="56to65" & ecoact_gender$gender=="male",],aes(age,pct,color=present_ecotype))+
    geom_line()+
    labs(y="Ratio",x="Age",title="56~65s Male Group") + 
    scale_color_manual( values=c("Blue","Red","Green"),
                        name = ("Type"),
                        labels = c("Employment","Jobless","Inactive")) -> g3

ggplot(ecoact_gender[ecoact_gender$tfr=="56to65" & ecoact_gender$gender=="female",],aes(age,pct,color=present_ecotype))+
    geom_line()+
    labs(y="Ratio",x="Age",title="56~65s Female Group") + 
    scale_color_manual( values=c("Blue","Red","Green"),
                        name = ("Type"),
                        labels = c("Employment","Jobless","Inactive")) -> g4
grid.arrange(g3, g4, top="Economic Activity (56 ~ 65s)", nrow = 2)  


#2. 연령대별연령대별 일자리형태: emp
#####################################################
klosabyage %>% filter(!is.na(emp)&!is.na(year)) %>% 
    select(age,tfr,emp) %>% 
    mutate(emps=ifelse(emp==3|emp==4,3,emp)) %>% 
    group_by(age,tfr,emps) %>% 
    summarise(n=n()) %>% 
    mutate(total=sum(n)) %>% 
    mutate(pct=round(n/total*100,1))->ecoact_emp_tfr

ggplot(ecoact_emp_tfr[ecoact_emp_tfr$tfr=="45to55",],aes(age,pct,color=factor(emps)))+
    geom_line()+
    labs(y="Ratio",x="Age",title="45~55s Group") + 
    scale_color_manual( values=c("Blue","Red","Green"),
                        name = ("Type"),
                        labels = c("Employment","Self-employment","Unpaid")) -> e1

ggplot(ecoact_emp_tfr[ecoact_emp_tfr$tfr=="56to65",],aes(age,pct,color=factor(emps)))+
    geom_line()+
    labs(y="Ratio",x="Age",title="56~65s Group") + 
    scale_color_manual( values=c("Blue","Red","Green"),
                        name = ("Type"),
                        labels = c("Employment","Self-employment","Unpaid")) -> e2

grid.arrange(e1, e2, top="Employment Type ", nrow = 2) 


#장애율ADL
###############
klosa %>% select(year,ageg, adl) %>% 
    mutate(adl=ifelse(adl > 0, 1, 0)) %>% 
    count(year,ageg,adl) %>% 
    group_by(year,ageg) %>% 
    mutate(total=sum(n)) %>% 
    filter(adl==1) %>%
    mutate(pct=round(n/total*100,1))-> adl_rate

adl_rate %>% ggplot(aes(ageg,pct,fill=factor(year)))+
    geom_col(position="dodge")+
    labs(y="Ratio",x="Year",title="ADL rate") + 
    theme_grey()+
    scale_fill_discrete(name = "Year")

#장애율ADL- 성별
###############
klosa %>% select(year,gender, adl) %>% 
    mutate(adl=ifelse(adl > 0, 1, 0)) %>% 
    count(year,gender,adl) %>% 
    group_by(year,gender) %>% 
    mutate(total=sum(n)) %>% 
    filter(adl==1) %>%
    mutate(pct=round(n/total*100,1))-> adl_genrate

adl_genrate %>% ggplot(aes(factor(year),pct,fill=factor(gender)))+
    geom_col(position="dodge")+
    labs(y="Ratio",x="Year",title="ADL rate by gender") + 
    theme_grey()+
    scale_fill_discrete(name = "Gender")

#ADL 증가율(66 ~ 750s, 76 ~ 85s)
###############################
klosabyage %>% filter(!is.na(adl)&!is.na(year)) %>% 
    select(year,age,tfr,adl) %>% 
    mutate(adl=ifelse(adl > 0 , 1, 0)) %>% 
    #filter(adl!=0) %>% 
    count(year,tfr,adl) %>% 
    group_by(year,tfr) %>% 
    mutate(total=sum(n)) %>% 
    filter(adl==1) %>% 
    mutate(pct=round(n/total*100,1))->adl_line

ggplot(adl_line[adl_line$tfr %in% c("66to75","76to85"),],aes(year,pct,color=factor(tfr)))+
    geom_line()+
    labs(y="Ratio",x="Year",title="ADL by age group(66~75s,76~85s)")+
    scale_color_manual( values=c("Blue","Red"),
                        name = ("Age group"),
                        labels = c("66 ~ 75s","76 ~ 85s"))

#70s,80s~의 ADL
###################
klosa %>% select(year,ageg,change_clothes,bath,meal,out_of_room,toilet,urin)  %>%
    filter(ageg=="70s"| ageg=="80s~") %>% 
    mutate(change_clothes=ifelse(change_clothes==1,0,1)) %>% 
    mutate(bath=ifelse(bath==1,0,1)) %>% 
    mutate(meal=ifelse(meal==1,0,1)) %>% 
    mutate(out_of_room=ifelse(out_of_room==1,0,1)) %>% 
    mutate(toilet=ifelse(toilet==1,0,1)) %>% 
    mutate(urin=ifelse(urin==1,0,1)) ->adl_count

adl_count %>% group_by(year,ageg,change_clothes)  %>% 
    summarize(count=n()) %>% 
    mutate(class="change_clothes") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(change_clothes!=0) ->m1

adl_count %>% group_by(year,ageg,bath)  %>% 
    summarize(count=n()) %>% 
    mutate(class="bath") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(bath!=0)->m2

adl_count %>% group_by(year,ageg,meal)  %>% 
    summarize(count=n()) %>% 
    mutate(class="meal") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(meal!=0)->m3

adl_count %>% group_by(year,ageg,out_of_room)  %>% 
    summarize(count=n()) %>% 
    mutate(class="out_of_room") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(out_of_room!=0)->m4

adl_count %>% group_by(year,ageg,toilet)  %>% 
    summarize(count=n()) %>% 
    mutate(class="toilet") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(toilet!=0)->m5

adl_count %>% group_by(year,ageg,urin)  %>% 
    summarize(count=n()) %>% 
    mutate(class="urin") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(urin!=0)->m6

rbind(m1,m2,m3,m4,m5,m6) -> adl_bind
adl_bind %>%  select(year,ageg,class,count,total,pct)->adl_bind

ggplot(adl_bind[adl_bind$ageg=="70s",],aes(factor(year),pct,fill=factor(class)))+
    geom_col(position="dodge")+
    labs(y="Ratio",x="Year",title="70s") + 
    theme_grey()+
    scale_fill_discrete(name = "Act.")->adl1

ggplot(adl_bind[adl_bind$ageg=="80s~",],aes(factor(year),pct,fill=factor(class)))+
    geom_col(position="dodge")+
    labs(y="Ratio",x="Year",title="80s~") + 
    theme_grey()+
    scale_fill_discrete(name = "Act.")->adl2

grid.arrange(adl1, adl2, top="ADL by age group(70s,80s~)", nrow = 2) 



#장애율 IADL
###############
klosa %>% select(year,ageg, iadl) %>% 
    mutate(adl=ifelse(iadl > 0, 1, 0)) %>% 
    count(year,ageg,iadl) %>% 
    group_by(year,ageg) %>% 
    mutate(total=sum(n)) %>% 
    filter(iadl==1) %>%
    mutate(pct=round(n/total*100,1))-> iadl_rate

iadl_rate %>% ggplot(aes(ageg,pct,fill=factor(year)))+
    geom_col(position="dodge")+
    labs(y="Ratio",x="Year",title="IADL rate") + 
    theme_grey()+
    scale_fill_discrete(name = "Year")

#장애율 IADL- 성별
###############
klosa %>% select(year,gender, iadl) %>% 
    mutate(adl=ifelse(iadl > 0, 1, 0)) %>% 
    count(year,gender,iadl) %>% 
    group_by(year,gender) %>% 
    mutate(total=sum(n)) %>% 
    filter(iadl==1) %>%
    mutate(pct=round(n/total*100,1))-> iadl_genrate

iadl_genrate %>% ggplot(aes(factor(year),pct,fill=factor(gender)))+
    geom_col(position="dodge")+
    labs(y="Ratio",x="Year",title="IADL rate by gender") + 
    theme_grey()+
    scale_fill_discrete(name = "Gender")


#IADL 증가율(66 ~ 750s, 76 ~ 85s)
###############################
klosabyage %>% filter(!is.na(iadl)&!is.na(year)) %>% 
    select(year,age,tfr,iadl) %>% 
    mutate(iadl=ifelse(iadl > 0, 1, 0)) %>% 
    #filter(adl!=0) %>% 
    count(year,tfr,iadl) %>% 
    group_by(year,tfr) %>% 
    mutate(total=sum(n)) %>% 
    filter(iadl==1) %>% 
    mutate(pct=round(n/total*100,1))->iadl_line

ggplot(iadl_line[iadl_line$tfr %in% c("66to75","76to85"),],aes(year,pct,color=factor(tfr)))+
    geom_line()+
    labs(y="Ratio",x="Year",title="IADL by age group(66~75s,76~85s)")+
    scale_color_manual( values=c("Blue","Red"),
                        name = ("Age group"),
                        labels = c("66 ~ 75s","76 ~ 85s"))

##70s,80s~의 IADL
##################

klosa %>% select(year,ageg,prepare_meal,gloom,clean,laun,out,bus,buying,m_manage,phone_call,medicine) %>% 
          mutate(prepare_meal=ifelse(prepare_meal==1,0,1)) %>% 
          mutate(gloom=ifelse(gloom==1,0,1)) %>% 
          mutate(clean=ifelse(clean==1,0,1)) %>% 
          mutate(laun=ifelse(laun==1,0,1)) %>% 
          mutate(out=ifelse(out==1,0,1)) %>% 
          mutate(bus=ifelse(bus==1,0,1)) %>% 
          mutate(buying=ifelse(buying==1,0,1)) %>% 
          mutate(m_manage=ifelse(m_manage==1,0,1)) %>% 
          mutate(phone_call=ifelse(phone_call==1,0,1)) %>% 
          mutate(medicine=ifelse(medicine==1,0,1)) ->iadl_count 

iadl_count %>% group_by(year,ageg,prepare_meal)  %>% 
    summarize(count=n()) %>% 
    mutate(class="prepare_meal") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(prepare_meal!=0) ->n1

iadl_count %>% group_by(year,ageg,gloom)  %>% 
    summarize(count=n()) %>% 
    mutate(class="gloom") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(gloom!=0) ->n2

iadl_count %>% group_by(year,ageg,clean)  %>% 
    summarize(count=n()) %>% 
    mutate(class="clean") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(clean!=0) ->n3

iadl_count %>% group_by(year,ageg,laun)  %>% 
    summarize(count=n()) %>% 
    mutate(class="laun") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(laun!=0) ->n4

iadl_count %>% group_by(year,ageg,out)  %>% 
    summarize(count=n()) %>% 
    mutate(class="out") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(out!=0) ->n5

iadl_count %>% group_by(year,ageg,bus)  %>% 
    summarize(count=n()) %>% 
    mutate(class="bus") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(bus!=0) ->n6

iadl_count %>% group_by(year,ageg,buying)  %>% 
    summarize(count=n()) %>% 
    mutate(class="buying") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(buying!=0) ->n7

iadl_count %>% group_by(year,ageg,m_manage)  %>% 
    summarize(count=n()) %>% 
    mutate(class="m_manage") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(m_manage!=0) ->n8

iadl_count %>% group_by(year,ageg,phone_call)  %>% 
    summarize(count=n()) %>% 
    mutate(class="phone_call") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(phone_call!=0) ->n9

iadl_count %>% group_by(year,ageg,medicine)  %>% 
    summarize(count=n()) %>% 
    mutate(class="medicine") %>% 
    mutate(total=sum(count)) %>% 
    mutate(pct=round(count/total*100,1)) %>% 
    filter(medicine!=0) ->n10

rbind(n1,n2,n3,n4,n5,n6,n7,n8,n9,n10) -> iadl_bind
iadl_bind %>%  select(year,ageg,class,count,total,pct)->iadl_bind

ggplot(iadl_bind[iadl_bind$ageg=="70s",],aes(factor(year),pct,fill=factor(class)))+
    geom_col(position="dodge")+
    labs(y="Ratio",x="Year",title="70s") + 
    theme_grey()+
    scale_fill_discrete(name = "Act.")->iadl1

ggplot(iadl_bind[iadl_bind$ageg=="80s~",],aes(factor(year),pct,fill=factor(class)))+
    geom_col(position="dodge")+
    labs(y="Ratio",x="Year",title="80s~") + 
    theme_grey()+
    scale_fill_discrete(name = "Act.")->iadl2

grid.arrange(iadl1, iadl2, top="IADL by age group(70s,80s~)", nrow = 2) 

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

#ADL 증가율(66 ~ 75s, 76 ~ 85s) male/female
#############################################
klosabyage %>% filter(!is.na(adl)&!is.na(year)) %>% 
    select(year,gender,tfr,adl) %>% 
    mutate(adl=ifelse(adl > 0, 1, 0)) %>% 
    #filter(adl!=0) %>% 
    count(year,gender,tfr,adl) %>% 
    group_by(year,gender,tfr) %>% 
    mutate(total=sum(n)) %>% 
    filter(adl==1) %>% 
    mutate(pct=round(n/total*100,1))->adl_genline 

adl_genline %>% 
    filter(gender=="male") %>%
    filter(tfr=="66to75" | tfr=="76to85") %>% 
    ggplot(aes(year,pct,color=factor(tfr)))+
    geom_line()+
    labs(y="Ratio",x="Year",title="Male")+
    scale_color_manual( values=c("Blue","Red"),
                        name = ("Age group"),
                        labels = c("66 ~ 75s","76 ~ 85s")) -> male_p1

adl_genline %>% 
    filter(gender=="female") %>%
    filter(tfr=="66to75" | tfr=="76to85") %>% 
    ggplot(aes(year,pct,color=factor(tfr)))+
    geom_line()+
    labs(y="Ratio",x="Year",title="Female")+
    scale_color_manual( values=c("Blue","Red"),
                        name = ("Age group"),
                        labels = c("66~75s","76 ~ 85s"))->female_p2
grid.arrange(male_p1, female_p2, top="ADL by age group(76~85s,86~95s)", nrow = 1) 


#################################################################################################






# klosa  %>% filter(hypertension==1)  %>% select(ageg,hypertension)  %>% rename("value"=hypertension)  %>% mutate(class="hypertension")-> t1
# 
#  klosa %>% filter(!is.na(smoke)) %>% filter(!is.na(alcohol)) %>% filter(!is.na(chronic_sum)) %>% 
#   select(smoke,alcohol,chronic_sum,year)  %>% group_by(year)  %>% mutate(sum_smoke=sum(smoke))  %>% 
#   mutate(sum_alcohol=sum(alcohol)) %>% mutate(sum_chronic_sum=sum(chronic_sum))->m

klosa %>% filter(!is.na(smoke)) %>% filter(!is.na(alcohol)) %>% filter(!is.na(chronic_sum)) %>% 
    select(smoke,alcohol,chronic_sum,year)  %>% filter(smoke!=0&alcohol!=3&chronic_sum>1)->m

klosa %>%
    select(year,
           gender,
           hypertension,
           diabetes,
           cancer,
           lung_disease,
           liver_disease,
           heart_disease,
           cerebrovascular_disease,
           mental_illness,
           arthritis,
           prostate_disease) %>% 
    count(year,
          gender,
          hypertension,
          diabetes,
          cancer,
          lung_disease,
          liver_disease,
          heart_disease,
          cerebrovascular_disease,
          mental_illness,
          arthritis,
          prostate_disease)->m 

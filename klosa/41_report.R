


klosa  %>% filter(!is.na(hypertension))  %>% select(ageg,hypertension)  %>% 
     mutate(yes=ifelse(hypertension==1,1,NA)) %>% mutate(no=ifelse(hypertension==5,1,NA)) %>% 
    mutate(class="hypertension") %>% select(ageg,yes,no,class)-> t1 

klosa  %>% filter(!is.na(diabetes))  %>% select(ageg,diabetes) %>%
    mutate(yes=ifelse(diabetes==1,1,NA)) %>% mutate(no=ifelse(diabetes==5,1,NA)) %>% 
    mutate(class="diabetes")%>% select(ageg,yes,no,class)-> t2 

klosa  %>% filter(!is.na(cancer))  %>% select(ageg,cancer) %>% 
    mutate(yes=ifelse(cancer==1,1,NA)) %>% mutate(no=ifelse(cancer==5,1,NA)) %>% 
    mutate(class="cancer")%>% select(ageg,yes,no,class)-> t3

klosa  %>% filter(!is.na(lung_disease))  %>% select(ageg,lung_disease) %>% 
    mutate(yes=ifelse(lung_disease==1,1,NA)) %>% mutate(no=ifelse(lung_disease==5,1,NA)) %>% 
    mutate(class="lung_disease")%>% select(ageg,yes,no,class)-> t4

klosa  %>% filter(!is.na(liver_disease))  %>% select(ageg,liver_disease) %>% 
    mutate(yes=ifelse(liver_disease==1,1,NA)) %>% mutate(no=ifelse(liver_disease==5,1,NA)) %>% 
    mutate(class="liver_disease")%>% select(ageg,yes,no,class)-> t5

klosa  %>% filter(!is.na(heart_disease))  %>% select(ageg,heart_disease) %>% 
    mutate(yes=ifelse(heart_disease==1,1,NA)) %>% mutate(no=ifelse(heart_disease==5,1,NA)) %>% 
    mutate(class="heart_disease")%>% select(ageg,yes,no,class)-> t6

klosa  %>% filter(!is.na(cerebrovascular_disease))  %>% select(ageg,cerebrovascular_disease) %>% 
    mutate(yes=ifelse(cerebrovascular_disease==1,1,NA)) %>% mutate(no=ifelse(cerebrovascular_disease==5,1,NA)) %>%
    mutate(class="cerebrovascular_disease")%>% select(ageg,yes,no,class)-> t7

klosa  %>% filter(!is.na(mental_illness))  %>% select(ageg,mental_illness) %>% 
    mutate(yes=ifelse(mental_illness==1,1,NA)) %>% mutate(no=ifelse(mental_illness==5,1,NA)) %>% 
    mutate(class="mental_illness")%>% select(ageg,yes,no,class)-> t8

klosa  %>% filter(!is.na(arthritis))  %>% select(ageg,arthritis) %>% 
    mutate(yes=ifelse(arthritis==1,1,NA)) %>% mutate(no=ifelse(arthritis==5,1,NA)) %>% 
    mutate(class="arthritis")%>% select(ageg,yes,no,class)-> t9

klosa  %>% filter(!is.na(prostate_disease))  %>% select(ageg,prostate_disease) %>% 
    mutate(yes=ifelse(prostate_disease==1,1,NA)) %>% mutate(no=ifelse(prostate_disease==5,1,NA)) %>% 
    mutate(class="prostate_disease")%>% select(ageg,yes,no,class)-> t10

rbind(t1,t2,t3,t4,t5,t6,t7,t8,t9,t10) -> a_rbind


sqldf("select ageg,class,sum(yes)/(sum(yes)+sum(no))*100.1 as ratio from a_rbind where ageg='~50s' group by ageg,class order by ageg,ratio desc limit 5") -> a1
sqldf("select ageg,class,sum(yes)/(sum(yes)+sum(no))*100.1 as ratio from a_rbind where ageg='50s' group by ageg,class order by ageg,ratio desc limit 5") -> a2
sqldf("select ageg,class,sum(yes)/(sum(yes)+sum(no))*100.1 as ratio from a_rbind where ageg='60s' group by ageg,class order by ageg,ratio desc limit 5") -> a3
sqldf("select ageg,class,sum(yes)/(sum(yes)+sum(no))*100.1 as ratio from a_rbind where ageg='70s' group by ageg,class order by ageg,ratio desc limit 5") -> a4
sqldf("select ageg,class,sum(yes)/(sum(yes)+sum(no))*100.1 as ratio from a_rbind where ageg='80s' group by ageg,class order by ageg,ratio desc limit 5") -> a5
sqldf("select ageg,class,sum(yes)/(sum(yes)+sum(no))*100.1 as ratio from a_rbind where ageg='80s~' group by ageg,class order by ageg,ratio desc limit 5") -> a6
rbind(a1,a2,a3,a4,a5,a6) -> b_rbind

b_rbind  %>% ggplot(aes(ageg,ratio,fill=class)) + 
    geom_col(position="dodge")+
    labs(y="Ratio",x="Year",title="Chronic disease top 5 by ageg") + 
    theme_grey()+
    scale_fill_discrete(name = "Chronic disease")



hypertension:고혈압
diabetes:당뇨병/고혈당
cancer:암 및 악성종양
lung_disease:폐질환 
liver_disease:간질환
heart_disease:심장질환
cerebrovascular_disease:뇌혈관질환
mental_illness:	정신과적 질환
arthritis:	관절염 또는 류마티스
prostate_disease:전립선 질환


## 삶의 만족도 연령별 
klosa  %>% filter(!is.na(QOL))  %>% select(age,ageg,QOL)-> satisfaction
sqldf("select age,avg(QOL) as avg from satisfaction group by age") ->satisfaction
ggplot(satisfaction,aes(age,avg))+
    geom_line()+
    labs(y="Ratio",x="Age",title="Life satisfaction")+
    ylim(10,75)


klosa %>% filter(!is.na(present_ecotype)) %>% 
    mutate(year=factor(year)) %>% 
    select(year,present_ecotype) %>% 
    count(year,present_ecotype) %>% 
    group_by(year) %>% 
    mutate(total=sum(n)) %>% 
    mutate(pct=round(n/total*100,1))->ecoact_year



library(tidyverse)
library(gridExtra)
klosa=read_csv("Data/klosa.csv")

summary(klosa)

klosa %>% filter((year==2006 & age < 56) |
                     (year==2008 & age < 58) |  
                     (year==2010 & age < 60) |  
                     (year==2012 & age < 62) |  
                     (year==2014 & age < 64) |  
                     (year==2016 & age < 66)) %>% 
    select(year,gender,age,ageg,emp,present_ecotype,earned) %>% mutate(tfr="45to55") -> r1


klosa %>% filter((year==2006 & age > 55 & age < 66) |
                     (year==2008 & age > 57 & age < 68) |  
                     (year==2010 & age > 59 & age < 70) |  
                     (year==2012 & age > 61 & age < 72) |  
                     (year==2014 & age > 63 & age < 74) |  
                     (year==2016 & age > 65 & age < 76)) %>% 
    select(year,gender,age,ageg,emp,present_ecotype,earned) %>% mutate(tfr="56to65") -> r2


klosa %>% filter((year==2006 & age > 65 & age < 76) |
                     (year==2008 & age > 67 & age < 78) |  
                     (year==2010 & age > 69 & age < 80) |  
                     (year==2012 & age > 71 & age < 82) |  
                     (year==2014 & age > 73 & age < 84) |  
                     (year==2016 & age > 75 & age < 86)) %>% 
    select(year,gender,age,ageg,emp,present_ecotype,earned) %>% mutate(tfr="66to75") -> r3


klosa %>% filter((year==2006 & age > 75 & age < 86) |
                     (year==2008 & age > 77 & age < 88) |  
                     (year==2010 & age > 79 & age < 90) |  
                     (year==2012 & age > 81 & age < 92) |  
                     (year==2014 & age > 83 & age < 94) |  
                     (year==2016 & age > 85 & age < 96)) %>% 
    select(year,gender,age,ageg,emp,present_ecotype,earned) %>% mutate(tfr="76to85") -> r4


klosa %>% filter((year==2006 & age > 85 & age < 96) |
                     (year==2008 & age > 87 & age < 98) |  
                     (year==2010 & age > 89 & age < 100) |  
                     (year==2012 & age > 91 & age < 102) |  
                     (year==2014 & age > 93 & age < 104) |  
                     (year==2016 & age > 95 & age < 106)) %>% 
    select(year,gender,age,ageg,emp,present_ecotype,earned) %>% mutate(tfr="86to95") -> r5

klosa %>% filter((year==2006 & age > 95 & age < 106) |
                     (year==2008 & age > 97 & age < 108) |  
                     (year==2010 & age > 99 & age < 110) |  
                     (year==2012 & age > 101 & age < 112) |  
                     (year==2014 & age > 103 & age < 114) |  
                     (year==2016 & age > 105 & age < 116)) %>% 
    select(year,gender,age,ageg,emp,present_ecotype,earned) %>% mutate(tfr="96to115") -> r6

rbind(r1,r2,r3,r4,r5) -> klosabyage

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


##연령별 근로소득의 변화
#######################################################
klosabyage %>% select(year,tfr,earned)%>%  
               filter(!is.na(earned)) %>% 
               mutate(tfr=ifelse(tfr=="45to55","45~55s",
                          ifelse(tfr=="56to65","56~65s",
                          ifelse(tfr=="66to75","66~75s",
                          ifelse(tfr=="76to85","76~85s", "86~95s"))))) %>% 
               rename(agegroup=tfr) %>% 
               group_by(year,agegroup) %>% 
               summarise(mean = mean(earned, na.rm=T)) -> ep1

ep1 %>% ggplot(aes(year,mean,color=agegroup))+geom_line()+ylim(0,3000)
ep1 %>% ggplot(aes(year,mean,color=agegroup))+geom_line()+facet_wrap(~ agegroup)+ylim(0,3000)








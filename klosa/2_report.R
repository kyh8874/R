library(tidyverse)
library(gridExtra)

klosa=read_csv("Data/klosa.csv")

#save(klosa,file="data/klosa.rda")

#load("Data/klosa.rda")

klosa %>% select(year,ageg,present_ecotype) %>% 
    mutate(year=factor(year)) %>% 
    group_by(year,ageg,present_ecotype) %>% 
    summarise(n=n()) ->ecoact_ageg_year

#1. 1 연도별 연령대별 경제활동상태 : present_ecotype   (50대미만, 50대,60대…)

klosa %>%filter(!is.na(present_ecotype)) %>% 
    select(year,ageg,present_ecotype) %>% 
    mutate(year=factor(year)) %>% 
    mutate(present_ecotype=ifelse(present_ecotype==1, "Employment",
                                  ifelse(present_ecotype==2,"Jobless","Inactive"))) %>% 
    count(year,ageg,present_ecotype) %>% 
    group_by(year,ageg,present_ecotype) ->ecoact_ageg_year

#2006~2016
eap1<- ggplot(ecoact_ageg_year[ecoact_ageg_year$year == "2006",], aes(ageg, n, fill=present_ecotype)) +
    geom_col(position='dodge')+
    labs(y="Person",x="Age Group",title="2006 Economic Activity") + 
    theme_grey()+
    scale_fill_discrete(name = "Type")
#theme(legend.position = "bottom")


eap2<- ggplot(ecoact_ageg_year[ecoact_ageg_year$year == "2008",], aes(ageg, n, fill=present_ecotype)) +
    geom_col(position='dodge')+
    labs(y="Person",x="Age Group",title="2008 Economic Activity") + 
    theme_grey()+
    guides(fill="none")  

eap3<- ggplot(ecoact_ageg_year[ecoact_ageg_year$year == "2010",], aes(ageg, n, fill=present_ecotype)) +
    geom_col(position='dodge')+
    labs(y="Person",x="Age Group",title="2010 Economic Activity") + 
    theme_grey() +
    guides(fill="none")  

eap4<-ggplot(ecoact_ageg_year[ecoact_ageg_year$year == "2012",], aes(ageg, n, fill=present_ecotype)) +
    geom_col(position='dodge')+
    labs(y="Person",x="Age Group",title="2012 Economic Activity") + 
    theme_grey() +
    guides(fill="none") 

eap5<- ggplot(ecoact_ageg_year[ecoact_ageg_year$year == "2014",], aes(ageg, n, fill=present_ecotype)) +
    geom_col(position='dodge')+
    labs(y="Person",x="Age Group",title="2014 Economic Activity") + 
    theme_grey() +
    guides(fill="none") 

eap6<- ggplot(ecoact_ageg_year[ecoact_ageg_year$year == "2016",], aes(ageg, n, fill=present_ecotype)) +
    geom_col(position='dodge')+
    labs(y="Person",x="Age Group",title="2016 Economic Activity") + 
    theme_grey() +
    guides(fill="none") 

grid.arrange(eap1, eap2, eap3, eap4, eap5, eap6, nrow = 3)  

#2006,2016
eap06<- ggplot(ecoact_ageg_year[ecoact_ageg_year$year == "2006",], aes(ageg, n, fill=as.factor(present_ecotype))) +
    geom_col(position='dodge')+
    labs(y="Person",x="Age Group",title="2006 Economic Activity") + 
    theme_grey()+
    scale_fill_discrete(name = "Type")

eap16<- ggplot(ecoact_ageg_year[ecoact_ageg_year$year == "2016",], aes(ageg, n, fill=as.factor(present_ecotype))) +
    geom_col(position='dodge')+
    labs(y="Person",x="Age Group",title="2016 Economic Activity") + 
    theme_grey()+
    scale_fill_discrete(name = "Type")


#1. 1 연도별 경제활동상태 : present_ecotype 
# klosa %>% filter(!is.na(present_ecotype)) %>% 
#   mutate(year=factor(year)) %>% 
#   select(year,present_ecotype) %>% 
#   group_by(year,present_ecotype) %>% 
#   summarise(n=n()) ->ecoact_year
# 
# ecoact_year[ecoact_year$year == "2016",], 

klosa %>% filter(!is.na(present_ecotype)) %>% 
    mutate(year=factor(year)) %>% 
    select(year,present_ecotype) %>% 
    count(year,present_ecotype) %>% 
    group_by(year) ->ecoact_year

ggplot(ecoact_year,aes(year, n,fill=as.factor(present_ecotype))) +
    geom_col(position='dodge')+
    labs(y="Person",x="Year",title="Economic Activity") + 
    theme_grey() +
    scale_fill_discrete(name="Type",
                        labels=c("Employment","Jobless","Inactive"))


#1.2 연도별 성별 경제활동
# klosa %>% filter(!is.na(gender)&!is.na(present_ecotype)) %>% 
#     mutate(year=factor(year)) %>% 
#     select(year,gender,present_ecotype) %>% 
#     group_by(year,gender,present_ecotype) %>% 
#     summarise(n=n()) ->ecoact_gender

klosa %>% filter(!is.na(gender)&!is.na(present_ecotype)) %>% 
    mutate(year=factor(year)) %>% 
    select(year,gender,present_ecotype) %>% 
    group_by(year,gender,present_ecotype) %>% 
    summarise(n=n()) %>% 
    mutate(total=sum(n)) %>% 
    mutate(pct=round(n/total*100,1)) ->ecoact_gender_year

eag1<-ggplot(ecoact_gender_year[ecoact_gender_year$gender=="male",],aes(year, pct ,fill=as.factor(present_ecotype))) +
    geom_col()+
    labs(y="Ratio",x="Year",title="Male Economic Activity by year") + 
    theme_grey() +
    scale_fill_discrete(name="Type",
                        labels=c("Employment","Jobless","Inactive"))

eag2<-ggplot(ecoact_gender_year[ecoact_gender_year$gender=="female",],aes(year, pct ,fill=as.factor(present_ecotype))) +
    geom_col()+
    labs(y="Ratio",x="Year",title="Female Economic Activity by year") + 
    theme_grey() +
    scale_fill_discrete(name="Type",
                        labels=c("Employment","Jobless","Inactive"))

grid.arrange(eag1, eag2, nrow = 2 , top ="Economic Activity") 

#2. 연도별 일자리형태: emp
#####################################################
klosa %>% filter(!is.na(emp)&!is.na(year)) %>% 
    select(year,emp) %>% 
    mutate(emps=ifelse(emp==3|emp==4,3,emp)) %>% 
    group_by(year,emps) %>% 
    summarise(n=n()) %>% 
    mutate(total=sum(n)) %>% 
    mutate(pct=round(n/total*100,1))->ecoact_emp_year

ggplot(ecoact_emp_year,aes(as.factor(year), pct ,fill=as.factor(emps))) +
    geom_col(position='dodge')+
    labs(y="Ratio",x="Year",title="Employment Type By Year") + 
    theme_grey() +
    scale_fill_discrete(name="Type",
                        labels=c("Employment","Self-employment","Unpaid"))


# 퍠널 참여인원
klosa %>% count(year) %>% group_by(year)




#1-3 참여 패널의 지역 비율
##########################
klosa %>% filter(!is.na(year)&!is.na(regiong)) %>% 
    select(year,region,regiong) %>% 
    group_by(year,regiong) %>% 
    summarise(n=n()) %>% 
    mutate(total=sum(n)) %>% 
    mutate(pct=round(n/total*100,1)) ->region_by_year

ggplot(region_by_year[region_by_year$year == "2006",],aes(reorder(regiong,n),pct,fill=regiong))+
    geom_col(position="dodge")+
    coord_flip()+
    ggtitle("Ratio By Region")+    
    labs(x="", y="Ratio")+
    guides(fill="none") 

# p1<- ggplot(region_by_year[region_by_year$year == "2006",], aes(regiong, n, fill=regiong)) +
#     #geom_col(position='dodge')+
#     geom_bar(stat='identity')+
#     labs(title="2006") + theme_grey()+
#     theme(legend.position = "bottom")
# 
# p2<- ggplot(region_by_year[region_by_year$year == "2008",], aes(x=regiong, y= n,fill=regiong)) +
#     geom_bar(stat='identity')+
#     labs(title="2008") + theme_grey()
# 
# p3<- ggplot(region_by_year[region_by_year$year == "2010",], aes(x=regiong, y= n,fill=regiong)) +
#     geom_bar(stat='identity')+
#     labs(title="2010") + theme_grey()
# 
# p4<- ggplot(region_by_year[region_by_year$year == "2012",], aes(x=regiong, y= n,fill=regiong)) +
#     geom_bar(stat='identity')+
#     labs(title="2012") + theme_grey()
# 
# p5<- ggplot(region_by_year[region_by_year$year == "2014",], aes(x=regiong, y= n,fill=regiong)) +
#     geom_bar(stat='identity')+
#     labs(title="2014") + theme_grey()
# 
# p6<- ggplot(region_by_year[region_by_year$year == "2016",], aes(x=regiong, y= n,fill=regiong)) +
#     geom_bar(stat='identity')+
#     labs(title="2016") + theme_grey()
# 
# grid.arrange(p1, p2, p3, p4, p5, p6, nrow = 3)



#연도별 성별 histo
#################################################    
klosa %>% filter(!is.na(year)&!is.na(gender)) %>% 
    select(year,gender) %>% 
    mutate(year=factor(year)) %>% 
    group_by(year,gender) %>% 
    summarise(n=n()) %>% 
    mutate(total=sum(n)) %>% 
    arrange(year)-> gender_by_year

gender_by_year %>% ggplot(aes(year, n, fill=gender))+
    #geom_line()
    geom_col(position='dodge')+
    labs(y="Person",x="Year",title="") + 
    theme_grey() +
    scale_fill_discrete(name="Type",
                        labels=c("Fmale","Male"))



#연도별 ageg 비율
####################################################
klosa %>% filter(!is.na(year)&!is.na(ageg)) %>% 
    select(year,ageg) %>% 
    group_by(year,ageg) %>% 
    summarise(n=n()) %>% 
    mutate(total=sum(n)) %>% 
    mutate(pct=round(n/total*100,1))->ageg_by_year

ggplot(ageg_by_year,aes(factor(year) ,pct,fill=ageg))+
    geom_col(position="dodge")+
    ggtitle("Age Ratio By Year")+    
    labs(x="Year", y="Ratio")

#연도별 세대
####################################################
klosa %>% filter(!is.na(family)) %>% 
    select(year,family) %>% 
    group_by(year,family) %>% 
    summarise(n=n()) %>% 
    mutate(total=sum(n))%>% 
    mutate(pct=round(n/total*100,1)) -> family_by_year

ggplot(family_by_year,aes(factor(year) ,pct,fill=factor(family)))+
    geom_col(position="dodge")+
    ggtitle("Family member by year")+    
    labs(x="Year", y="Ratio") + 
    theme_grey() +
    scale_fill_discrete(name="Family",
                        labels=c("1G","2G","3G","4G","Etc"))


# klosa %>% filter(!is.na(year)&!is.na(ageg)) %>% 
#     select(year,ageg) %>% 
#     group_by(ageg,year) %>% 
#     summarise(n=n()) %>% 
#     mutate(total=sum(n)) %>% 
#     arrange(desc(ageg)) ->ageg_by_year
# 
# p1<- ggplot(ageg_by_year[ageg_by_year$year == "2006",], aes(ageg, n, fill=ageg)) +
#     #geom_col(position='dodge')+
#     geom_bar(stat='identity')+
#     labs(title="2006") + theme_grey() 
# p2<- ggplot(ageg_by_year[ageg_by_year$year == "2008",], aes(ageg, n, fill=ageg)) +
#     #geom_col(position='dodge')+
#     geom_bar(stat='identity')+
#     labs(title="2008") + theme_grey() 
# p3<- ggplot(ageg_by_year[ageg_by_year$year == "2010",], aes(ageg, n, fill=ageg)) +
#     #geom_col(position='dodge')+
#     geom_bar(stat='identity')+
#     labs(title="2010") + theme_grey() 
# p4<- ggplot(ageg_by_year[ageg_by_year$year == "2012",], aes(ageg, n, fill=ageg)) +
#     #geom_col(position='dodge')+
#     geom_bar(stat='identity')+
#     labs(title="2012") + theme_grey() 
# p5<- ggplot(ageg_by_year[ageg_by_year$year == "2014",], aes(ageg, n, fill=ageg)) +
#     #geom_col(position='dodge')+
#     geom_bar(stat='identity')+
#     labs(title="2014") + theme_grey() 
# p6<- ggplot(ageg_by_year[ageg_by_year$year == "2016",], aes(ageg, n, fill=ageg)) +
#     #geom_col(position='dodge')+
#     geom_bar(stat='identity')+
#     labs(title="2016") + theme_grey() 
# 
# grid.arrange(p1, p2, p3, p4, p5, p6, nrow = 3)




ageg_by_year %>% ggplot(aes(year, n, color=ageg))+
    geom_line()
#geom_col(position='dodge')



klosa %>% filter((year==2006 & age < 56) |
                     (year==2008 & age < 58) |  
                     (year==2010 & age < 60) |  
                     (year==2012 & age < 62) |  
                     (year==2014 & age < 64) |  
                     (year==2016 & age < 66)) %>% 
    select(pid, year) %>% 
    arrange(pid, year)->sub_45to55

klosa %>% filter((year==2006 & age > 55 & age < 66) |
                     (year==2008 & age > 57 & age < 68) |  
                     (year==2010 & age > 59 & age < 70) |  
                     (year==2012 & age > 61 & age < 72) |  
                     (year==2014 & age > 63 & age < 74) |  
                     (year==2016 & age > 65 & age < 76)) %>% 
    select(pid, year) %>% 
    arrange(pid, year)->sub_56to65

klosa %>% filter((year==2006 & age > 65 & age < 76) |
                     (year==2008 & age > 67 & age < 78) |  
                     (year==2010 & age > 69 & age < 80) |  
                     (year==2012 & age > 71 & age < 82) |  
                     (year==2014 & age > 73 & age < 84) |  
                     (year==2016 & age > 75 & age < 86)) %>% 
    select(pid, year) %>% 
    arrange(pid, year)->sub_66to75

klosa %>% filter((year==2006 & age > 75 & age < 86) |
                     (year==2008 & age > 77 & age < 88) |  
                     (year==2010 & age > 79 & age < 90) |  
                     (year==2012 & age > 81 & age < 92) |  
                     (year==2014 & age > 83 & age < 94) |  
                     (year==2016 & age > 85 & age < 96)) %>% 
    select(pid, year) %>% 
    arrange(pid, year)->sub_76to85





select(year,age) %>% 
    filter(age==47)


# Make 3 simple graphics:
g1=ggplot(mtcars, aes(x=qsec)) + geom_density(fill="slateblue")
g2=ggplot(mtcars, aes(x=drat, y=qsec, color=cyl)) + geom_point(size=5) + theme(legend.position="none")
g3=ggplot(mtcars, aes(x=factor(cyl), y=qsec, fill=cyl)) + geom_boxplot() + theme(legend.position="none")
g4=ggplot(mtcars , aes(x=factor(cyl), fill=factor(cyl))) +  geom_bar()

# Show the 4 plots on the same page
grid.arrange(g1, g2, g3, g4, ncol=2, nrow =2)

# Plots
grid.arrange(g2, arrangeGrob(g3, g4, ncol=2), nrow = 2)
grid.arrange(g1, g2, g3, nrow = 3)
grid.arrange(g2, arrangeGrob(g3, g4, ncol=2), nrow = 1)
grid.arrange(g2, arrangeGrob(g3, g4, nrow=2), nrow = 1)


scale_color_manual(values = c("Green","Red"),
                   name = "Transmission",
                   breaks = c(1,0), 
                   labels = c("Manual","Auto"))
ggtitle("HP과 MPG의 관계2")

theme(legend.position = "bottom")


scale_fill_manual(values = c("red","green"),
                  name = ("범례제목"),
                  breaks = c(0,1),
                  labels = c("값1","값2"))

[출처] 29. R의 시각화(그래프) 기능(11) - ggplot2 사용법(기타 : 범례, 레이블, 텍스트 추가 등)|작성자 바른인간

https://blog.naver.com/definitice/221165151283



* scale_color_manual()은 점 및 선 그래프, 
scale_fill_manual()은 막대 그래프 등에 적용됨을 기억하자. 

scale_fill_discrete(name="범례제목",   breaks = c(0,1),labels=c("값1","값2"))















klosa %>% filter(year==2016) %>% 
    select(year,age) %>% 
    filter(age > 96)

arrange(desc(age))

klosa %>% filter(year==2016) %>% 
    select(year,age) %>% 
    arrange(age)
#arrange(desc(age))
library(tidyverse)
library(plotly)
library(sqldf)

# 분석 절차
# 1. 변수 검토 및 전처리
#  • 나이
#  • 월급
# 2. 변수 간 관계 분석
#  • 나이에 따른 월급 평균표 만들기
#  • 그래프 만들기

load("koweps/welfare.rda")
summary(welfare)

# 09-3. 나이와 월급의 관계
# birth의 검토
table(is.na(welfare$birth))
welfare[order(welfare$birth),"birth"] %>% head(10)
welfare[order(-welfare$birth),"birth"] %>% head(10)

#양적자료 유효한 그래프(boxplot,histogram)
qplot(x='group',y=birth, data= welfare, geom='boxplot')
qplot(x=birth, data=welfare, geom='histogram', breaks=seq(1900,2014, by=20))  #직관적이지 못함

# age파생변수 만듬 inplace로 정제된 전처리에 추가하고 데이터를 저장하도록 할것
# welfare$age = 2015-welfare$birth+1

summary(welfare)
table(is.na(welfare$age))
welfare[order(welfare$age),"age"] %>% head(10)
welfare[order(-welfare$age),"age"] %>% head(10)

qplot(x='group',y=age, data= welfare, geom='boxplot')
qplot(x=age, data=welfare, geom='histogram', breaks=seq(0,110, by=10))  #직관적

#2. incomebyage
#    ㄱ. 나이별 평균 월급요약표
welfare %>% filter(!is.na(income)) %>% 
    group_by(age) %>% 
    summarise(mean=mean(income)) ->incomebyage

#나이를 시계열자료로 보고 라인그래프를 활용
incomebyage %>% ggplot(aes(age,mean))+geom_col()
ggplot(incomebyage,aes(age,mean))+geom_line()


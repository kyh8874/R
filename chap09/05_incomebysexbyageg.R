# 09-5. 연령대 및 성별 월급 차이
# - "성별 월급 차이는 연령대별로 다를까?"
# 분석 절차
# 1. 변수 검토 및 전처리
# • 연령대
# • 성별
# • 월급
# 2. 변수 간 관계 분석
# • 연령대 및 성별 월급 평균표 만들기
# • 그래프 만들기

library(tidyverse)
library(sqldf)
load("koweps/welfare.rda")

# 1. 연령대 및 성별 월급 평균표 만들기 
welfare %>% filter(!is.na(income)) %>% 
            select(ageg,income,sex) %>% 
            group_by(ageg,sex) %>% 
            summarise(mean_income=mean(income)) ->incomebysexbyageg

incomebysexbyageg
# 2. 그래프 만들기 (x=ageg v= mean_income, fill=sex)
incomebysexbyageg %>% ggplot(aes(ageg,mean_income, fill=sex))+
                      geom_col(position='dodge') +
                      scale_x_discrete(limits=c('young','middle','old'))

# 1. 나이에 따른 성별 월급 평균표 만들기 
welfare %>% filter(!is.na(income)) %>% 
            select(sex,age,income) %>% 
            group_by(age,sex) %>% 
            summarise(mean_income=mean(income))->incomebyage


# 2. 그래프 만들기 (x=age v= mean_income, fill=sex)  ===> line
incomebyage %>% ggplot(aes(age,mean_income,color=sex))+
                geom_line()

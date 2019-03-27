## 나이 및 성별 월급차이(incomebyagebysex) -성별 월급차이는 나이별로 다를까?
library(tidyverse)

### 데이터LOAD
load("koweps/welfare_2016.rda")

### 나이 및 성별 월급 평균표
welfare %>% filter(!is.na(income)) %>% 
    select(sex,age,income) %>% 
    group_by(age,sex) %>% 
    summarise(mean_income=mean(income))->incomebyage

### 그래프 만들기
incomebyage %>% ggplot(aes(age,mean_income,color=sex))+
                geom_line()

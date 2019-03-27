## 나이와 월급의 관계(incomebyage) - 몇 살때 월급을 가장 많이 받을까?
library(tidyverse)

### 데이터LOAD
load("koweps/welfare_2016.rda")

### 나이변수 전처리 
table(is.na(welfare$birth))
welfare[order(welfare$birth),"birth"] %>% head(10)
welfare[order(-welfare$birth),"birth"] %>% head(10)

### 변수추가 및 나이계산
#### welfare$age = 2016-welfare$birth+1

### 전처리추가
#### welfare %<>% mutate(sex=ifelse(sex==1, "male","female")) %>% 
####             mutate(income=ifelse(income==0, NA,  income)) %>% 
####             mutate(age = 2016-welfare$birth+1) -> welfare
#### 데이터 저장
#### save(welfare,file="koweps/welfare_2016.rda")

### 나이별 평균 월급요약표
welfare %>% filter(!is.na(income)) %>% 
    group_by(age) %>% 
    summarise(mean=mean(income)) ->incomebyage

### 라인그래프
ggplot(incomebyage,aes(age,mean))+geom_line()

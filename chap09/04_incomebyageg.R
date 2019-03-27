# 09-4. 연령대에 따른 월급 차이
# - "어떤 연령대의 월급이 가장 많을까?"
 
# 분석 절차
#  1.icomebysex
#  2.incomebyage
#  3.incomrbyageg
###########################
# 1. 변수 검토 및 전처리
# - 연령대
# - 월급
# 2. 변수 간 관계 분석
# - 연령대별 월급 평균표 만들기
# - 그래프 만들기
###########################
library(tidyverse)
library()
# 1. 연령대 변수 검토 및 전처리하기
# 파생변수 만들기 - 연령대
load("koweps/welfare.rda") #바이너리 데이터 ==> 대용량의 load는 속도문제 발생 
summary(welfare)

welfare$ageg = ifelse(welfare$age < 30, 'young',
                      ifelse(welfare$age < 60, 'middle','old'))
summary(welfare$ageg)
table(is.na(welfare$ageg))
table(welfare$ageg)

qplot(welfare$ageg)
ggplot(welfare, aes(ageg))+geom_bar()

#01_preprocessing에 정제과정 추가 

welfare %>% filter(!is.na(income)) %>% 
            select(ageg, income) %>% 
            group_by(ageg) %>% 
            summarise(mean_income=mean(income)) ->incombyageg

incombyageg %>% ggplot(aes(ageg,mean_income))+
                geom_bar(stat='identity')+
                # 출력 순서를 변경==> x축이 질적자료일경우 사용
                scale_x_discrete(limits=c('young','middle','old')) 


qplot(incomebyageg,)

#sqldf
library(sqldf)
sqldf("
       select ageg, avg(income) as mean from welfare
          where income is not null
          group by ageg
      ") ->sqldfincome
sqldfincome %>% ggplot(aes(ageg, mean))+
                geom_col()+
                scale_x_discrete(limits=c('young','middle','old'))

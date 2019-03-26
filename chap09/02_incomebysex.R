library(tidyverse)
library(plotly)
load("koweps/welfare.rda")
summary(welfare)

#
# sex (질적자료, 명목자료 범주형자료)  ===>factor, charactor
#  1. NA 확인  
table(is.na(welfare$sex))
#  2. Outlier 확인
table(welfare$sex)
#  3. 1==> male   2==> female 
welfare$sex = ifelse(welfare$sex==1, "male", "female")
table(welfare$sex)

#  4. table 함수로 빈도확인
table(is.na(welfare$sex))
#  5. qplot 빈도막대 그래프
qplot(sex, data=welfare) %>% ggplotly()
ggplotly(ggplot(welfare, aes(sex)) + geom_bar())

# income (양적자료 ,  연속형자료)
#  1. NA 확인
table(is.na(welfare$income))

#  2. extream value 확인
welfare %>% filter(!is.na(income)) %>% 
    select(income) %>% 
    arrange(income) %>% head(20)

welfare %>% filter(!is.na(income)) %>% 
    select(income) %>% 
    arrange(desc(income)) %>% head(20)

welfare$income =ifelse(welfare$income==0, NA, welfare$income)

library(sqldf)
# count = null 포함
sqldf("select avg(income) from welfare")

# 3. boxplot
boxplot(welfare$income)
boxplot(welfare$income)$stats

###################
wel<-welfare
wel$income=ifelse(wel$income <0.46 | wel$income > 606.5, NA , wel$income )
table(is.na(wel$income))
wel %>% filter(!is.na(wel$income )) ->aa
qplot(y=income, data=aa, geom = "boxplot")
boxplot(wel$income)$stats
##################

qplot(y=income,data=welfare,geom = "boxplot")
ggplot(welfare,aes(y=income,x="total"))+geom_boxplot()

# 4. histogram
#breaks x축 단위 변경 ( by=100, 100 200 300 400 500   by=200, 200 400)

qplot(income,data=welfare,breaks=seq(0,2400, by=200))


ggplot(welfare,aes(x=income))+geom_histogram(breaks=seq(0,2400, by=200))

qplot(sex,data=welfare)

# ggplot(welfare,aes(x=sex))+geom_histogram(breaks=seq(0,2400, by=200))

# summarize(x) , summary()

summary(welfare)

# income by sex 
# 1. 평균 요약 테이블

## NA 제거 옵션 필수 추가 na.rm=T
welfare %>% summarise(mean(welfare$income,na.rm = T))

# 1. 성별 월급 평균표 만들기
welfare %>% group_by(sex) %>% summarise(mean_income=mean(income,na.rm = T))->incomebysex
ggplot(data = incomebysex, aes(x = sex, y = mean_income)) + geom_col()
ggplot(data = incomebysex, aes(x = sex, y = mean_income)) + geom_bar(stat="identity")


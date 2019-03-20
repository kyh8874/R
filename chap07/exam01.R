library(tidyverse)
library(sqldf)
mpg %>% filter(cty >30)


#데이터정제(Data Cleansing)
# 1.Missing Value (빠진데이터, 없는데이터)   => NA, NaN로 표시
#
# 2.Outlier(이상치) 타입 문자형자료 ==> 질적자료  / 이상치 표시 NA
#
# 3.Extreme Value(극단치) 타입 수치형자료  ==> 양적자료  / 극단치 NaN
#
#  데이터    1.양적자료(수치타입)
#              - 연속형자료  ==> 실수타입  - 키, 몸무게 (근사치)    
#              - 이산형자료  ==> 정수타입  - 한개, 두개...
#            2.질적자료(문자타입)  ===>-범주형자료
#              - 순위형자료  ====> 범주형자료+순위 or 크기가 있다면 (R ==> factor java==> enum)
#              - 명목형자료(범주형자료)  ====>월, 화, 수, 목....남,여
#


exam = read_csv("Data/csv_exam.csv")

#NA가 있는지 검사
is.na(exam)

#테이블로 빈도 출력
table(is.na(exam))

exam[exam$math>80,]$math =NA
exam

exam$math
table(is.na(exam$math))

table(is.na(exam$english))

mean(is.na(exam$math))
sum(is.na(exam$math))

exam %>% filter(is.na(exam$math))







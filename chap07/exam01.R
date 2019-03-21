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

#
#  명목형자료, 순위형자료
#

gender = c("male","female","male","male","female")    
f_gender = factor(gender, levels = c("male","female"))  # 명목형자료
o_gender = factor(gender, levels = c("male","female"), ordered = T)  #순위형 자료로 만듬 
f_gender
o_gender
sort(gender)
sort(f_gender)  
sort(o_gender)  

#명목형자료는 대소로 구분을 할 수없다
f_gender[1] > f_gender[2]

#순위형자료는 대소로 표현이 된다
o_gender[1] > o_gender[2]

#factor의 범위를 벗어남===>NA
f_gender[1] ="aaa"
f_gender

jumsu = c(1,1,5,5,4,3,2,3,3,3,4)
f_jumsu=factor(jumsu)
f_jumsu

f_jumsu=factor(jumsu, levels=c(5,4,3,2,1))
f_jumsu

f_jumsu=factor(jumsu, levels=c(5,4,3,2,1), ordered = T)
f_jumsu

f_jumsu[1] = 7
f_jumsu

f_jumsu[1] = 4

jumsu = c(1,1,5,5,4,3,2,3,3,3,4)
f_jumsu=factor(jumsu, levels=c(5,1,2,3,4))
sort(jumsu)
sort(f_jumsu)

#명목형자료는 순위비교 안됨
f_jumsu
f_jumsu[1] > f_jumsu[2]



#결측치 확인하기
###########

#1. 결측치 확인
#     is.na(df)

#2. 결측치 빈도 출력
#     table(is.na(df))

#3.결측치 있는 행 제거하기====>!is.na(score)
#    df %>% filter(!is.na(score))
#    df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))

#4. 결측치가 하나라도 있으면 제거하기====>na.omit(df)
#     # 모든 변수에 결측치 없는 데이터 추출
#     df_nomiss2 <- na.omit(df)

#5.함수의 결측치 제외 기능 이용하기====> (na.rm)
#    mean(df$score, na.rm = T)
#    sum(df$score, na.rm = T)

#   exam %>% summarise(mean_math = mean(math, na.rm = T),
#                                                 sum_math = sum(math, na.rm = T),
#                                                 median_math = median(math, na.rm = T))

boxplot(mpg$hwy)$stats
boxplot(mpg$hwy,mpg$stats,data=mpg)


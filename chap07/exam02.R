library(tidyverse)

#data frame 
exam_df=read.csv("Data/csv_exam.csv")

#tibble
exam_tbl=read_csv("Data/csv_exam.csv")

#tibble자료 변환
exam_df=as_tibble(exam_df)
exam_df
exam_tbl

#y=x로 표현 ==> hwy~fl
boxplot(hwy~fl, data=mpg)
#factor와 levels로 순서를 바꾼다 
boxplot(hwy~factor(fl,levels=c("p","r","c","e","d")), data=mpg)

boxplot(mpg$hwy)$stats

qplot(fl,hwy, data=mpg, geom="boxplot")
#factor와 levels로 순서를 바꾼다 
qplot(factor(fl,levels=c("p","r","c","e","d")),hwy, data=mpg, geom="boxplot")




mpg$fl
#빈도 테이블생성
table(mpg$fl)

#출력순서 변경하고 싶다===> factor 타입 변환
a<-table(factor(mpg$fl, levels = c("p","r","e")))
table(factor(mpg$fl, levels = c("p","r","e"),ordered = T))
a[1]>a[2]

library(tidyverse)
exam=read_csv("Data/csv_exam.csv")

#열 인덱싱
exam[c(T,F,T,T,F)]
exam[c("id","math","english")]
exam[c(1,3,4)] #열 정수 인덱싱

#행 정수 인덱싱
exam[c(1,3,4),]
exam[c("1","3","4"),]


#열 인덱싱 다른방법(정규식을 이용)
#label value
names(exam)
colnames(exam)
rownames(exam)

str_match(colnames(exam),"a")

str_detect(colnames(exam),"a")->x

exam[x]

#"a" or "h"
str_detect(colnames(exam),"a|h")
exam[str_detect(colnames(exam),"a|h")]

var1 <- c(1,2,3,1,2)
var2 <- factor(c(3,2,3,1,2))
var1
var2[5]        

x <- boxplot(mpg$cty)
x

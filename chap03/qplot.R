sample(seq(1,10, length.out=100), replace = T, size = 1000) -> data1

length(data1)
str(data1)
table(data1)
qplot(data1)


sample(c('a','b','c','d'),100,replace=T, prob=c(0.2,0.5,0.9,0.3))->data2
table(data2)
qplot(data2)

library(sqldf)

c(80, 60, 70, 50, 90)-> exam
exam
sum(exam)/5 -> avg_exam
avg_exam

mean(exam)


seq(1,45,length.out=6)

seq()
sample(seq(1,45,length.out=100), replace=T,size=1000) -> loo
loo

sample(seq(1,45,length.out=45), replace=T,size=1000) -> lo
lo%/%1 ->to
table(to)       
qplot(to)


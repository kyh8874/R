library(ggplot2)
library(sqldf)
library(dplyr)
exam=read.csv("Data/csv_exam.csv")
#1.dplyr
exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math), 
            n = n())

#2.sql
sqldf("
      select class, 
             avg(math) as mean_math,
             sum(math) as sum_matm,
             avg(math) as median_math,
             avg(math) as n
         from exam
         group by class  
      ")
#R syntax
#for 문을 사용하기위한 그룹정보

exam[exam$class==1,"math"]
sum(exam$math)
v_class=unique(exam$class)
for (class in v_class) {
     print(paste(class," 그룹"))       
  
     #split
     group_temp=exam[exam$class==class,"math"]
     
     #apply
     mean_math=mean(group_temp)
     sum_math=sum(group_temp)
     median_math=median(group_temp)
     n=length(group_temp)
     group_temp=data.frame(class,mean_math,sum_math,median_math,n)
     #ifelse(which(unique(exam$class)==class)==1, result=group_temp, result=rbind(result,group_temp))
     v_class=unique(exam$class)
     #combine
     if (which(v_class==class)==1)
         result =group_temp
    else
       result= rbind(result,group_temp)

     
     print(group_temp)
     print('============')
     print(result)
}

head(result[order(-result$median_math),],5)

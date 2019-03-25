library(tidyverse)
library(plotly)
library(lubridate)
str(economics)
economics
economics_long
ggplot(data = economics, aes(x = date, y = psavert, color=psavert)) + 
       geom_line()+
       xlim(c('1999-07-01' ,'2015-12-01'))

ggplot(data = economics, aes(x = date, y = psavert, color=psavert)) + 
    geom_line()+
    xlim(c(ymd(1999-07-01) ,ymd(20151201)))

now()
date()
ymd('2019-01-01')
class(ymd('2019-01-01'))         
ymd('2019-01-01')+100
now()
now()+100


#반별 과목범수

#과목별 반의 점수 분포
exam=read_csv("Data/csv_exam.csv")
exam_long = gather(exam, "subject" , "score", math:science)



exam_long %>% ggplot(aes("total",score))+geom_boxplot()
exam_long %>% ggplot(aes("total",score))+geom_boxplot()+geom_jitter()
exam_long %>% ggplot(aes(subject,score))+geom_boxplot()
exam_long %>% ggplot(aes(subject,score, color=factor(class)))+geom_boxplot()
exam_long %>% ggplot(aes(factor(class),score, color=subject))+geom_boxplot()

exam_long$class = factor(exam_long$class)                     
exam_long %>% ggplot(aes(class,score, color=subject))+geom_boxplot()


mpg%>% filter(class %in% c("compact","subcompact", "suv")) %>% 
    ggplot(aes(class,cty, color=drv))+geom_boxplot()+geom_jitter()

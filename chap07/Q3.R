# • 문제 3. 분류표의 기준에 따라 미성년 비율 등급 변수를 추가하고, 
# 각 등급에 몇 개의 지역이 있는지 알아보세요.
# 분류 기준
# large 40% 이상
# middle 30% ~ 40% 미만
# small  30% 미만
library(tidyverse)
library(sqldf)
midwest=as.data.frame(ggplot2::midwest)
#dplyr
mid_df <- midwest %>%
    mutate(ratio_child = (poptotal-popadults)/poptotal*100) 

mid_df %>% select(county,ratio_child) %>% 
           mutate(grade=ifelse(ratio_child>=40,'large',
                               ifelse(ratio_child<30,'small','middle'))) %>% 
           group_by(grade) %>% 
           summarise(n=n())
                

#sqldf
sqldf("select *, (poptotal-popadults)/(poptotal*1.)*100 as ratio_child
          from midwest
          ")  ->sql_df

sqldf("select grade, count(*) as n
          from (
                 select ratio_child, 
                    case 
                     when ratio_child >= 40 then 'large'
                     when ratio_child < 30 then 'small'
                     else 'middle'
                    end as grade   
                 from sql_df)
          group by grade
      ")

#R
midwest$ratio_child = (midwest$poptotal-midwest$popadults)/midwest$poptotal*100

midwest$grade = ifelse(midwest$ratio_child>=40,'large',
                      ifelse(midwest$ratio_child<30,'small','middle'))

midwest

v_grade=unique(midwest$grade)
v_grade
for (grade in v_grade) {
     group_temp=midwest[midwest$grade==grade,"grade"]
    n=length(group_temp)
    group_temp=data.frame(grade,n)
    if (which(v_grade==grade)==1)
        result =group_temp
    else
        result= rbind(result,group_temp)
  
}
result

# 문제 1. popadults 는 해당 지역의 성인 인구, poptotal 은 전체 인구를 나타냅니다. 
# midwest 데이터에 '전체 인구 대비 미성년 인구 백분율' 변수를 추가하세요.
library(tidyverse)
library(sqldf)
midwest=as.data.frame(ggplot2::midwest)
#dplyr
mid_df <- midwest %>%
    mutate(ratio_child = (poptotal-popadults)/poptotal*100) 
str(mid_df)
#sqldf
sqldf("select *, (poptotal-popadults)/(poptotal*1.)*100 as ratio_child
          from midwest
          ")  ->sql_df
str(sql_df)
#R
midwest$ratio_child = (midwest$poptotal-midwest$popadults)/midwest$poptotal*100
str(midwest)

# • 문제 2. 미성년 인구 백분율이 가장 높은 상위 5 개 county(지역)의 미성년 인구 백분율을 출력하세요.
library(tidyverse)
library(sqldf)
midwest=as.data.frame(ggplot2::midwest)
#dplyr
mid_df <- midwest %>%
    mutate(ratio_child = (poptotal-popadults)/poptotal*100) 

mid_df %>% arrange(desc(ratio_child)) %>% 
    select(county,ratio_child) %>% 
    head(5)    

#sqldf
sqldf("select *, (poptotal-popadults)/(poptotal*1.)*100 as ratio_child
          from midwest
          ")  ->sql_df

sqldf("
      select county,ratio_child
        from sql_df
        order by ratio_child desc
        limit 5 
      ")

#R
midwest$ratio_child = (midwest$poptotal-midwest$popadults)/midwest$poptotal*100
head(midwest[order(-midwest$ratio_child),c("county","ratio_child")],5)

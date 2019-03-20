# 문제4. popasian은 해당 지역의 아시아인 인구를 나타냅니다. '전체 인구 대비 아시아인 인구 백분율'
# 변수를 추가하고, 하위 10개 지역의 state(주), county(지역명), 아시아인 인구 백분율을 출력하세요.
library(tidyverse)
library(sqldf)
midwest=as.data.frame(ggplot2::midwest)
#dplyr
midwest %>% mutate(ratio_asian=popasian/poptotal*100) %>% 
    arrange(ratio_asian) %>% 
    select(state,county,ratio_asian) %>% 
    head(10) 
#sqldf
sqldf("
      select state, county, popasian/(poptotal*1.)*100 as ratio_asian 
             from midwest
             order by ratio_asian
             limit 10
      ")
#R
midwest$ratio_asian = midwest$popasian/midwest$poptotal*100
head(midwest[order(midwest$ratio_asian),c("state", "county","ratio_asian")],10)

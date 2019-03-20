# 미국 동북중부 437개 지역의 인구통계 정보를 담고 있는 midwest 데이터를 사용해 데이터 분석 문제를
# 해결해 보세요. midwest는 ggplot2 패키지에 들어 있습니다.
# •
# 문제 1. popadults 는 해당 지역의 성인 인구, poptotal 은 전체 인구를 나타냅니다. midwest 데이터에
# '전체 인구 대비 미성년 인구 백분율' 변수를 추가하세요.
# • 문제 2. 미성년 인구 백분율이 가장 높은 상위 5 개 county(지역)의 미성년 인구 백분율을 출력하세요.
# • 문제 3. 분류표의 기준에 따라 미성년 비율 등급 변수를 추가하고, 각 등급에 몇 개의 지역이 있는지
# 알아보세요.
# 분류 기준
# large 40% 이상
# middle 30% ~ 40% 미만
# small
# •
# 30% 미만
# 문제4. popasian은 해당 지역의 아시아인 인구를 나타냅니다. '전체 인구 대비 아시아인 인구 백분율'
# 변수를 추가하고, 하위 10개 지역의 state(주), county(지역명), 아시아인 인구 백분율을 출력하세요.
# 미국 동북중부 437개 지역의 인구통계 정보를 담고 있는 midwest 데이터를 사용해 데이터 분석 문제를
# 해결해 보세요. midwest는 ggplot2 패키지에 들어 있습니다.
# •
# 문제 1. popadults 는 해당 지역의 성인 인구, poptotal 은 전체 인구를 나타냅니다. midwest 데이터에
# '전체 인구 대비 미성년 인구 백분율' 변수를 추가하세요.
# • 문제 2. 미성년 인구 백분율이 가장 높은 상위 5 개 county(지역)의 미성년 인구 백분율을 출력하세요.
# • 문제 3. 분류표의 기준에 따라 미성년 비율 등급 변수를 추가하고, 각 등급에 몇 개의 지역이 있는지
# 알아보세요.
# 분류 기준
# large 40% 이상
# middle 30% ~ 40% 미만
# small
# •
# 30% 미만
# 문제4. popasian은 해당 지역의 아시아인 인구를 나타냅니다. '전체 인구 대비 아시아인 인구 백분율'
# 변수를 추가하고, 하위 10개 지역의 state(주), county(지역명), 아시아인 인구 백분율을 출력하세요.

library(tidyverse)
library(sqldf)

# 문제 1. popadults 는 해당 지역의 성인 인구, poptotal 은 전체 인구를 나타냅니다. 
# midwest 데이터에 '전체 인구 대비 미성년 인구 백분율' 변수를 추가하세요.
midwest1=as.data.frame(ggplot2::midwest)
#dplyr
mid_df <- midwest1 %>%
    mutate(ratio_child = (poptotal-popadults)/poptotal*100) 
mid_df
#sqldf
sqldf("select *, (poptotal-popadults)/(poptotal*1.)*100 as ratio_child
          from midwest1
          ")  ->sql_df
sql_df
#R
midwest1$ratio_child = (midwest$poptotal-midwest$popadults)/midwest$poptotal*100
midwest1

# • 문제 2. 미성년 인구 백분율이 가장 높은 상위 5 개 county(지역)의 미성년 인구 백분율을 출력하세요.
#dplyr
mid_df %>% arrange(desc(ratio_child)) %>% 
  select(county,ratio_child) %>% 
  head(5)    

#sqldf
sqldf("
      select county,ratio_child
        from sql_df
        order by ratio_child desc
        limit 5 
      ")

#R
head(midwest[order(-midwest$ratio_child),c("county","ratio_child")],5)


# • 문제 3. 분류표의 기준에 따라 미성년 비율 등급 변수를 추가하고, 
# 각 등급에 몇 개의 지역이 있는지 알아보세요.
# 분류 기준
# large 40% 이상
# middle 30% ~ 40% 미만
# small  30% 미만

#dplyr
mid_df %>% mutate(grade=ifelse(ratio_child>=40,'large',
                               ifelse(ratio_child<30,'small','middle'))) %>% 
            select(ratio_child,grade)       

mid_df
#sqldf
sqldf("
      select ratio_child, 
               case 
                  when ratio_child >= 40 then 'large'
                  when ratio_child < 30 then 'small'
                  else 'middle'
               end as grade   
         from sql_df
      ")

#R
mid_df$grade = ifelse(mid_df$ratio_child>=40,'large',
                      ifelse(mid_df$ratio_child<30,'small','middle'))

mid_df

# 문제4. popasian은 해당 지역의 아시아인 인구를 나타냅니다. '전체 인구 대비 아시아인 인구 백분율'
# 변수를 추가하고, 하위 10개 지역의 state(주), county(지역명), 아시아인 인구 백분율을 출력하세요.

midwest4=as.data.frame(ggplot2::midwest)
#dplyr
midwest4 %>% mutate(ratio_asian=popasian/poptotal*100) %>% 
            arrange(ratio_asian) %>% 
            select(state,county,ratio_asian) %>% 
            head(10) 
#sqldf
sqldf("
      select state, county, popasian/poptotal*100 as ratio_asian 
             from midwest4
             order by ratio_asian
             limit 10
      ")
#R
 midwest4$ratio_asian = midwest4$popasian/midwest4$poptotal*100
 head(midwest4[order(midwest4$ratio_asian),c("state", "county","ratio_asian")],10)


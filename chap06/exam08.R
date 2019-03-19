library(tidyverse)
library(sqldf)
library(RSQLite)
library(DBI)
#세로로 합치기
#데이터 생성
# 학생 1~5 번 시험 데이터 생성
group_a <- data.frame(id = c(1, 2, 3, 4, 5,11),
                      test = c(60, 80, 70, 90, 85,100))

# 학생 6~10 번 시험 데이터 생성
group_b <- data.frame(id = c(6, 7, 8, 9, 10,11),
                      test = c(70, 83, 65, 95, 80,100))
#sqldf
sqldf("
      select * from group_a
      union 
      select * from group_b
      ")

#중복허용 union all===>bind_rows()
sqldf("
      select * from group_a
      union all 
      select * from group_b
      ")

bind_rows(group_a, group_b)

#dplyr
group_a %>% bind_rows(group_b) 
#중복제거
group_a %>% bind_rows(group_b) %>% distinct


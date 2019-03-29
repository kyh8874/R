# 09-8. 종교 유무에 따른 이혼율
# - "종교가 있는 사람들이 이혼을 덜 할까?
# 분석 절차
# 1. 변수 검토 및 전처리
# • 종교
# • 혼인 상태
# 2. 변수 간 관계 분석
# • 종교 유무에 따른 이혼율 표 만들기
# • 그래프 만들기
library(tidyverse)
load("koweps/welfare.rda")

#1.데이터정제
# 1.종교 1.있음    2.없음
# 혼인상태 : 0.비해당(18세 미만)  1.유배우 2.사별 3.이혼 4.별거          
#            5.미혼(18세이상, 미혼모 포함)   6.기타(사망 등)
#  혼인상태 1. 3.으로 이혼율을 계산
class(welfare$religion)
table(welfare$religion)

# 전처리 테스트
welfare %>% mutate(religion=ifelse(religion ==1 ,"yes" , "no" )) %>%
            mutate(group_marriage=(ifelse(marriage==1, "marriage",
                                          ifelse(marriage==3,"divors",NA)))) %>% 
            select(religion,group_marriage) %>% 
            count(religion,group_marriage) 

# 전처리과정에 추가
# mutate(religion=ifelse(religion ==1 ,"yes" , "no" )) %>%
#     mutate(group_marriage=(ifelse(marriage==1, "marriage",
#                                   ifelse(marriage==3,"divors",NA))))

table(welfare$group_marriage)

# 데이터 다시로드
load("koweps/welfare.rda")

#이혼율(use group_by)
welfare %>% filter(!is.na(group_marriage)) %>% 
    filter(!is.na(religion)) %>% 
    select(religion,group_marriage) %>% 
    group_by(group_marriage) %>%  #tibble group 정보가 있음
    summarise(n=n()) %>% #tibble group 정보가 없어짐
    mutate(total=sum(n)) %>% 
    mutate(pct=round(n/total*100,1))-> a

#이혼율(use count)==count()-->빈도를 구한다
welfare %>% 
    filter(!is.na(group_marriage)) %>% 
    filter(!is.na(religion)) %>% 
    select(religion,group_marriage) %>% 
    count(group_marriage) %>%  #tibble group 정보가 있음
    mutate(total=sum(n)) %>% 
    mutate(pct=round(n/total*100,1))->b

all(a==b)

#sqldf
library(sqldf)
sqldf(" select group_marriage as mar, count(a.group_marriage) as cnt
           from ( 
                select religion, group_marriage 
                   from welfare 
                      where group_marriage not null and religion not null) a
                      group by group_marriage
      ") -> groupbymarriage

sqldf(" select sum(cnt) as total
        from groupbymarriage
      ")-> total

sqldf(" select  mar, cnt, 1.0*cnt/total*100 as ratio
          from groupbymarriage, total
      ")



#1.집계 데이터
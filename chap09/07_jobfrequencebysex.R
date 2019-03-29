# 09-7. 성별 직업 빈도
# - "성별로 어떤 직업이 가장 많을까?"
# 분석 절차
# 1. 변수 검토 및 전처리
# - 성별
# - 직업
# 2. 변수 간 관계 분석
# - 성별 직업 빈도표 만들기 
# - 그래프 만들기


#1.요약테이블 만들기
#jobfrequencebysex
library(tidyverse)
load("koweps/welfare.rda")
load("koweps/occupation.rda")
table(!is.na(welfare$code_job))

#count= group&summarise
welfare %>% filter(!is.na(code_job)) %>% 
           select(code_job, sex) %>%  
           count(code_job) ->a

welfare %>% filter(!is.na(code_job)) %>% 
            group_by(code_job) %>%
            select(code_job) %>%  
            summarise(count=n())->b 

all(a==b)

#상위 10위
welfare %>% filter(!is.na(code_job)) %>% 
            group_by(code_job,sex) %>%
            select(code_job, sex) %>%  
            summarise(count=n()) %>% 
            arrange(desc(count)) %>% 
            head(10) ->top10 

#남성 상위 10위
welfare %>% filter(!is.na(code_job)) %>% 
            filter(sex=="male") %>% 
            select(code_job) %>%  
            group_by(code_job) %>%
            summarise(n=n()) %>% 
            arrange(desc(n)) %>% 
            mutate(sex="male") %>% 
            head(10) ->male_top10 



#하위 10위
welfare %>% filter(!is.na(code_job)) %>% 
            group_by(code_job,sex) %>%
            select(code_job, sex) %>%  
            summarise(count=n()) %>% 
            arrange(count) %>% 
            head(10)->bottom10 

#여성 상위 10위
welfare %>% filter(!is.na(code_job)) %>% 
            filter(sex=="female") %>% 
            select(code_job) %>%  
            count(code_job) %>% 
            arrange(desc(n)) %>% 
            mutate(sex="female") %>% 
            head(10)->female_top10



#상위10위 코드명 조인/구분 필드&데이터추가
top10 %>% left_join(occupation2, by="code_job") %>%
          mutate(rank="top10")->top10

#하위10위 코드명 조인/구분 필드&데이터추가
bottom10 %>% left_join(occupation2, by="code_job") %>%
             mutate(rank="bottom10")->bottom10 

#상위, 하위 바인드
top10 %>% bind_rows(bottom10)->top_bottom

#남여상위, 하위 바인드
male_top10 %>% bind_rows(female_top10) %>% 
               left_join(occupation2, by="code_job") ->jobfrequencebysex




#2.그래프 만들기
#남성상위 10
jobfrequencebysex %>% filter(sex=="male") %>% 
                      ggplot(aes(reorder(job,n),n,fill=sex))+
                      geom_col(position="dodge")+
                      coord_flip()+
                      facet_grid(rows=vars(sex),scales="free")+
                      labs(y="종사인원",x="직종")

#여성상위 10
jobfrequencebysex %>% filter(sex=="female") %>% 
                      ggplot(aes(reorder(job,n),n,fill=sex))+
                      geom_col(position="dodge")+
                      coord_flip()+
                      facet_grid(rows=vars(sex),scales="free")+
                      labs(y="종사인원",x="직종")

#남여상위 10
jobfrequencebysex %>% filter(sex %in% c("male","female")) %>% 
                      ggplot(aes(reorder(job,n),n,fill=sex))+
                      geom_col(position="dodge")+
                      coord_flip()+
                      facet_grid(rows=vars(sex),scales="free")+
                      labs(y="종사인원",x="직종")


#가로 분할
top_bottom %>% ggplot(aes(reorder(job,count),count,fill=sex))+
               geom_col(position="dodge")+
               coord_flip()+
               facet_grid(rows=vars(rank),scales="free")+
               labs(y="종사인원",x="직종")

jobfrequencebysex %>% ggplot(aes(reorder(job,n),n,fill=sex))+
    geom_col(position="dodge")+
    coord_flip()+
    facet_grid(rows=vars(sex),scales="free")+
    labs(y="종사인원",x="직종")


#세로 분할
top_bottom %>% ggplot(aes(reorder(job,count),count,fill=sex))+
    geom_col(position="dodge")+
    coord_flip()+
    facet_grid(rows=vars(sex),scales="free")+
    labs(y="종사인원",x="직종")

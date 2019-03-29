# 09-6. 직업별 월급 차이
# - "어떤 직업이 월급을 가장 많이 받을까?"
# 분석 절차
# 1. 변수 검토 및 전처리
# • 직업
# • 월급
# 2. 변수 간 관계 분석
# • 직업별 월급 평균표 만들기
# • 그래프 만들기

library(tidyverse)
load("koweps/welfare.rda")
load("koweps/occupation.rda")

welfare %>% filter(!is.na(income)) %>% 
            select(code_job,income) %>% 
            group_by(code_job) %>% 
            summarise(mean_income=mean(income))->incomebyjob  
            
# top10
incomebyjob %>% arrange(desc(mean_income)) %>% 
                head(10)->top10
# top10 직종코드와 join
incomebyjob %>% left_join(occupation2, by="code_job") %>% 
                arrange(desc(mean_income)) %>% 
                head(10)->top10
# bottom10
incomebyjob %>% arrange(mean_income) %>% 
                head(10)->bottom10
#bottom10 직종코드와 join
incomebyjob %>% left_join(occupation2, by="code_job") %>% 
                arrange(mean_income) %>% 
                head(10)->bottom10

#정렬 reorder===>x 축에 사용 
top10 %>% ggplot(aes(reorder(code_job,-mean_income),mean_income))+geom_col()
top10 %>% ggplot(aes(reorder(job,-mean_income),mean_income))+geom_col()
top10 %>% ggplot(aes(reorder(job,mean_income),mean_income))+geom_col()+coord_flip()


bottom10 %>% ggplot(aes(reorder(code_job,-mean_income),mean_income))+geom_col()
bottom10 %>% ggplot(aes(reorder(job,-mean_income),mean_income))+geom_col()
bottom10 %>% ggplot(aes(reorder(job,mean_income),mean_income))+geom_col()+coord_flip()


#한개로 보일수 있도록 데이터/그래프를 결합
# 데이터 구분되도록 rank 속성추가
incomebyjob %>% left_join(occupation2, by="code_job") %>% 
                arrange(desc(mean_income)) %>% 
                head(10) %>% 
                mutate(rank="top10")->top10

incomebyjob %>% left_join(occupation2, by="code_job") %>% 
                arrange(mean_income) %>% 
                head(10) %>% 
                mutate(rank="bottom10")->bottom10
#데이터 바인드
top10 %>% bind_rows((bottom10))->top_bottom

#그래프 합치기
top_bottom %>% filter(rank=="top10") %>% 
               ggplot(aes(reorder(job,mean_income),mean_income))+
               geom_col()+
               coord_flip()


top_bottom %>%filter(rank=="bottom10") %>% 
              ggplot(aes(reorder(job,mean_income),mean_income))+
              geom_col()+
              coord_flip()


#   X, Y 분할해서 보여준다
top_bottom %>% ggplot(aes(reorder(job,mean_income),mean_income))+
               geom_col()+
               coord_flip()+
               #facet_grid(~rank)    #~rank (y= x+1) X축을 rank로 분할
               #facet_grid(cols=vars(rank))    #~rank (y= x+1) X축을 rank로 분할
               #facet_grid(rank~.,scales = "free")   #rank~. (y= x+1) Y축을 rank로 분할
               facet_grid(rows=vars(rank),scales = "free")+   #rows=vars(rank) Y축을 rank로 분할
               labs(y="월평균임금",x="직종")
               


top10=left_join(top10,occupation2,id="code_job")

left_join(bottom10,occupation2,id="code_job")

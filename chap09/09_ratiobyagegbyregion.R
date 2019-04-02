#ratio by ageg by region

library(tidyverse)
load("koweps/welfare.rda")
table(welfare$code_region)
# 1. 서울          
# 2. 수도권(인천/경기)    
# 3. 부산/경남/울산   
# 4.대구/경북   
# 5. 대전/충남   
# 6. 강원/충북               
# 7.광주/전남/전북/제주도
# 01. 전처리과정으로 삽입
region7=data.frame(code_region=c(1,2,3,4,5,6,7),
                   region=c("서울",
                            "수도권(인천/경기)",
                            "부산/경남/울산",
                            "대구/경북",
                            "대전/충남",
                            "강원/충북 ",
                            "광주/전남/전북/제주도"),stringsAsFactors=F) #Factor를 string으로 변환

region7
welfare %>% filter(!is.na(code_region)) %>% 
            filter(!is.na(ageg)) %>% 
            count(code_region, ageg) %>% 
            group_by(code_region) %>% 
            mutate(total=sum(n)) %>% 
            mutate(ratio=n/total*100) %>% 
            ungroup() %>% 
            left_join(region7, by="code_region") %>% 
            select(region,ageg,ratio) ->ratiobyagegbyregion1

region7 %>% arrange(desc(code_region)) ->sort1

ratiobyagegbyregion1 %>% 
    ggplot(aes(region,ratio,fill=ageg))+
    geom_col()+
    coord_flip()+
    scale_x_discrete(limits=sort1$region)

#old의 비율이 많은 순서
ratiobyagegbyregion1 %>% 
    arrange(factor(ageg,levels='old','middle','young'),ratio) %>% 
    filter(ageg=='old')->sort2

ratiobyagegbyregion1 %>% 
    ggplot(aes(region,ratio,fill=ageg))+
    geom_col()+
    coord_flip()+
    scale_x_discrete(limits=sort2$region)


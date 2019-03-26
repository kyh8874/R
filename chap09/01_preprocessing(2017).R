# h12_g3  	성별(sex)
# h12_g4	태어난 연도(birth)
# h12_g10	혼인상태(marriage)
# h12_g11	종교(religion)
# h12_eco9	직종(code_job)
# p1202_8aq1	일한달의 월 평균 임금(income)
# h12_reg7	7개 권역별 지역구분(code_region)
library(tidyverse)
library(foreign)
library(readxl)
library(sas7bdat)


read.dta("koweps/Koweps_hpda12_2017_beta1.dta") %>% 
    #read.spss("koweps/Koweps_hpc10_2015_beta3.sav") %>% 
    #read.sas7bdat("koweps/koweps_h10_2015_beta3.sas7bdat") %>%     
    rename(sex=h12_g3) %>% #성별(sex)
    rename(birth=h12_g4) %>% #태어난 연도
    rename(marriage=h12_g10) %>% #혼인상태
    rename(income=p1202_8aq1) %>% #월급
    rename(religion=h12_g11) %>% #종교급
    rename(code_job=h12_eco9) %>% #직종
    rename(code_region=h12_reg7) ->welfare  #7개 권역별 지역구분 
#후속작업 
welfare %<>% mutate(sex=ifelse(sex==1, "male","female")) %>% 
    mutate(income=ifelse(income==0, NA,  income)) %>% 
    mutate(age = 2017-welfare$birth+1) %>% 
    select(sex, 
           age,
           birth,
           marriage,
           religion,
           income,
           code_job,
           code_region) 

save(welfare,file="koweps/welfare17.rda")



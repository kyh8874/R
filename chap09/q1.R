
## 데이터 LOAD
# h11_g3	성별(sex)
# h11_g4	태어난 연도(birth)
# h11_g10	혼인상태(marriage)
# h11_g11	종교(religion)
# h11_eco9	직종(code_job)
# p1102_8aq1	일한달의 월 평균 임금(income)
# h11_reg7	7개 권역별 지역구분(code_region)
library(tidyverse)
library(foreign)

read.dta("koweps/Koweps_hpwc11_2016_beta2.dta") %>% 
    rename(sex=h11_g3) %>% 
    rename(birth=h11_g4) %>% 
    rename(marriage=h11_g10) %>% 
    rename(income=p1102_8aq1) %>%
    rename(religion=h11_g11) %>% 
    rename(code_job=h11_eco9) %>% 
    rename(code_region=h11_reg7) ->welfare  


## 데이터 전처리
### 1.남/여 데이터확인
table(welfare$sex)
#### welfare$sex = ifelse(welfare$sex==1, "male", "female")

### -NA확인
table(is.na(welfare$sex))

###  2. income  확인
welfare %>% filter(!is.na(income)) %>% 
    select(income) %>% 
    arrange(income) %>% head(20)

welfare %>% filter(!is.na(income)) %>% 
    select(income) %>% 
    arrange(desc(income)) %>% head(20)

###  - extream value NA 처리
#### welfare$income =ifelse(welfare$income==0, NA, welfare$income)

welfare %<>% mutate(sex=ifelse(sex==1, "male","female")) %>% 
             mutate(income=ifelse(income==0, NA,  income)) %>% 
             mutate(age = 2016-welfare$birth+1) -> welfare

#### 데이터 저장
save(welfare,file="koweps/welfare_2016.rda")


## 성별에 따른 월급차이(incomebysex) - 성별에 따라 월급이 다를까?
load("koweps/welfare_2016.rda")

### 성별 월급 평균
welfare %>% group_by(sex) %>%
           summarise(mean_income=mean(income,na.rm = T))->incomebysex

ggplot(data = incomebysex, aes(x = sex, y = mean_income)) + geom_col()







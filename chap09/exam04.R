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

# 1. 변수 검토하기

class(welfare$code_job)
table(welfare$code_job)
summary(welfare$code_job)

#charactor type change
welfare$code_job = as.character(welfare$code_job)

table(is.na(welfare$code_job))

# 직종코드 4자리===> 타입변경후 
#코드길이확인 
str_length(welfare$code_job)
table(str_length(welfare$code_job))

#string join====> paste와 유사 sep만 다르다.
str_c("0",welfare$code_job)

welfare$code_job=ifelse(str_length(welfare$code_job)==3, 
                        str_c("0",welfare$code_job),welfare$code_job)

####  데이터 전처리과정에 추가 삽입 #################
# 01_prerorcessing 과정으로 추가한다
# welfare$code_job = as.character(welfare$code_job)
#welfare$code_job=ifelse(str_length(welfare$code_job)==3, 
#                        str_c("0",welfare$code_job),welfare$code_job)
#########################################################################

#2. 전처리

#직업분류코드 목록 불러오기
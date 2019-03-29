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
#코드 테이블(엑셀파일)과 조인해서....
library(readxl)
occupation1=read_excel('Data/Koweps_Codebook.xlsx',sheet=2)
#code_job에 padding으로 "0" 추가
occupation1$code_job =str_pad(occupation1$code_job, width=4, side="left", pad="0")

#col_names=F 첫라인 필드명 없음(첫라인에 제목이 없을때)
occupation2=read_excel('Data/Koweps_Codebook.xlsx',sheet=3,col_names=F)

# ...1로 생성된 필드명(벡터데이터)에서 인덱스 1부터 4까지 추출해서 code_job 필드추가
occupation2$code_job=str_sub(occupation2$...1,1,4)

# ...1로 생성된 필드명(벡터데이터)에서 인덱스 5부터 끝까지 추출해서 job 필드추가
occupation2$job=str_sub(occupation2$...1,5)
#trim으로 공백제거
occupation2$job=str_trim(occupation2$job)
#...1필드 제거
occupation2$...1=NULL

#두개의 데이터가 같은지 확인해볼수 있다.(현재는 필드 타입과 문자의 차이가 있음)
occupation1==occupation2

#code_job 두개의 필드 비교
all(occupation1$code_job==occupation2$code_job)

#job필드 데이터비교
table(occupation1$job==occupation2$job)
all(occupation1$job==occupation2$job)

cbind(occupation1,occupation2)-> conform_df
str(conform_df)

#두개의 데이터의 길이가 일치하지않는 행을 얻어 확인
conform_df[!(str_length(occupation1$job)==str_length(occupation2$job)),c(2,4)]

#두개의 데이터가 일치하지않는 행을 얻어 확인
conform_df[!(occupation1$job==occupation2$job),c(2,4)] %>%view()

#data save
save(occupation2,file="koweps/occupation.rda")
save(occupation1,file="koweps/occupation1.rda")
load("Data/occupation2.rda")

##trim으로 공백제거
occupation1$job=str_trim(occupation1$job)
## replace
occupation2$job=str_replace_all(occupation2$job,"․"," ")

#직업분류코드 목록 불러오기


hw <- "Hadley Wickham"

str_sub(hw, 1, 6)
str_sub(hw, end = 6)
str_sub(hw, 8, 14)
str_sub(hw, 8)
str_sub(hw, c(1, 8), c(6, 14))

# Negative indices
str_sub(hw, -1)
str_sub(hw, -7)
str_sub(hw, end = -7)
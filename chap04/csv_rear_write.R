gender=c("male","female","male","female")
f_gender=factor(gender)
f2_gender=factor(gender,levels=c('male',"female"), labels=c("M","F"))
levels(f_gender)
levels(f2_gender)

read.csv("Data/welfare_utf8.csv") -> welfare  
read.csv("Data/welfare_utf8.csv", stringsAsFactors = F) -> welfare_no

#welfare_no의 구조를 본다
str(welfare_no)
welfare_no[welfare_no$sex=='male',] -> welfare_male
welfare_no[welfare_no$sex=='female',] -> welfare_female

#빈도 테이블 생성
table(welfare_male$sex)
table(welfare_female$sex)

write.csv(welfare_male, file="Data/welfare_male.csv")
write.csv(welfare_female, file="Data/welfare_female.csv")

#바이너리파일로 저장
save(welfare_male,welfare_female, file="Data/welfare.rda")

# 바이너리 파일 읽기
# 변수는 자동생성 enviroment변수를 모두 지우고 실행하면 볼수있다
load("Data/welfare.rda")

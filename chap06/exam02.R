library(dplyr)
library(sqldf)
csv = read.csv("Data/csv_exam.csv")

#functional programming style
csv %>% head(10) %>% tail(3) %>% head(2)


#r syntax
csv[csv$class ==2,c("math","english","science")] ->df_cls
df_cls

c(mean(df_cls$math),mean(df_cls$english),mean(df_cls$science))
mean(df_cls$math)  -> m
mean(df_cls$english) -> e
mean(df_cls$science)->s
data.frame(m,e,s)

colSums(df_cls)
colMeans(df_cls)

#column 삭제
#hash map에서 key를 지우는것과 같다
csv$id=NULL
csv$math=NULL


#dplyr  ==>spark
csv %>% filter(class==2) %>% 
        summarise(m_avg=mean(math),
                  e_avg=mean(english),
                  s_avg=mean(science))
#sql           
sqldf("
      select avg(math), avg(english), avg(science)
          from csv where class= 2
      ")

exam=csv
exam
#####EX
# exam 에서 class 가 1 인 경우만 추출하여 출력
exam %>% filter(class==1)
# exam 에서 class 가 1 or 2인 경우만 추출하여 출력
exam %>% filter(class==1 | class==2)
# 1 반이 아닌 경우
exam %>% filter(class !=1)
# 수학 점수가 50 점을 초과한 경우
exam %>% filter(math>50)
# 영어 점수가 80 점을 미만인 경우
exam %>% filter(english<80)
# 영어점수가 80 점 이상인 경우
exam %>% filter(english <= 80)
# 1 반 이면서 수학 점수가 50 점 이상인 경우
exam %>% filter(class==1&math>=50)
exam %>% filter(class==1,math>=50)
# 수학 점수가 90 점 이상이거나 영어점수가 90 점 이상인 경우
exam %>% filter(math>=90 | english>=90)
# 영어점수가 90 점 미만이거나 과학점수가 50 점 미만인 경우
exam %>% filter(english<90 | science <90)
# 1, 3, 5 반에 해당되면 추출
exam %>% filter(class==1|class==3|class==5)
exam %>% filter(class %in% c(1,3,5))

# 1 반 수학 점수 평균 구하기
exam %>% filter(class==1)->cls1
mean(cls1$math)

library(tidyverse)
library(plotly)
exam=read_csv("Data/csv_exam.csv")
str(exam)

#반별 과목별 평균  ===> wide type
exam %>%group_by(class) %>% 
        summarise(math=mean(math),
                  english=mean(english),
                  science=mean(science)) ->exam_wide

#수작업 변형
exam_wide[c("class","math")]->exam_math
exam_wide[c("class","english")]->exam_english
exam_wide[c("class","science")]->exam_science

#컬럼이름변경
names(exam_math)      <-c("class","mean")
names(exam_english)  <-c("class","mean")
names(exam_science)  <-c("class","mean")

#과목의 구분이 될 수있도록 과목명 컬럼을 추가
exam_math$subject="math"
exam_english$subject="english"
exam_science$subject="science"
exam_math
exam_english
exam_science

rbind(exam_math[c("class","subject","mean")],
      exam_english[c("class","subject","mean")],
      exam_science[c("class","subject","mean")]) ->exam_long


#dplyr 사용할때
exam_wide
exam_long_tidyr=gather(exam_wide, key="subject",value="mean",`math`,`english`,`science`)

#수작업과 비교 전체가 같다면 TRUE
all(exam_long_tidyr==exam_long)

#반별 과목별 평균 그래프 그리기
exam_long %>% ggplot(aes(class,mean,fill=subject))+geom_col(position="dodge")

member <- data.frame(family=c(1,2,3), namef=c("July","Andy","Ann"),
                     agef=c(12,19,26),namem=c("Peter","Ben","Mike"),
                     agem=c(13,14,26))
member
gather(member,key="title",value="anyone", namef:namem)

###############
#  정리
#############
#반별 과목별 평균  ===> wide type
exam %>%group_by(class) %>% 
    summarise(math=mean(math),
              english=mean(english),
              science=mean(science)) ->exam_wide

# wideformat  =====> long type으로 변형
exam_long_tidyr=gather(exam_wide, key="subject",value="mean",`math`,`english`,`science`) %>% 
                mutate(class=factor(class, levels=1:5, labels=paste(1:5,"반"))) %>% 
                mutate(subject=factor(subject, levels=c("math","english","science")))
#반별 과목별 평균 그래프 그리기
exam_long %>% ggplot(aes(class,mean,fill=subject))+labs(x="과목평균",y="학급")+geom_col(position="dodge")
exam_long_tidyr %>% ggplot(aes(class,mean,fill=subject))+geom_col(position="dodge")
#과목별 반평균
exam_long_tidyr %>% ggplot(aes(subject,mean,fill=class))+geom_col(position="dodge")->new_plot
library(plotly)
ggplotly(new_plot)


library(sqldf)
exam=read_csv("Data/csv_exam.csv")
sqldf("
       select class, 'math' as subject, avg(math) as mean
          from exam
          group by class
       union all
       select class, 'english' as subject, avg(english) as mean
          from exam
          group by class
       union all
       select class, 'science' as subject, avg(science) as mean
          from exam
          group by class

      ") ->exam_long

exam_long %>% mutate(class=factor(class, levels=1:5, labels=paste(1:5,"반"))) %>% 
              mutate(subject=factor(subject, levels=c("math","english","science"))) %>% 
              ggplot(aes(class,mean,fill=subject))+labs(x="과목평균",y="학급")+geom_col(position="dodge")




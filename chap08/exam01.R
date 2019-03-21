library(tidyverse)

#배경설정
ggplot(data = mpg, mapping=aes(x = displ, y = hwy))
ggplot(data = mpg, mapping=aes(x = cty, y = hwy))
ggplot(mpg, aes(cty,hwy))
mpg %>% ggplot(aes(cty,hwy))

#그래프 추가하기(산점도)
ggplot(data = mpg, mapping=aes(x = cty, y = hwy)) + geom_point()
ggplot(mpg, aes(cty,hwy)) + geom_point()
mpg %>% ggplot(aes(cty,hwy)) + geom_point()

#그래프에 추가정보를 나타내보자(드라이브)===>점하나에 3개의 정보 표시(질적자료가 좋다)
ggplot(data = mpg, mapping=aes(x = cty, y = hwy, color=drv))+labs(x="도시연비", y="고속도로연비") + geom_point()
ggplot(mpg, aes(cty,hwy)) + geom_point(aes(colour=drv))
mpg %>% ggplot(aes(cty,hwy,shape=drv)) + geom_point(aes(color=drv))


ggplot(data = mpg, mapping=aes(x = cty, y = hwy, color=drv))+
              labs(x="도시연비", y="고속도로연비") + 
              geom_point() + 
              xlim(15,20) +
              ylim(15,30)



#  평균 막대그래프 : geom_col x,y(avg) 
#  빈도 막대그래프 : geom_bar x
#
library(plotly)

#chr type===> factor
welfare_r=read.csv("Data/welfare_utf8.csv")
str(welfare_r)

#chr====>chr
welfare=read_csv("Data/welfare_utf8.csv")
str(welfare)

table(welfare$sex)


table(is.na(welfare$income))

welfare %>% filter(!is.na(sex),!is.na(income)) %>% 
            select(sex,income) %>% 
            group_by(sex) %>% 
            summarise(avg=mean(income)) -> incombysex
            
incombysex %>% ggplot(aes(sex,avg,fill=sex))+geom_col()
            
table(welfare$sex)

#빈도 막대그래프는 y값은 자동연산된다 x의 빈도를 계산해줌
welfare %>% ggplot(aes(sex))+geom_bar()->incombysex_plot
ggplotly(incombysex_plot)

(welfare %>% ggplot(aes(sex))+geom_bar()) %>% ggplotly()




mpg %>% group_by(drv)%>% 
        filter(!is.na(drv)) %>% 
        summarise(n=n())->sum_drv
ggplot(sum_drv,aes(reorder(drv,-n),n))+geom_col()


exam=read_csv("Data/csv_exam.csv")
ggplot(exam,aes(math,english,color=class))+geom_point()
ggplot(data=exam,mapping=aes(x=math, y=science, color=class))+geom_point()
ggplot(data=exam,mapping=aes(x=math, y=science))+geom_point(aes(color=class))

exam %>% ggplot(aes(x=math,y=english,color=class))+geom_point()
exam %>% ggplot(aes(math,english, shape=factor(class), color=class))+labs(x="수학", y="영어")+geom_point()

exam$class = factor(exam$class)
exam %>% ggplot(aes(x=math,y=english,shape=class))+geom_point()

library(maps)
kor<-map_data("world",region=c("North Korea","South Korea"))
kor
ggplot()+geom_polygon(data=kor,aes(x=long,y=lat,group=group,fill=region),color="black")+scale_fill_brewer(pallet="Set1")

data(world.cities)
head(world.cities)
str(world.cities)
world.cities$country.etc
skp<-world.cities[world.cities$country.etc %in% "Korea South",]
skp<-skp[order(-skp$pop),]
head(skp,10)

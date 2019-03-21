library(tidyverse)

str(midwest)
print(midwest, length(inf))
md<-midwest %>% filter(midwest$popasian <10000)
table(md$state)
ggplot(data=md,aes(x=poptotal ,y= popasian))+geom_point(aes(color=state))+
            xlim(0,500000)+
            ylim(0,10000)
#출력단위 표기  10만이 넘으면 지수로 표기가 되기때문에
#scipen=0 "0"이면 지수 표기
options(scipen=1)
ggplot(data=md,aes(x=poptotal ,y= popasian))+geom_point(aes(color=state))+
    lims(x=c(1,5*10**5),y=c(1,1*10**4))



midwest %>% group_by(state) %>% 
            summarise(statepoptotal=sum(poptotal))

economics
tail(economics,10)
ggplot(economics, aes(x=date, y=unemploy))+geom_line()

library(ggplot2)
library(sqldf)
library(dplyr)
#1.dplyr
str(mpg)
df_mpg=as.data.frame(ggplot2::mpg)
df_mpg %>% group_by(manufacturer) %>% 
           filter(class=="suv") %>% 
           mutate(total=(hwy+cty)/2) %>% 
           summarise(mean_sum=mean(total)) %>%
           arrange(desc(mean_sum)) %>% 
           head(5)

#2.sql
sqldf("
      select manufacturer, avg((hwy+cty)/2.) as mean_sum 
         from df_mpg
         where class='suv'
         group by manufacturer
         order by mean_sum desc
         limit 5
      ")

#R syntax
mpg[mpg$class=="suv",] -> df_mpg
df_mpg$mean=(df_mpg$hwy+df_mpg$cty)/2
df_mpg
df_audi[order(df_audi$hwy,decreasing = T),]
# 같은코드
df_audi[order(-df_audi$hwy),]
head(df_audi[order(-df_audi$hwy),],5)
       
library(ggplot2)
library(sqldf)
library(dplyr)
#1.dplyr
mpg %>% select(manufacturer,model,displ,trans,hwy) %>% 
        filter(manufacturer=="audi") %>% 
        arrange(desc(hwy)) %>% 
        head(5)

#2.sql
sqldf("
      select manufacturer , model, displ,trans,hwy
         from mpg
         where manufacturer='audi'
         order by hwy desc
         limit 5  
      ")

#R syntax
mpg[mpg$manufacturer=="audi",c("manufacturer","model","displ","trans","hwy")] -> df_audi
df_audi
df_audi[order(df_audi$hwy,decreasing = T),]
# 같은코드
df_audi[order(-df_audi$hwy),]
head(df_audi[order(-df_audi$hwy),],5)
       
library(tidyverse)
library(sqldf)
library(dplyr)
mpg

fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel

new_mpg<-left_join(mpg,fuel)
head(new_mpg[,c("model","fl", "price_fl")],5)

sqldf("
      select m.model, f.fl, f.price_fl 
         from mpg m
         left join fuel f
         on m.fl = m.fl
         limit 5
      ")

mpg %>% left_join(fuel) %>% 
        select("model","fl","price_fl") %>% 
        head(5) 

library(tidyverse)
mpg<-as.data.frame(ggplot2::mpg)
mpg[c(65, 124, 131, 153, 212),"hwy"]=NA
is.na(mpg)
is.na(mpg$hwy)
table(is.na(mpg$hwy))
table(is.na(mpg$drv))
length(mpg$drv)
mpg %>% filter(!is.na(hwy)) %>% 
        group_by(drv) %>% 
        summarise(mean_hwy= mean(hwy)) %>% 
        arrange(desc(mean_hwy))

mpg %>%group_by(drv) %>% 
    summarise(mean_hwy= mean(hwy, na.rm = T)) %>%
    arrange(desc(mean_hwy))

mpg %>% filter(!is.na(mpg$))
      
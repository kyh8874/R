library(tidyverse)
library(sqldf)

mpg %>% select(manufacturer,cty,hwy)

mpg %>% 
    group_by(manufacturer, drv) %>% 
    summarise(mean_cty=mean(cty)) %>% 
    head(5)

mpg %>% 
    group_by(manufacturer) %>% 
    filter(class=='suv') %>%
    mutate(total=(hwy+cty)/2) %>% 
    summarise(mean_total=mean(total)) %>% 
    arrange(desc(mean_total)) %>% 
    head(5)


sqldf("
      select manufacturer, avg((hwy+cty)/2.) as total 
         from mpg
         where class ='suv'
         group by manufacturer
         order by total desc
         limit 5
      ")  

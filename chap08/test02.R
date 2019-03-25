library(tidyverse)
library(plotly)

mpg %>% group_by(manufacturer) %>% 
        filter(class=='suv' & !is.na(cty)) %>% 
        select(manufacturer,cty) %>% 
        summarise(avg=mean(cty)) %>% 
        arrange(desc(avg)) %>% 
        head(5) -> manufacturer_cty
manufacturer_cty %>% ggplot(aes(reorder(manufacturer,-avg),avg))+
                     labs(x="제조사",y="도시연비")+
                     geom_col(aes(fill=manufacturer)) ->plot_result        
ggplotly(plot_result)


mpg %>% group_by(class) -> sum_class
sum_class %>% ggplot(aes(class))+geom_bar()

mpg %>% group_by(class) %>% 
        summarise(n=n())-> sum_col
sum_col %>% ggplot(aes(reorder(class,-n),n))+
            labs(x="차종",y="종류")+ 
            geom_col(aes(fill=class)) -> plot_result

ggplotly(plot_result)

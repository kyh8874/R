library(tidyverse)
library(sqldf)

#Q1
#1)
  #dplyr
mpg %>% group_by(class) %>%
        summarise(mean_cty=mean(cty))

#sqldf
sqldf("
      select class, avg(cty) as mean_cty from mpg
        group by class
        order by mean_cty desc
       
      ")

#R
mpg
unq=unique(mpg$class)
for (class in unq) {
    print(paste(class," 그룹"))   
    g_class = mpg[mpg$class==class,]
    mean_cty = mean(g_class$cty)
        g_temp=data.frame(class,mean_cty)
  
    if (which(unq==class)==1)
        result = g_temp
    else
        result=rbind(result,g_temp)

    print(g_temp)
    print('============')
    print(result)    
        
}
head(result[order(-result$mean_cty),],5)
  



#2)
mpg %>% group_by(class) %>%
    summarise(mean_cty=mean(cty)) %>% 
    arrange(desc(mean_cty) )
#3
#dplyr
mpg %>% group_by(class) %>% 
        summarise(mean_hwy=mean(hwy)) %>% 
        arrange(desc(mean_hwy))

#sqldf
sqldf("
        select class, avg(hwy) as mean_hwy from mpg
          group by class
          order by mean_hwy desc
          limit 5
      ")

#R
uni=unique(mpg$class)
for (class in uni){
    g_class = mpg[mpg$class==class,]
    mean_hwy=mean(g_class$hwy)
    g_temp=data.frame(class,mean_hwy)
    
    if (which(uni==class)==1)
        result = g_temp
    else
        result = rbind(result, g_temp)
} 
 head(result[order(-result$mean_hwy),],5)



#4
#dplyr
mpg %>% group_by(manufacturer) %>% 
        filter(class=='compact')%>% 
        summarise(total=sum(n())) %>% 
        arrange(desc(total))
#sqldf
sqldf("
      select manufacturer, class, count(*) as cnt from mpg
       where  class='compact'
       group by manufacturer
       order by cnt desc
      ")


#R 
mpg_compact=mpg[mpg$class=='compact' , c("manufacturer","class")]
aggregate(class~manufacturer,mpg_compact,length)
mpg_group=aggregate(class~manufacturer,mpg_compact,length)
mpg_group[order(-mpg_group$class),]

#4.SQLLite
library(RSQLite)
library(DBI)
con =dbConnect(SQLite(),"test_db.sqlite")
dbListTables(con)
dbWriteTable(con,"mpg_s",mpg)
dbGetQuery(con,"
               select manufacturer, class, count(*) as cnt 
                      from mpg_s
                      where  class='compact'
                      group by manufacturer
                      order by cnt desc
           ")

dplyr::tbl(con,"mpg_s")%>%group_by(manufacturer) %>% 
                           filter(class=='compact')%>%
                           summarise(total=n())%>% 
                           arrange(desc(total))
                        

dbDisconnect(con)
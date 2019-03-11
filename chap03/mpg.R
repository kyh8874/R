library(ggplot2)
x <- c("a","a","a","b","c","d","d")
qplot(x)

mpg -> mympg

qplot(data=mpg , y= manufacturer, x=cty)
library(sqldf)
sqldf("select distinct model from  mpg where model = 'sonata'" )

sqldf("select manufacturer, model, year from mpg 
      where manufacturer= 'toyota' and year > 2000")


sqldf("select count(*)
        from mympg")

sqldf("select manufacturer, round(avg(cty),2) as city, round(avg(hwy),2) as hiway from mympg 
       group by manufacturer
       order by city desc") -> min
min

qplot(min$manufacturer,min$hiway)
qplot(mpg$cty)


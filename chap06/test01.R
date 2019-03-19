library(ggplot2)
library(dplyr)
library(sqldf)

mpg=as.data.frame(mpg)
mpg

#dpyr
mpg %>% filter(displ<=4)->l_dsp
l_dsp
mpg %>% filter(displ>=5)->h_dsp
h_dsp
mean(l_dsp$hwy)->why4
mean(h_dsp$hwy)->why5
data.frame(why4,why5)

#R syntax
mpg[mpg$displ<= 4,] -> r4_dsp
r4_dsp

mpg[mpg$displ>= 5,] -> r5_dsp
r5_dsp
mean(r4_dsp$hwy)->r4
mean(r5_dsp$hwy)->r5
data.frame(r4,r5)

#sql
sqldf(" select avg(hwy) displl4 from mpg
          where displ <= 4
        ") ->sql4
sqldf(" select avg(hwy) displl5 from mpg
          where displ >= 5
        ") ->sql5
data.frame(sql4,sql5)

##Q2
#dplyr
mpg_a <- mpg %>% filter(manufacturer == "audi")
mpg_t <- mpg %>% filter(manufacturer == "toyota")
mean(mpg_a$cty)
mean(mpg_t$cty)
#R
mpg[mpg$manufacturer == "audi",]->rmpg_a
mpg[mpg$manufacturer == "toyota",]->rmpg_t
mean(rmpg_a$cty)
mean(rmpg_t$cty)
#sql
sqldf("select avg(cty) audi
         from mpg
         where manufacturer == 'audi'")->smpg_a

sqldf("select avg(cty) toyota
         from mpg
         where manufacturer == 'toyota'")->smpg_t
data.frame(smpg_a,smpg_t)

#Q3
#dplyr
df_tmp <- mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
mean(df_tmp$hwy)
#R
attach(mpg)
mpg[manufacturer=="chevrolet" | manufacturer=="ford"| manufacturer=="honda",]->r_tmp
mean(r_tmp$hwy)
#sqldf
sqldf("
      select avg(hwy) why_avg from mpg
        where manufacturer='chevrolet' or manufacturer='ford' or manufacturer='honda'
      ")

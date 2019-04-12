library(tidyverse)
library(foreign)
library(readxl)


klosa1= read.dta("klosa/Lt01.dta")
klosa2= read.dta("klosa/Lt02.dta")
klosa3= read.dta("klosa/Lt03.dta")
klosa4= read.dta("klosa/Lt04.dta")
klosa5= read.dta("klosa/Lt05.dta")
klosa6= read.dta("klosa/Lt06.dta")
save(klosa1,klosa2,klosa3,klosa4,klosa5,klosa6, file="klosa/klosa.rda")

load("klosa/klosa.rda")

write_csv(klosa1,"klosa/klosa1.csv")
write_csv(klosa2,"klosa/klosa2.csv")
write_csv(klosa3,"klosa/klosa3.csv")
write_csv(klosa4,"klosa/klosa4.csv")
write_csv(klosa5,"klosa/klosa5.csv")
write_csv(klosa6,"klosa/klosa6.csv")


klosa= read.dta("klosa/Lt01.dta")
lt01 %>% head(10)
str(lt01)

save(klosa,region7,file="koweps/welfare.rda")

write_csv(welfare,"koweps/welfrae.csv")



library(sparklyr)
library(fs)

sc=spark_connect(master="local[*]")
lt01_tbl =
    spark_read_csv(sc, name="klosa", path="klosa/Lt01.dta", 
                   memory =F, null_value=NULL)
spark_read


head(lt01_tbl)

library(tidyverse)
library(sparklyr)


sc=spark_connect("local")

#table create
mpg_tbl=copy_to(sc, mpg, overwrite = T) 
midwest_tbl=copy_to(sc, midwest, overwrite = T) 
#mpg_tbl = as.data.frame(mpg_tbl)
mpg_tbl
midwest_tbl

#csv read
exam_tbl=spark_read_csv(sc,"exam",path="Data/csv_exam.csv")

exam_tbl %>% print(n=5)

#spark table list
src_tbls(sc)

spark_disconnect(sc)

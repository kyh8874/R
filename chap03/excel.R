library(ggplot2)
library(sqldf)
library(readxl)

excel_exam=readxl::read_excel("Data/excel_exam.xlsx")
str(excel_exam)
readxl::read_excel("Data/excel_exam.xlsx") -> result

sqldf(" select max(math)
          from result 
          group by class")

sqldf(" select class, max(math), max(english), max(science)
          from result
          group by class 
          order by class ")


qplot
          

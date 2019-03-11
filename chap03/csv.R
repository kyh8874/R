library(ggplot)
library(sqldf)
#csv read는 기본내장
read.csv("Data/csv_exam.csv") -> csv_exam
sqldf("
      select distinct class
        from csv_exam
      ")

sqldf("
      select class, count(*), avg(math) as m, avg(english) as e, avg(science) as s
        from csv_exam
        group by class
      ")

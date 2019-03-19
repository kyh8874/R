library(tidyverse)
library(sqldf)
library(RSQLite)
library(DBI)

#가로로 합치기
#데이터 생성
# 중간고사 데이터 생성
test1 <- data.frame(id = c(1, 2, 3, 4, 5,6),
                    midterm = c(60, 80, 70, 90, 85,70))
# 기말고사 데이터 생성
test2 <- data.frame(id = c(1, 2, 3, 4, 5,7),
                    final = c(70, 83, 65, 95, 80,85))

#join
left_join(test1,test2, by ='id')

right_join(test1,test2, by ='id')

full_join(test1,test2, by ='id')

inner_join(test1,test2, by ='id')

#inner join
sqldf("
      select t1.id, midterm, final 
        from test1 t1 inner join test2 t2
        on t1.id =t2.id
      ")

#left join
sqldf("
      select t1.id, midterm, final 
        from test1 t1 left join test2 t2
        on t1.id =t2.id
      ")

# sqldf Right Join & UTER JOINs are not currently supported
#right join====>left join의 반대로 해결
sqldf("
      select t1.id, midterm, final 
        from test2 t2 left join test1 t1
        on t1.id =t2.id
      ")

#full join = right join  + left join의 반대로 해결(union)
sqldf("
      select t1.id, midterm, final 
        from test1 t1 left join test2 t2
        on t1.id =t2.id
      union 
      select t1.id, midterm, final 
        from test2 t2 left join test1 t1
        on t1.id =t2.id
      ")

exam=read.csv("Data/csv_exam.csv")

name=data.frame( class = c(1,2,3,4,5),
            teacher=c("lee","park","choi","kim","jung"))
name
exam<-left_join(exam, name, by="class")
exam

sqldf("
      select exam.* , name.teacher
         from exam left join name
         on exam.class = name.class
      
      ")






con=dbConnect(SQLite(),"test_db.sqlite")
dbWriteTable(con, "test1",test1)
dbWriteTable(con, "test2",test2)
dbListTables(con)

# Right Join & UTER JOINs are not currently supported
dbGetQuery(con," 
           select t1.id, midterm, final 
            from test1 t1 left join test2 t2
            on t1.id =t2.id
           ")
sqldf("
      select t1.id, midterm, final 
        from test1 t1 left join test2 t2
        on t1.id =t2.id
      ")
#dlyr이용하기 
tbl(con,"test1") %>% left_join(tbl(con,"test2"), by='id')

###Right Join & UTER JOINs are not currently supported
tbl(con,"test1") %>% right_join(tbl(con,"test2"), by='id')

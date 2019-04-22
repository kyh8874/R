iris
data()
data(package = .packages(all.available = TRUE))
class(iris3)


library(sparklyr)
library(tidyverse)
library(tictoc)
sc=spark_connect(master="local[*]")
iris_tbl = copy_to(sc,iris,overwrite=T)

#R
str(iris)
colnames(iris)
iris %>% count(Species)
summary(iris)

#Spark
#R에서 .로 만들어진 변수명은 _로 변경된다 
glimpse(iris_tbl)
colnames(iris_tbl)
iris_tbl %>% count(Species)

#R의 summary와 다르다
summary(iris_tbl)
#sdf_함수 spark data frame function에서 찾아본다
#R의 함수를 대체하는 spark의 함수와 추가된 기능이 있다
sdf_describe(iris_tbl)


#https://statkclee.github.io/bigdata/ml-sparklyr.html
# 2. 기본 데이터 처리 ------------------------------------------
## 2.1. select
iris_tbl %>% select(Sepal_Length, Petal_Length, Species) %>% 
         filter(Sepal_Length > 5.0, Petal_Length > 5) %>% 
         arrange(Species, desc(Petal_Length), Sepal_Length)
## 2.4. mutate
iris_tbl %>% select(Sepal_Length, Petal_Length, Species) %>% 
    filter(Sepal_Length > 5.0, Petal_Length > 5) %>% 
    arrange(Species, desc(Petal_Length), Sepal_Length) %>% 
    mutate(log_Sepal_Length = log(Sepal_Length))
## 2.5. summarize
iris_tbl %>% select(Sepal_Length, Petal_Length, Species) %>% 
    filter(Sepal_Length > 5.0, Petal_Length > 5) %>% 
    arrange(Species, desc(Petal_Length), Sepal_Length) %>% 
    mutate(log_Sepal_Length = log(Sepal_Length)) %>% 
    summarise(mean_sepal_length = mean(Sepal_Length),
                     max_petal_legnth = max(Petal_Length))

#top_n() => descending한 min_rank를 사용한다
#EX
exam=read_csv("Data/csv_exam.csv")

exam %>% mutate(tot=(math+english+science)/3) %>% 
         arrange(desc(tot)) %>% #정렬 후 순서를 부여함row_number() 랭킹은 아님
         mutate(row_number=row_number())

exam %>% mutate(tot=(math+english+science)/3) %>% 
    arrange(desc(tot)) %>% #정렬 후 순서를 부여함row_number() 랭킹은 아님
    mutate(row_number=row_number()) %>% 
    mutate(min_rank=min_rank(-tot)) # -를 부여하면 높은 순서로 랭킹(9,9,9,12)

exam %>% mutate(tot=(math+english+science)/3) %>% 
    arrange(desc(tot)) %>% #정렬 후 순서를 부여함row_number() 랭킹은 아님
    mutate(row_number=row_number()) %>% 
    mutate(min_rank=min_rank(-tot)) %>%  # -를 부여하면 높은 순서로 랭킹(9,9,9,12)
    mutate(dense_rank=dense_rank(-tot)) # -를 부여하면 높은 순서로 랭킹(9,9,9,10)
    

exam %>% mutate(tot=(math+english+science)/3) %>% 
    arrange(desc(tot)) %>% #정렬 후 순서를 부여함row_number() 랭킹은 아님
    mutate(row_number=row_number()) %>% 
    mutate(min_rank=min_rank(-tot)) %>%  # -를 부여하면 높은 순서로 랭킹
    mutate(dense_rank=dense_rank(-tot)) %>% # -를 부여하면 높은 순서로 랭킹
    top_n(12,tot) #descending한 min_rank를 사용한다 12위까지

exam %>% mutate(tot=(math+english+science)/3) %>% 
    arrange(desc(tot)) %>% #정렬 후 순서를 부여함row_number() 랭킹은 아님
    group_by(class) %>% 
    mutate(row_number=row_number()) %>% 
    mutate(min_rank=min_rank(-tot)) %>%  # -를 부여하면 높은 순서로 랭킹
    mutate(dense_rank=dense_rank(-tot)) %>% # -를 부여하면 높은 순서로 랭킹
    arrange(class) %>%   
    top_n(2,tot) %>% view

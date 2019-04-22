library(sparklyr)
library(tidyverse)

sc=spark_connect(master="local[*]")
iris_tbl=copy_to(sc, iris, overwrite = T)

iris_tbl %>% count(Species) %>% explain()

iris_tbl %>% summarise(sum=sum(Sepal_Length,na.rm=T))

#Spark SQL
#sdf_sql(sc."    ")
#DBI::dbGetQuery(sc, "    ")
DBI::dbGetQuery(sc, "
                     select species, avg(sepal_length)
                         from iris
                         group by species
                ")

sdf_sql(sc, "
             select species, avg(sepal_length)
               from iris
               group by species
            ")


# 5 데이터프레임 변환과 중간결과 저장(filtering, select ..etc)
#sdf_gerister
# 1. 데이터프레임 변환 -----------------------------------------------
iris_df <- iris_tbl %>% 
    dplyr::select(starts_with("Sepal"), Species) %>% 
    collect()

# 2. 중간결과 저장 -----------------------------------------------
iris_sepal <- iris_tbl %>%
    dplyr::select(starts_with("Sepal"), Species) %>% 
    compute("iris_sepal")


iris_tbl %>% filter(Species=='setosa') %>% 
    compute("iris_setosa")

iris_tbl %>% filter(Species=='versicolor') %>% 
    sdf_register("iris_versicolor")

iris_tbl %>% filter(Species=='virginica') %>% 
    sdf_register("iris_virginica")

#proxy
#tbl(sc,"   ")
tbl(sc, "iris_setosa") %>% count()
tbl(sc, "iris_versicolor") %>% count()
tbl(sc, "iris_virginica") %>% count()

#spark bind
tbl(sc, "iris_setosa") %>%
        sdf_bind_rows(tbl(sc,"iris_versicolor")) %>% 
        sdf_bind_rows(tbl(sc,"iris_virginica")) %>% 
#        count() 
        spark_write_table("iris_new")  
#spark write
#hive가 관리하는 file로 저장(metastore_db) 분산 클러스트에 분산저장하고 
#저장 정보만 갖고 있지만 디폴트는 로컬의 spark-warehouse에 저장됨
#접속 종료후 재접속하면 연결이 된다

#R bind
iris %>% bind_rows(iris) %>% count()

str(iris)
glimpse(iris_tbl)

spark_disconnect(sc)

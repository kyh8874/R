library(sparklyr)
library(tidyverse)

#Spark SQL(hive)
#Spark ML <==> Spaklyr===> R
#1.sdf
sdf_bind_rows()
sdf_schema()

#2. ft : 파생변수 생성 mutate기능
ft_binarizer()
ft_bucketizer()
ft_quantile_discretizer()

#3.ml : 알고리즘(데이터를 학습)) ===>모델(학습결과)
#1.지도학습 : 답이 있는 상태에서 학습 (label, feature) 답과 속성이 있다 ex)y=ax+bz+cK
ml_random_forest()       #랜덤포레스트
ml_linear_regression()   #회귀분석
ml_logistic_regression() #로지스틱틱

#2.비지도학습습 : 답이 없는 상태에서 학습다(feature만 있다)
ml_kmeans()#

sc=spark_connect("local[*]")
iris_tbl=sdf_copy_to(sc,iris,overwrite = T)

#iris_tbl은 R의 list 형식이다
class(iris_tbl)
is.list(iris_tbl)
str(iris_tbl)

glimpse(iris_tbl)
sdf_schema(iris_tbl)

#schema
iris_schema=sdf_schema(iris_tbl);iris_schema
#같은표현
(iris_schema=sdf_schema(iris_tbl))

#function
mysum <- function(a,b){
        print(paste(a,b))
        # a+b
        return(a+b)
}

mysum(10,20)

mysum(1:10, 10:1)

#무명함수
#mpg----> x
mpg %>% (function(x){
         x$manufacturer
}) 

mpg %>% (function(x){
    data.frame(x$manufacturer, x$cty)
}) 

### 머신러닝 참고사이트
###spark.rstudio.com



spark_disconnect(sc)

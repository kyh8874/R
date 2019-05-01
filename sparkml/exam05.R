library(sparklyr)
library(tidyverse)
sc=spark_connect("local[*]")
iris_tbl=sdf_copy_to(sc,iris,overwrite = T)

# 1. 스파크 데이터프레임 스키마
(iris_schema <- sdf_schema(iris_tbl))

iris_schema
length(iris_schema)

#list suubset
iris_schema[1]
length(iris_schema[1])

#list의 원소
iris_schema[[1]]
length(iris_schema[[1]])



#lapply(list, function)
#split--> apply --> combine
# x는 list의 원소임
iris_schema
lapply(iris_schema, function(x) length(x))
lapply(iris_schema, function(x) {
                      print("############")
                      print(length(x))
                      length(x)}
                     )

lapply(iris_schema, function(x) {
    print("############")
    print(length(x))
    data.frame(x[[1]],x[[2]]) #리스트 형태의 iris_schema의 원소를 data.frame으로 변경
    }) %>% bind_rows() 

#전체처리
lapply(iris_schema, function(x) {
    print("############")
    print(length(x))
    do.call(data.frame,x)
}) %>% bind_rows() 

# 2. 스파크 요인(Factor) -----------------------------------------------
## 2.1. 요인(factor) 변환
#   ft_binarizer()
## 2.2. 연속형 변수를 범주형 변환 (I)
#   ft_bucketizer()   

sepal_split <- quantile(iris$Sepal.Length)
#> quantile(iris$Sepal.Length)
# 0%  25%  50%  75% 100% 
# 4.3  5.1  5.8  6.4  7.9 
sepal_split <- quantile(iris$Sepal.Length, c(4.3,  5.1,  5.8,  6.4,  7.9 ))

iris_tbl %>% sdf_describe()

iris_tbl %>% select(Sepal_Length) %>% 
    arrange(Sepal_Length) %>% 
    #binarizer input = Sepal_Length ,output = binarizer , 5.8을 기준으로 0,1로 처리 5.8은 0
    ft_binarizer("Sepal_Length","binarizer",5.8) %>%  
    #splits 기준으로 split===>3개이상 splits 기준이 필요 --시작점포함 끝 포함안함
    ft_bucketizer("Sepal_Length","bucketizer",c(4.3, 5.1,  5.8,  6.4,  7.9 )) %>% 
    # 균등분할 분위로 사용할때는 ft_quantile_discretizer() ==> 4: 4등분  10:10%...100%
    ft_quantile_discretizer("Sepal_Length","quantile_discretizer",10) %>% 
    collect() %>% 
    view()

spark_disconnect(sc)
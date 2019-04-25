library(sparklyr)
library(tidyverse)

sc=spark_connect("local[*]")

iris_tbl=sdf_copy_to(sc,iris,overwrite = T)

#학습모델
#formula 방식(y=x+z) ===> Species = Petal_Length+Petal_Width
rf_model =
iris_tbl %>% ml_random_forest(Species~Petal_Length+Petal_Width)

#학습평가
predicted=
rf_model %>% ml_predict(iris_tbl)

predicted
glimpse(predicted)

#답 Species , 예측 : prediction R영역으로 가져옴
predicted %>% select(Species,prediction) %>% 
              collect()->df_result

#결과확인
table(df_result$Species,df_result$prediction)
# <Species>   0  1  2 ==> prediction
# setosa      0  0 50  
# versicolor 49  1  0
# virginica   0 50  0

iris_tbl %>% ml_random_forest(label_col = "Species",)

spark_disconnect(sc)
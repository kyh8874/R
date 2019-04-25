library(sparklyr)
library(tidyverse)

sc=spark_connect("local[*]")

iris_tbl=sdf_copy_to(sc,iris,overwrite = T)

#학습모델
#formula 방식(y=x+z) ===> Species = Petal_Length+Petal_Width
rf_model =
iris_tbl %>% ml_random_forest(Species~Petal_Length+Petal_Width)

iris_tbl %>% ml_random_forest(label_col = "Species",)

spark_disconnect(sc)
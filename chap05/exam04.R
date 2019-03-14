library(ggplot2)
library(dplyr)
df_mpg=mpg

#in place
df_mpg$total=(df_mpg$cty +df_mpg$hwy)/2
df_mpg$test = ifelse(df_mpg$total>=20,"pass","fale")
table(df_mpg$test)
df_mpg$grade = ifelse(df_mpg$total>=30,"A",
                      ifelse(df_mpg$total >=25 , "B",
                             ifelse(df_mpg$total >=20, "C","D")))
table(df_mpg$grade)  
qplot(df_mpg$grade)

#out place
mutate(mpg, total=(cty+hwy)/2) -> df_mpg2








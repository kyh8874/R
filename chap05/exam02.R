library(ggplot2)
View(mpg)
str(mpg)
dim(mpg)
attach(mpg)

#manufacturer
sort(manufacturer, decreasing = T)
head(sort(manufacturer))
table(manufacturer)
length(table(manufacturer))

#model
model
mpg[,c("manufacturer","model")] -> mpg_model
mpg_model
order(c(10,5,9,20,1))
order(c(10,5,9,20,1),decreasing = T)
order(-c(10,5,9,20,1))
sort(c(10,5,9,20,1))
mpg_model[order(manufacturer,model),]
mpg_model[order(manufacturer,decreasing = T,  model),]
mpg_model[order(-rank(manufacturer),  -rank(model)),] ->mpg_modelsort
View(mpg_modelsort)
library(sqldf)
sqldf("
      select manufacturer, model 
        from mpg_modelsort
        order by manufacturer desc , model asc      
      ")  -> mpg_model_sort


df_mpg =mpg

df_mpg=as.data.frame(mpg)
names(df_mpg)
names(df_mpg)[8] <-"city"
names(df_mpg)[8] <-"highway"



detach(mpg)
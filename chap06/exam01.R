library(ggplot2)
df_mpg=as.data.frame(mpg)
csv = read.csv("Data/csv_exam.csv")

#############
# csv
#############
csv
colnames(csv)
rownames(csv)
csv$class

#DATA BASE
#  -C (create)     ====> rbind(df1,df2) ==> union
#  -R (retrieve)   ====> indexing
#  -U (update)     ====> indexing + assigment(=.<-,->)
#  -D (delete)   ======> indexing + assigment(=.<-,->)  


#############################################
#1. R (retrieve)   ====> indexing
# indexing + ===> dataframe in place
#   -inreger indexing 
#   -name indexing
#   -boolean indexing

#column
#1.컬럼이름으로...name indexing

csv["class"]
csv[c("class","science")]

#2.인덱스로..integer indexing
csv[2]
csv[c(2,5)]

#3.boolean indexing
csv[c(F,T,F,F,T)]

###ROW
#row name
rownames(csv)[1] = 'one'
csv["one",]
csv["2",]
csv[c("2","one","10"),]

#인덱스로
csv[c(2,1,10),]

#boolean index
x=c(T,T,F,F,F,F,F,F,F,T,F,F,F,F,F,F,F,F,F,F)
csv[x,]

y=csv$math>=80
y
csv[y,]
csv[csv$math>=80,]
csv[csv$math>=80 & csv$english >= 90,]

library(sqldf)
sqldf("
       select * from csv 
         where math >=80
          and english >=90")

###########################################################
#2.  U (update)     ====> indexing + assigment(=.<-,->)
# indexing + ===> dataframe in place
#   -inreger indexing 
#   -name indexing
#   -boolean indexing

csv$teacher ="xxx"
csv[c("teacher","class", "math","english","science")] ->csv2
csv2
csv2[csv2$class==1,]   # booelan indexing
#database where와 같이...
csv2[csv2$class==1,]$teacher ="홍길동"

#수학점수 50, 40인 것만
csv2[csv2$math %in% c(50,45),]
#수학점수를 100으로 
csv2[csv2$math %in% c(50,45),"math"] = 100

#sqldf사용
csv[c("teacher","class", "math","english","science")] ->csv3
sqldf(c("
        update csv3
           set math = 100 
           where math in (50,45)
        ","select * from csv3")) -> csv3
csv3

##############################################################
#3.  D (delete)   ======> indexing + assigment(=.<-,->) 
#   indexing + ===> dataframe out place
#   inreger indexing 
#   name indexing
#   boolean indexing

csv[c("teacher","class", "math","english","science")] ->csv4
#delete 효과
csv4[csv$class !=2,]  -> csv4
csv4

#sqldf
csv[c("teacher","class", "math","english","science")] ->csv5
sqldf(c("
        delete from csv5 where class = 2
        ","select * from csv5"))

sqldf("
        select * from csv5 where class != 2
        ")

############################################
#4 C (create)     ====> rbind(df1,df2) ==> union
# 같은 형식으로 된 데이터 프레임 두개를 합친다
# row bind, column bind

csv[c("teacher","class", "math","english","science")] ->csv6
one=data.frame(teacher="홍길동",class=1, math=60, english=80,science=70)
one
rbind(csv6,one)->csv6
csv6

#DATA BASE
#  -C (create)     ====> rbind(df1,df2) ==> union
#  -R (retrieve)   ====> indexing
#  -U (update)     ====> indexing + assigment(=.<-,->)
#  -D (delete)   ======> indexing + assigment(=.<-,->)  
csv[c("teacher","class", "math","english","science")] ->csv7
sqldf(c("
        insert into csv7 
          values ('홍순희',1,90,95,100)
        ","select * from csv7"))

######################
####rownames 재정렬
csv[csv$english>90,]-> df_csv
df_csv
rownames(df_csv) <- 1:nrow(df_csv)
df_csv


#############
# df_mpg
#############
df_mpg
colnames(df_mpg)
rownames(df_mpg)

#############
# mpg
#############
mpg
colnames(mpg)
rownames(mpg)


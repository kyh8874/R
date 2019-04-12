library(tidyverse)
library(sparklyr)
library(fs)
library(tictoc)

dir_info("dataexpo/download/")$path

sc=spark_connect(master="local[*]")  #local[*] => local의 스레드 제한없이 사용 (Remote를 Local로 사용)

#ontime_tbldm을 이용해서 spark의 ontime에 접근
#spark는 일부 데이터를 읽고 데이터의 타입을 판단해서 타입의 판단이 부정확하여 사용자의 판단이 필요

######################
tic("ontime_tbl...")
#####################

ontime_tbl =
spark_read_csv(sc, name="ontime", path="dataexpo/download/*.gz", 
               memory =F, null_value="NA",
               infer_schema = F, 
               columns = list( 
                   Year = "integer",
                   Month = "integer",
                   DayofMonth = "integer",
                   DayOfWeek = "integer",
                   DepTime  = "integer",
                   CRSDepTime = "integer",
                   ArrTime = "integer",
                   CRSArrTime = "integer",
                   UniqueCarrier = "character",
                   FlightNum = "integer",
                   TailNum = "character",
                   ActualElapsedTime = "integer",
                   CRSElapsedTime = "integer",
                   AirTime = "integer",
                   ArrDelay = "integer",
                   DepDelay = "integer",
                   Origin = "character",
                   Dest = "character",
                   Distance = "integer",
                   TaxiIn = "integer",
                   TaxiOut = "integer",
                   Cancelled = "integer",
                   CancellationCode = "character",
                   Diverted = "character",
                   CarrierDelay = "integer",
                   WeatherDelay = "integer",
                   NASDelay = "integer",
                   SecurityDelay = "integer",
                   LateAircraftDelay = "integer")
                 )



#R의 str(ontime_tbl)과 같다
glimpse(ontime_tbl)

#1. total count
ontime_tbl %>% count()


#2. year count
tic("year count...")
ontime_tbl %>% count(year) %>% 
               arrange(year) %>% 
               collect() %>%  #spark ===> R
               summarise(sum = sum(n))
toc()

#3. year month count
tic("count_by_month_by_year ...")
ontime_tbl %>% count(year, Month) %>% 
               arrange(desc(year),Month) %>%
               collect() -> count_by_month_by_year   #spark ===> R
toc()
count_by_month_by_year



spark_disconnect(sc)

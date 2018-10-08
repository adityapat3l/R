setwd("/Users/adityapatel/projects/personal/R")
source("config.R")
library(DBI)

mydb = dbConnect(MySQL(), 
                 user=prod_user,
                 password=prod_password,
                 dbname=prod_db,
                 port=prod_port,
                 host=prod_host)

results = dbSendQuery(mydb, 
                      "select
                            id, 
                            call_start_time, 
                            globo_voice_info_id, 
                            destination_language_id
                      from calls where
                      call_start_time >= '2018-10-06 04:00:00'")

data = fetch(results, n=-1)

# Cleaning Data
df = data.frame(data)
sapply(df, class)
df$call_start_time_dt <- as.POSIXct(data$call_start_time, 
                                    format="%Y-%m-%d %H:%M:%S",
                                    tz = "UTC")



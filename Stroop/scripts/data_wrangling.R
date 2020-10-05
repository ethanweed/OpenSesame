rm(list = ls())
library(dplyr)
library(tidyr)
rawdata <- data.frame()
path <- '/Users/ethan/Desktop/Stroop_student_data_self copy/'
files <- list.files(path)

for (n in 1: length(files)){
  file <- paste0(path,files[n])
  print(file)
  temp <- read.csv(file, sep = ",")
  rownames(temp) <- NULL
  d <- select(temp, task, interference, response_time)
  d$ID <- n
  rawdata <- rbind(rawdata,d)
}

rawdata$rt <- rawdata$response_time
rawdata$response_time <- NULL

rawdata$task[rawdata$task == 'Reading'] <- 'reading'
rawdata$task[rawdata$task == 'Naming'] <- 'naming'

collapsed <- rawdata %>%
  group_by(task, interference, ID) %>%
  summarize(mRT = mean(rt))

RNI <- subset(collapsed, task == "reading" & interference == 0)
RI <- subset(collapsed, task == "reading" & interference == 1)
NNI <- subset(collapsed, task == "naming" & interference == 0)
NI <- subset(collapsed, task == "naming" & interference == 1)

ReadingNoInt <- RNI$mRT
ReadingInt <- RI$mRT
NamingNoInt <- NNI$mRT
NamingInt <- NI$mRT

data <- data.frame(cbind(ReadingNoInt,ReadingInt,NamingNoInt,NamingInt))


write.csv(rawdata, "/Users/ethan/Documents/GitHub/OpenSesame/Stroop/data/rawdata.csv", row.names=FALSE)
write.csv(data, "/Users/ethan/Documents/GitHub/OpenSesame/Stroop/data/data.csv", row.names=FALSE)

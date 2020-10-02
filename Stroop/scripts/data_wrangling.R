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


collapsed$task[collapsed$task == 'Reading'] <- 'reading'

write.csv(rawdata, "/Users/ethan/Documents/GitHub/OpenSesame/Stroop/data/data.csv", row.names=FALSE)


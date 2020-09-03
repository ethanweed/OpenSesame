#rm(list = ls())

#setwd ("/Users/ethan/Documents/GitHub/OpenSesame/Stroop/")
#data <- read.csv("test_results.csv")


Reading_NoInt <- data$response_time_Reading_NoInt_Response[!is.na(data$response_time_Reading_NoInt_Response)]
Reading_Int <- data$response_time_Reading_Int_response[!is.na(data$response_time_Reading_Int_response)]
Naming_NoInt <- data$response_time_Naming_NoInt_response[!is.na(data$response_time_Naming_NoInt_response)]
Naming_Int <- data$response_time_Naming_Int_Response[!is.na(data$response_time_Naming_Int_Response)]

df <- data.frame(Reading_Int, Reading_NoInt, Naming_Int, Naming_NoInt)

c <- numeric()
a <- nrow(df)/12
b <- for (i in 1:a){
  d <- rep(i,12)
  c <- append(c,d)
}

df$ID <- as.factor(c)


write.csv(df, "test_results_ID.csv")

paste0("You can find your data here: ", getwd())
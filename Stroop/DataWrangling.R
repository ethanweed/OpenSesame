#rm(list = ls())
#
#setwd ("path")
#data <- read.csv("filename.csv")

# You can copy and paste this code into the R module in JASP to correctly format your data for analysis.
# After the code runs, look in the R console in JASP for an instruction on where to find you formatted data.
# Close JASP, find the newly-formatted data, load it into a new JASP window, and you should be ready to go.


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
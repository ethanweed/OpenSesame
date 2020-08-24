# Just in case, remove all variables from the global environment
rm(list = ls())

# Script for wrangling OpenSesame/JATOS data from "MemorySpan_1"

# Critical! 
# I have not yet added a way to automatically identify each particpant in the data file, so you **must** do this manually before running this script!!

# input the path to the folder where your data are stored here
setwd("/Users/ethan/Documents/GitHub/OpenSesame/MemorySpan/")

# input name of data file here (after you have exported from JATOS and converted JATOS output to CSV using OSweb tool in OpenSesame)
data <- read.csv("sample_data.csv")


# get correct answer

# convert correct answer data to characters (strings)
data$A <- as.character(data$A)
data$B <- as.character(data$B)
data$C <- as.character(data$C)
data$D <- as.character(data$D)
data$E <- as.character(data$E)
data$F <- as.character(data$F)
data$G <- as.character(data$G)
data$H <- as.character(data$H)

# combine the correct answers and remove the placeholder "w's"
cr <- vector(mode="character", length=nrow(data))
for (i in 1:nrow(data)){
  cr[i] <- paste0(data$A[i], data$B[i], data$C[i], data$D[i], data$E[i], data$E[i], data$G[i])
}
cr <- gsub("w", "", cr, fixed = TRUE)


# get participant's actual answer
ans <- data$multichar_response
ans <- gsub("enter", "", ans)

# compare answers

# make binary correct / incorrect score
correct <- vector(mode="character", length=nrow(data))
for(i in 1:nrow(data)){
  correct[i] <- identical(cr[i], ans[i])
}

# score answer as a percent correct, ignoring order
partial_correct <- vector(mode="character", length=nrow(data))
for(i in 1:nrow(data)){
  aa <- unlist(strsplit(cr[i],""))
  bb <- unlist(strsplit(ans[i],""))
  partial_correct[i] <- round(length(intersect(aa, bb))/length(aa) *100, digits = 2)
}

# create vectors with the data we want
id <- data$subject_nr
condition <- data$condition
span <- data$span
correct_answer <- cr
participant_answer <- ans
rt <- data$response_time

# assemble data vectors into a dataframe
df <- data.frame(id, condition, span, correct_answer, participant_answer, correct, rt)
df$id <- as.factor(id)
df$span <- as.factor(span)
df$correct_answer <- as.character(df$correct_answer)
df$percent_correct <- as.numeric(partial_correct)
df$participant_answer <- as.character(participant_answer)

# save the wrangled data in a csv file
write.csv(df, "data.csv")

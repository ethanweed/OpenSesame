# Just in case, remove all variables from the global environment
#rm(list = ls())

# Script for wrangling OpenSesame/JATOS data from "MemorySpan_1"

# input the path to the folder where your data are stored here
#setwd("/Users/ethan/Documents/GitHub/OpenSesame/MemorySpan/")

# input name of data file here (after you have exported from JATOS and converted JATOS output to CSV using OSweb tool in OpenSesame)
#data <- read.csv("test_results.csv")


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
cr <- gsub("w", "", cr)


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

# generate subject id's from timestamps
data$id <- data$datetime
levels(data$id) <- seq(1, length(levels(data$id)))


# create vectors with the data we want
id <- data$id
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


df_agg <- aggregate(df, list(df$id, df$span, df$condition), mean)
df_agg$id <- NULL
df_agg$condition <- NULL
df_agg$correct <- NULL
df_agg$correct_answer <- NULL
df_agg$span <- NULL
df_agg$participant_answer <- NULL

colnames(df_agg)[colnames(df_agg) == "Group.1"] <- "ID"
colnames(df_agg)[colnames(df_agg) == "Group.2"] <- "Span"
colnames(df_agg)[colnames(df_agg) == "Group.3"] <- "Condition"

# save the wrangled data in a csv file
write.csv(df, "data.csv")
write.csv(df_agg, "data_aggregated.csv")

paste0("You can find your data here: ", getwd())

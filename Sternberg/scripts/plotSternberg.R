
# Analysis of Sternberg task data
#
# Step one: export data from JATOS server (I have done this for you already)
# Step two: use OpenSesame to convert raw data from JATOS text file to .csv file

# Clear global environment. Not really necessary, but it is an old habit
rm(list = ls())

# Load extra functions to make our life easier
library(tidyverse)

# Read raw data from csv file into an R dataframe
df <- read.csv("/Users/ethan/Documents/GitHub/OpenSesame/Sternberg/data/jatos_results_2020.csv")
# df <- read.csv("/path/to/data/file.csv")

# generate subject id's from timestamps

# make a new column in the data frame for subject ID numbers and fill with the date- and timestamps
df$id <- df$datetime

# change the date- and timestamps to ID numbers, with a new ID number corresponding to each new date- and timestamp
levels(df$id) <- seq(1, length(levels(df$id)))

# Make a new dataframe with just the variables we are interested in
d <- select(df, id, block, correct, present, setSize, response_time)

# change "n" and "y" to 
d$present <- ifelse(d$present == "n", "NotPresent", "Present")

# Remove all the practice trials and rename "response_time" as "rt"
experiment <- d %>%
  filter(block != "practice") %>%
  mutate(rt = response_time, Present = present)

# Keep only the correct answers
correct <- experiment %>%
  filter(correct == 1) 

# Find the average response time for each participant in each condition (each set size, and probe both present and absent)
collapsed <- correct %>%
  group_by(setSize, present, id) %>%
  summarize(mRT = mean(rt))

# Collapse the data further: find the mean response time across participants for each set size with probes present and absent
meansMatrix <- collapsed %>%
  group_by(setSize, present) %>%
  summarize(m = mean(mRT)) %>%
  spread(key = present, value = m) %>%
  as.matrix()

# Convert matrix back to dataframe and rename variables for plotting purposes
dfMeans <- as.data.frame(meansMatrix)
#colnames(dfMeans) <- c("SetSize", "NotPresent", "Present")

# Convert dfMeans from wide format to long format for plotting with ggplot
dfMeans_long <- dfMeans %>%
  gather(key = Present, value = RT, -setSize)

# Plot the data, showing points for mean values at each set size
ggplot(dfMeans_long, aes(setSize, RT, color = Present)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Sternberg Task (means)",
       y = "RT",
       x = "SetSize") +
  theme_classic()

# Plot the data, showing points for all values at each set size
ggplot(correct, aes(setSize, rt, color = present)) +
  geom_point() + 
  geom_smooth(method = "lm") +
  labs(title = "Sternberg Task (all data)",
       y = "RT",
       x = "SetSize") +
  theme_classic()

# Model comparison

## Null hypothesis model
mod0 <- lm(rt ~ setSize, data = correct)


## Alternative hypothesis model
mod1 <- lm(rt ~ setSize + present, data = correct)
summary(mod1)

## Model comparison
anova(mod0, mod1)

# save the data in a csv file
#write.csv(correct, file = "/Users/ethan/Documents/GitHub/OpenSesame/Sternberg/data/Sternberg_data_correct.csv")
write.csv(correct, file = "/Users/ethan/Desktop/blah1.csv")

# save only the means for present/absent and setsize in a csv file
#write.csv(dfMeans, file = "/Users/ethan/Documents/GitHub/OpenSesame/Sternberg/data/Sternberg_data_present_absent.csv")
write.csv(dfMeans, file = "/Users/ethan/Desktop/blah2.csv")


df_long <- gather(dfMeans, key = present, value = rt, -setSize)

write.csv(df_long, file="/Users/ethan/Documents/GitHub/OpenSesame/Sternberg/data/data_long.csv", row.names = FALSE)


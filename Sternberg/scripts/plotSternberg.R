
rm(list = ls())

library(tidyverse)

df <- read.csv("/Users/ethan/Documents/GitHub/OpenSesame/Sternberg/data/jatos_results_20200923231208.csv")

# generate subject id's from timestamps
df$id <- df$datetime
levels(df$id) <- seq(1, length(levels(df$id)))

d <- select(df, id, block, correct, present, setSize, response_time)

experiment <- d %>%
  filter(block != "practice") %>%
  mutate(rt = response_time)

correct <- experiment %>%
  filter(correct == 1) 

collapsed <- correct %>%
  group_by(setSize, present, id) %>%
  summarize(mRT = mean(rt))


meansMatrix <- collapsed %>%
  group_by(setSize, present) %>%
  summarize(m = mean(mRT)) %>%
  spread(key = present, value = m) %>%
  as.matrix()


dfMeans <- as.data.frame(meansMatrix)
colnames(dfMeans) <- c("Span", "NotPresent", "Present")

dfMeans <- dfMeans %>%
  gather(key = Present, value = RT, -Span)


ggplot(dfMeans, aes(Span, RT, color = Present)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_classic()

ggplot(correct, aes(setSize, rt, color = present)) +
  geom_point() + 
  geom_smooth(method = "lm") +
  theme_bw()


write.csv(correct, file = "/Users/ethan/Documents/GitHub/OpenSesame/Sternberg/data/Sternberg_data_correct.csv")

present_absent <- select(correct, id,  present, rt)
present_absent %>%
  group_by(present)


library(tidyverse)

df <- read.csv("/Users/ethan/Documents/GitHub/OpenSesame/Sternberg/data/jatos_results_20200914140649.csv")
d <- select(df, block, correct, present, setSize, response_time)

experiment <- d %>%
  filter(block != "practice") %>%
  mutate(rt = response_time)

correct <- experiment %>%
  filter(correct == 1) 

collapsed <- correct %>%
  group_by(setSize, present) %>%
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

model <- lm(RT ~ Span, dfMeans)

ggplot(dfMeans, aes(Span, RT, color = Present)) +
  geom_point() +
  geom_smooth(method = "lm")



# Question 1: What type of data is this?
# Question 2: Does it have constant variance?
# Question 3: What distribution and link function are more appropriate?
# import packages, set working directory, and import data
library('tidyverse')
library('ggplot2')
setwd('C:/Users/alandrigan/Documents/Phenomic Selection/')
data <- read.csv('./Cleaned_Data.csv')

# sort data to only keep the columns we want to keep (trait, value, and label)
# filter the trait column to only keep rows where the trait is wavelength_means
sorted_data <- data %>%
  select(trait, value, label) %>%
  filter(trait == 'wavelength_means')

# change the data type from character to numeric for the label column
sorted_data$label <- as.numeric(sorted_data$label)

#plot wavelength means to see data distribution
ggplot(sorted_data, aes(x = label, y = value)) + 
  geom_point() +
  geom_jitter(width = 10) +
  labs(y = "Mean Reflectance",
       x = "Wavelength") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 75, hjust = 1, size=8))
dev.off()

# question answers in readme file in main

library(tidyverse)
library(dplyr)
library(ggplot2)

# select dataset to explore
# selecting Plate 10 for sake of exploration, all 282 CSV's are set up identically though
Plate10 <- read.csv('C:/Users/alandrigan/Documents/Phenomic Selection/Image_Analysis_Outputs_Good/Plate10.csv')

# find column names in Plate 10
colnames(Plate10)
# image_height, image_width, run_date, plantcv_version, sample, trait, value, label - eight columns

# number of columns - should be eight
ncol(Plate10)
# ncol = 8

# how many rows?
nrow(Plate10)
# nrow = 57096

# Is the number of columns and rows consistent across plates?
Plate13 <- read.csv('C:/Users/alandrigan/Documents/Phenomic Selection/Image_Analysis_Outputs_Good/Plate13.csv')

# column names, column number, and row number in Plate 13 - Are they the same as Plate 10?
colnames(Plate13)
ncol(Plate13)
nrow(Plate13)
# image_height, image_width, run_date, plantcv_version, sample, trait, value, label - eight columns
# ncol = 8
# nrow = 57096
# same in all three, let's continue with Plate 10

# what are the unique traits we have?
unique(Plate10$trait)
# in_bounds, area, convex_hull_area, solidity, perimeter, total_edge_length, width, height, 
# longest_path, center_of_mass, convex_hull_vertices, object_in_frame, ellipse_center,
# ellipse_major_axis, ellipse_minor_axis, ellipse_angle, ellipse_eccentricity, hue_frequencies,
# saturation_frequencies, value_frequencies, hue_circular_mean, hue_circular_std,
# hue_median global_mean_reflectance, global_median_reflectance, global_spectral_std,
# wavelength_means, max_reflectance, min_reflectance, and spectral_std
# 30 unique traits

# find data types of our columns and data structure of plate 10
str(Plate10)
# Plate 10 is a data frame
# all columns have a data type of 'Character', except for the 'value' column, whose data type is numeric

# How is our data distributed? Vizualize this by using seed mean reflectance at each wavelength

# split 'sample' column into 'tissue' and 'sample'
Plate10_sep <- Plate10 %>%
  separate(
    col = sample,
    into = c('tissue', 'sample'),
    sep = '_'
  )

# select seed tissue, keep tissue, trait, value, and label columns
Plate10_seed <- Plate10_sep %>%
  select(tissue, trait, value, label) %>%
  filter(tissue == 'seed')

# filter by wavelength means
Plate10_seed_means <- Plate10_seed %>%
  filter(trait == 'wavelength_means')

#vizualize spectral standard deviation of the seeds
ggplot(Plate10_seed_means, aes(x = label, y = value)) + 
  geom_boxplot() +
  labs(y = "Mean Reflectance",
       x = "Wavelengths (nm)") +
  theme_bw()
# The mean reflectance of our seeds increases as wavelengths get longer

# lets see if there is a difference between seed, wing, and kernel mean reflectance
# filter by wavelength means

Plate10_all <- Plate10_sep %>%
  select(tissue, trait, value, label) %>%
  filter(trait == 'wavelength_means')

# make a graph with three panels
ggplot(Plate10_all, aes(x = label, y = value)) + 
  geom_boxplot() +
  facet_wrap(~tissue, ncol = 3) +
  labs(y = "Mean Reflectance",
       x = "Wavelengths (nm)") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 75, hjust = 1, size=8))
dev.off()
# mean reflectance increases more in the wing than in the kernel or seed structures as wavelengths get longer
# mean reflectance increases the least in the kernel structure as wavelengths get longer










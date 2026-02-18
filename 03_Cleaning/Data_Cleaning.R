# import libraries and set working directory
library(tidyverse)
setwd('C:/Users/alandrigan/Documents/Phenomic Selection/Image_Analysis_Outputs_Good')

# source all data files from directory
files <- list.files('./', pattern='*.csv')

# create function to generate data frame from csv files
read_plate <- function(csv){
  df <- read.csv(csv) %>%
    mutate(Plate = str_sub(csv, 1, -5))
  return(df)
}

# use 'read_plate' function to generate data frame that contains all data from 'files'
df <- lapply(X=files, FUN=read_plate) %>%
  bind_rows()

# separate 'sample' column into two columns for tissue and sample number
df <- df %>%
  separate(
    col = sample,
    into = c('tissue', 'sample'),
    sep = '_'
  )

# the seeds in the multispectral images are mirrored, so the sample number is incorrect

# change working directory now that data frame is generated
setwd('C:/Users/alandrigan/Documents/Phenomic Selection')

# read in the key file by which to modify the data frame
# this key file is used to assign tissues the correct sample number
key <- read.csv('./CSV/Key/Key_SeedID_Position_Structure.csv')

# merge the data frame with the key file by the 'sample' column
# adds 3 new columns: 'Row', 'Column', and 'Plate_Row_Column'
df <- merge(df, key, by='sample')

# mutate contents of 'Plate_Row_Column' column in data frame with plate number
df <- df %>%
  mutate(Plate_Row_Column = paste(Plate, Plate_Row_Column, sep='_'))

# read in metadata files
md1 <- read.csv('./CSV/Metadata/Silphium 2024 Seed Metadata and Germination - Germ_all.csv')
md2 <- read.csv('./CSV/Metadata/Silphium 2024 Seed Metadata and Germination - Sheet1.csv')

# merge metadata files into one file by the 'Seed_ID' column
meta <- merge(md1, md2, by='Seed_ID') %>%
# our cohorts are cohorts 2, 3 and 4
# mutate cohort column to increase the value of each cohort by 1 (cohorts currently 1, 2 and 3)
  mutate(Cohort = Cohort.x + 1) %>%
# select columns to keep
  select(Cohort, Seed_ID, Barcode, Days_to_germ, Germ_prop, Establishment, Plate_ID, Row, Column, Lemnatec_pop) %>%
# create 'Plate_Row_Column' column in same format as the one in df
  mutate(Plate_Row_Column = paste('Plate', Plate_ID, '_R', Row, '_C', Column, sep=''))

# merge df and meta by the 'Plate_Row_Column' column
df <- merge(df, meta, by='Plate_Row_Column')

# remove any rows that have bar codes not starting with 'Ra'
df <- df %>%
  filter(startsWith(Barcode, 'Ra'))

# save cleaned data as a CSV
write.csv(d, file='./CSV/Cleaned_Data.csv')
library(tidyverse)
setwd("C:/Users/alandrigan/Documents/Phenomic Selection/KernelWing/KernelWingFunctionOutputsNew")

read_plate <- function(csv){
  d <- read.csv(csv) %>%
    mutate(Plate = str_sub(csv, 1, -5))
  return(d)
}

files <- list.files('./', pattern='*.csv')

d <- lapply(X=files, FUN=read_plate) %>%
  bind_rows()

key <- read.csv('C:/Users/alandrigan/Documents/Phenomic Selection/KernelWing/Key_SeedID_Position_Structure.csv')

d <- d %>%
  separate(
    col = sample,
    into = c('tissue', 'sample'),
    sep = '_'
  )

d <- merge(d, key, by='sample')
d <- d %>%
  mutate(Plate_Row_Column = paste(Plate, Plate_Row_Column, sep='_'))

meta_p1 <- read.csv('C:/Users/alandrigan/Documents/Phenomic Selection/KernelWing/Silphium 2024 Seed Metadata and Germination - Germ_all.csv')
meta_p2 <- read.csv('C:/Users/alandrigan/Documents/Phenomic Selection/KernelWing/Silphium 2024 Seed Metadata and Germination - Sheet1.csv')

meta <- merge(meta_p1, meta_p2, by='Seed_ID') %>%
  mutate(Cohort = Cohort.x + 1) %>%
  select(Cohort, Seed_ID, Barcode, Days_to_germ, Germ_prop, Establishment, Plate_ID, Row, Column, Lemnatec_pop) %>%
  mutate(Plate_Row_Column = paste('Plate', Plate_ID, '_R', Row, '_C', Column, sep=''))

d <- merge(d, meta, by='Plate_Row_Column')

d_sub <- d %>%
  filter(startsWith(Barcode, 'Ra')) #%>%
  #filter(trait == 'wavelength_means') # any line that looks like this

d_lms <- d_sub %>%
  nest_by(Cohort, label, tissue, trait) %>%
  mutate(lmod = list(anova(lm(scale(value) ~ Lemnatec_pop, data=data)))) %>%
  reframe(broom::tidy(lmod))

write.csv(d, file='C:/Users/alandrigan/Documents/Phenomic Selection/KernelWing/2025_Silphium_videometer_compiled_C2-4_includes_wing_kernel.csv')

d %>%
  group_by(Cohort) %>%
  summarize(n = length(unique(Lemnatec_pop)))

d %>%
  group_by(Cohort) %>%
  summarize(n = length(unique(Seed_ID)))

#pdf('../2025_silphium_videometer_lms.pdf', height=4, width=8)
#ggplot(d_lms, aes(x=label, y=statistic, color=as.factor(Cohort))) + 
#  geom_point(size=4) +
#  scale_x_discrete(labels = function(x) str_sub(x, 1, -3))+
#  labs(y = "F-statistic: ref ~ family", 
#       x = "Wavelength (nm)", 
#       color = "Cohort") + 
#  theme_bw()
#dev.off()

#pdf('../2025_silphium_videometer_box.pdf', height=4, width=8)
#ggplot(d_sub, aes(x = label, y=value, fill=as.factor(Cohort))) + 
#  geom_boxplot() + 
#  scale_x_discrete(labels = function(x) str_sub(x, 1, -3))+
#  labs(y = "Reflectance", 
#       x = "Wavelength (nm)", 
#       fill = "Cohort") + 
#  theme_bw()
#dev.off()
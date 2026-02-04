setwd("C:/Users/alandrigan/Documents/Phenomic Selection/KernelWing")
library("tidyverse")

spectral_relationship <- function(df){
  df <- df %>%
    remove_rownames() %>%
    column_to_rownames(var = "Barcode") %>%
    select_if(function(col) is.numeric(col) && sd(col) != 0)
  S <- df %>% as.matrix() %>%
    scale(x = ., center = TRUE, scale = TRUE)
  H <- tcrossprod(S) / ncol(df)
  return(H)
}

reorder_relmx <- function(relmx, barcodes) {
  return(relmx[barcodes, barcodes])
}

## first round of matrices, small set

trait_data <- read.csv("C:/Users/alandrigan/Documents/Phenomic Selection/KernelWing/2025_Silphium_videometer_compiled_C2-4_includes_wing_kernel.csv", header = TRUE) 
trait_data_filt <- trait_data %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort %in% c('2', '3', '4'))

seed_hsv_mean_morph_total <- trait_data_filt %>%
  filter(tissue == 'seed') %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
seed_hsv_mean_morph_c2 <- trait_data_filt %>%
  filter(tissue == 'seed') %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '2') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
seed_hsv_mean_morph_c3 <- trait_data_filt %>%
  filter(tissue == 'seed') %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '3') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
seed_hsv_mean_morph_c4 <- trait_data_filt %>%
  filter(tissue == 'seed') %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '4') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')

wing_hsv_mean_morph_total <- trait_data_filt %>%
  filter(tissue == 'wing') %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
wing_hsv_mean_morph_c2 <- trait_data_filt %>%
  filter(tissue == 'wing') %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '2') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
wing_hsv_mean_morph_c3 <- trait_data_filt %>%
  filter(tissue == 'wing') %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '3') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
wing_hsv_mean_morph_c4 <- trait_data_filt %>%
  filter(tissue == 'wing') %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '4') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')

kernel_hsv_mean_morph_total <- trait_data_filt %>%
  filter(tissue == 'kernel') %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
kernel_hsv_mean_morph_c2 <- trait_data_filt %>%
  filter(tissue == 'kernel') %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '2') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
kernel_hsv_mean_morph_c3 <- trait_data_filt %>%
  filter(tissue == 'kernel') %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '3') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
kernel_hsv_mean_morph_c4 <- trait_data_filt %>%
  filter(tissue == 'kernel') %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '4') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')

seed_hsv_mean_total <- trait_data_filt %>%
  filter(tissue == 'seed') %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
seed_hsv_mean_c2 <- trait_data_filt %>%
  filter(tissue == 'seed') %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '2') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
seed_hsv_mean_c3 <- trait_data_filt %>%
  filter(tissue == 'seed') %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '3') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
seed_hsv_mean_c4 <- trait_data_filt %>%
  filter(tissue == 'seed') %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '4') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')

wing_hsv_mean_total <-trait_data_filt %>%
  filter(tissue == 'wing') %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
wing_hsv_mean_c2 <-trait_data_filt %>%
  filter(tissue == 'wing') %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '2') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
wing_hsv_mean_c3 <-trait_data_filt %>%
  filter(tissue == 'wing') %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '3') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
wing_hsv_mean_c4 <-trait_data_filt %>%
  filter(tissue == 'wing') %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '4') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')

kernel_hsv_mean_total <-trait_data_filt %>%
  filter(tissue == 'kernel') %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
kernel_hsv_mean_c2 <-trait_data_filt %>%
  filter(tissue == 'kernel') %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '2') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
kernel_hsv_mean_c3 <-trait_data_filt %>%
  filter(tissue == 'kernel') %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '3') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')
kernel_hsv_mean_c4 <-trait_data_filt %>%
  filter(tissue == 'kernel') %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '4') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep = '_')) %>%
  select(Barcode, trait_label, value) %>%
  pivot_wider(names_from='trait_label', values_from='value')

swk_hsv_mean_total <- trait_data_filt %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep='_')) %>%
  mutate(trait_label_tissue = paste(trait_label, tissue, sep = '_')) %>%
  select(Barcode, trait_label_tissue, value) %>%
  pivot_wider(names_from='trait_label_tissue', values_from='value')
swk_hsv_mean_c2 <- trait_data_filt %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '2') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep='_')) %>%
  mutate(trait_label_tissue = paste(trait_label, tissue, sep = '_')) %>%
  select(Barcode, trait_label_tissue, value) %>%
  pivot_wider(names_from='trait_label_tissue', values_from='value')
swk_hsv_mean_c3 <- trait_data_filt %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '3') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep='_')) %>%
  mutate(trait_label_tissue = paste(trait_label, tissue, sep = '_')) %>%
  select(Barcode, trait_label_tissue, value) %>%
  pivot_wider(names_from='trait_label_tissue', values_from='value')
swk_hsv_mean_c4 <- trait_data_filt %>%
  filter(trait %in% c('wavelength_means', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '4') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep='_')) %>%
  mutate(trait_label_tissue = paste(trait_label, tissue, sep = '_')) %>%
  select(Barcode, trait_label_tissue, value) %>%
  pivot_wider(names_from='trait_label_tissue', values_from='value')

swk_hsv_mean_morph_total <- trait_data_filt %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep='_')) %>%
  mutate(trait_label_tissue = paste(trait_label, tissue, sep = '_')) %>%
  select(Barcode, trait_label_tissue, value) %>%
  pivot_wider(names_from='trait_label_tissue', values_from='value')
swk_hsv_mean_morph_c2 <- trait_data_filt %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '2') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep='_')) %>%
  mutate(trait_label_tissue = paste(trait_label, tissue, sep = '_')) %>%
  select(Barcode, trait_label_tissue, value) %>%
  pivot_wider(names_from='trait_label_tissue', values_from='value')
swk_hsv_mean_morph_c3 <- trait_data_filt %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '3') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep='_')) %>%
  mutate(trait_label_tissue = paste(trait_label, tissue, sep = '_')) %>%
  select(Barcode, trait_label_tissue, value) %>%
  pivot_wider(names_from='trait_label_tissue', values_from='value')
swk_hsv_mean_morph_c4 <- trait_data_filt %>%
  filter(trait %in% c('wavelength_means', 'area', 'perimeter', 'ellipse_minor_axis', 'ellipse_major_axis', 'ellipse_eccentricity', 'hue_frequencies', 'saturation_frequencies', 'value_frequencies')) %>%
  filter(Cohort == '4') %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  mutate(trait_label = paste(trait, label, sep='_')) %>%
  mutate(trait_label_tissue = paste(trait_label, tissue, sep = '_')) %>%
  select(Barcode, trait_label_tissue, value) %>%
  pivot_wider(names_from='trait_label_tissue', values_from='value')

## trait data
trait_data_phenos <- trait_data_filt %>%
  filter(startsWith(Barcode, 'Ra')) %>%
  select(Cohort, Barcode:Establishment) %>%
  unique()

barcodes <- intersect(kernel_hsv_mean_total$Barcode, kernel_hsv_mean_c2$Barcode) %>%
  intersect(., kernel_hsv_mean_c3$Barcode) %>%
  intersect(., kernel_hsv_mean_c4$Barcode) %>%
  intersect(., seed_hsv_mean_morph_total$Barcode) %>%
  intersect(., seed_hsv_mean_morph_c2$Barcode) %>%
  intersect(., seed_hsv_mean_morph_c3$Barcode) %>%
  intersect(., seed_hsv_mean_morph_c4$Barcode) %>%
  intersect(., wing_hsv_mean_morph_total$Barcode) %>%
  intersect(., wing_hsv_mean_morph_c2$Barcode) %>%
  intersect(., wing_hsv_mean_morph_c3$Barcode) %>%
  intersect(., wing_hsv_mean_morph_c4$Barcode) %>%
  intersect(., kernel_hsv_mean_morph_total$Barcode) %>%
  intersect(., kernel_hsv_mean_morph_c2$Barcode) %>%
  intersect(., kernel_hsv_mean_morph_c3$Barcode) %>%
  intersect(., kernel_hsv_mean_morph_c4$Barcode) %>%
  intersect(., seed_hsv_mean_total$Barcode) %>%
  intersect(., seed_hsv_mean_c2$Barcode) %>%
  intersect(., seed_hsv_mean_c3$Barcode) %>%
  intersect(., seed_hsv_mean_c4$Barcode) %>%
  intersect(., wing_hsv_mean_total$Barcode) %>%
  intersect(., wing_hsv_mean_c2$Barcode) %>%
  intersect(., wing_hsv_mean_c3$Barcode) %>%
  intersect(., wing_hsv_mean_c4$Barcode) %>%
  intersect(., swk_hsv_mean_morph_total$Barcode) %>%
  intersect(., swk_hsv_mean_morph_c2$Barcode) %>%
  intersect(., swk_hsv_mean_morph_c3$Barcode) %>%
  intersect(., swk_hsv_mean_morph_c4$Barcode) %>%
  intersect(., swk_hsv_mean_total$Barcode) %>%
  intersect(., swk_hsv_mean_c2$Barcode) %>%
  intersect(., swk_hsv_mean_c3$Barcode) %>%
  intersect(., swk_hsv_mean_c4$Barcode)
  
trait_data_phenos <- trait_data_phenos %>%
  filter(Barcode %in% barcodes)

## list of relationship matrices
relmxs <- list(kernel_hsv_mean_total = spectral_relationship(kernel_hsv_mean_total), 
               kernel_hsv_mean_c2 = spectral_relationship(kernel_hsv_mean_c2),
               kernel_hsv_mean_c3 = spectral_relationship(kernel_hsv_mean_c3),
               kernel_hsv_mean_c4 = spectral_relationship(kernel_hsv_mean_c4),
               
               seed_hsv_mean_morph_total = spectral_relationship(seed_hsv_mean_morph_total), 
               seed_hsv_mean_morph_c2 = spectral_relationship(seed_hsv_mean_morph_c2),
               seed_hsv_mean_morph_c3 = spectral_relationship(seed_hsv_mean_morph_c3),
               seed_hsv_mean_morph_c4 = spectral_relationship(seed_hsv_mean_morph_c4),
               
               wing_hsv_mean_morph_total = spectral_relationship(wing_hsv_mean_morph_total),
               wing_hsv_mean_morph_c2 = spectral_relationship(wing_hsv_mean_morph_c2),
               wing_hsv_mean_morph_c3 = spectral_relationship(wing_hsv_mean_morph_c3),
               wing_hsv_mean_morph_c4 = spectral_relationship(wing_hsv_mean_morph_c4),
               
               kernel_hsv_mean_morph_total = spectral_relationship(kernel_hsv_mean_morph_total),
               kernel_hsv_mean_morph_c2 = spectral_relationship(kernel_hsv_mean_morph_c2),
               kernel_hsv_mean_morph_c3 = spectral_relationship(kernel_hsv_mean_morph_c3),
               kernel_hsv_mean_morph_c4 = spectral_relationship(kernel_hsv_mean_morph_c4),
               
               seed_hsv_mean_total = spectral_relationship(seed_hsv_mean_total),
               seed_hsv_mean_c2 = spectral_relationship(seed_hsv_mean_c2),
               seed_hsv_mean_c3 = spectral_relationship(seed_hsv_mean_c3),
               seed_hsv_mean_c4 = spectral_relationship(seed_hsv_mean_c4),
               
               wing_hsv_mean_total = spectral_relationship(wing_hsv_mean_total),
               wing_hsv_mean_c2 = spectral_relationship(wing_hsv_mean_c2),
               wing_hsv_mean_c3 = spectral_relationship(wing_hsv_mean_c3),
               wing_hsv_mean_c4 = spectral_relationship(wing_hsv_mean_c4),
               
               swk_hsv_mean_morph_total = spectral_relationship(swk_hsv_mean_morph_total),
               swk_hsv_mean_morph_c2 = spectral_relationship(swk_hsv_mean_morph_c2),
               swk_hsv_mean_morph_c3 = spectral_relationship(swk_hsv_mean_morph_c3),
               swk_hsv_mean_morph_c4 = spectral_relationship(swk_hsv_mean_morph_c4),
               
               swk_hsv_mean_total = spectral_relationship(swk_hsv_mean_total),
               swk_hsv_mean_c2 = spectral_relationship(swk_hsv_mean_c2),
               swk_hsv_mean_c3 = spectral_relationship(swk_hsv_mean_c3),
               swk_hsv_mean_c4 = spectral_relationship(swk_hsv_mean_c4))
               
relmxs <- lapply(X=relmxs, FUN=reorder_relmx, barcodes=trait_data_phenos$Barcode)
lapply(relmxs, dim) #all should be equal

phenos <- c('Germ_prop', 'Days_to_germ', 'Establishment')

####
results.df <- NULL
results_list <- list()

for (relmx in names(relmxs)){
  for(pheno.j in phenos){ 
    message(sprintf("[%s] Fitting %s with %s", 
                    Sys.time(), pheno.j, relmx))
  
    trait_data_phenos2 <- trait_data_phenos %>%
      filter(Barcode %in% colnames(relmxs[[relmx]]))
    relmx_ordered <- reorder_relmx(relmxs[[relmx]], barcodes=trait_data_phenos2$Barcode)
      
    results.jk <- run_BGLR(
      trial.df = as.data.frame(trait_data_phenos2),
      y.colname = pheno.j,
      germplasm.colname = "Barcode",
      spectral_relmx = relmx_ordered,
      spectral_relmx2 = NULL,
      seedling.colname = NULL, 
      adult.colname = NULL,
      env.model=NULL,
      k.folds = 5,
      seed = 27) %>%
      mutate(Matrix = relmx, 
             Trait = pheno.j)
    
    if(is.null(results.df)){ 
      results.df <- results.jk
    } else {
      # Stack results for each matrix:trait combo within each pretreatment together
      results.df <- rbind(results.df, results.jk) 
    }
  }
}

phenomic_results <- results.df
write.csv(phenomic_results, file='2026_silphium_predictions_kernel_wing_by_cohort.csv', quote = F)

results.summary <- phenomic_results %>%
  na.omit() %>%
  group_by(Trait, k.fold, Matrix) %>%
  dplyr::summarize(pearson = cor(pred, obs, method = "pearson"),
                   spearman = cor(pred, obs, method = "spearman")) 

write.csv(results.summary, "2026_silphium_performance_kernel_wing_by_cohort.csv", quote=F)

#############################################################################

lm(pearson ~ Matrix, data=results.summary) %>%
  car::Anova(type=2)

pdf('2026_silphium_test_figure.pdf', height=5, width=8)
results.summary %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill=Matrix)) +
  geom_hline(yintercept = 0) +
  geom_boxplot(lwd=0.75, fatten=1) +
  labs(title = "",
       subtitle = "",
       y = "Pearson's corr: pred ~ obv") +
  theme_bw() + 
  theme(legend.box.background = element_rect("gray")) + 
  theme(axis.title.x = element_blank()) +
  theme(axis.text=element_text(size=12), 
        axis.title.y=element_text(size=16))
dev.off()

# pdf("2025_tests_kfold5v10.pdf", height=5, width=15)
# rbind(results.summary %>% mutate(k=5), 
#       results.summary_k10 %>% mutate(k=10)) %>%
#   ggplot(aes(x = Trait, y = pearson, fill = as.factor(k))) +
#   geom_hline(yintercept = 0) +
#   geom_boxplot(lwd=0.75, fatten=1) + 
#   labs(title = "",
#        subtitle = "",
#        y = "Pearson's correlation of predicted vs observed values",
#        fill = "Folds") +
#   facet_wrap(~Matrix) + 
#   theme_bw() + 
#   theme(axis.text.x = element_text(angle = 0),
#         legend.box.background = element_rect("gray")) + 
#   theme(axis.title.x = element_blank()) +
#   theme(axis.text=element_text(size=16)) + 
#   theme(axis.text.x=element_text(angle = 90, hjust = 1, vjust=0.5))
# dev.off()

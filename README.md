# Multivariate Model Generation
This repository contains the data and code for my project in BIOL 5930-01: Data Analysis. This project uses data extracted from a multispectral image pipeline to generate univariate and multivariate relationship matrices to be used in phenomic selection models. Work in progress.

# Update #1

Question: Which models are best at predicting germination in _Silphium integrifolium_?

Explanatory variable: The univariate or multivariate relationship matrix

Response variable: The ability of a relationship matrix in a phenomic selection model to predict germination

# Update #2

My data has 8 columns, 57,096 rows, and 30 unique traits prior to cleaning. These numbers are consistent between data files.

My data files are dataframes. All columns have a 'Character' data type, aside from the 'value' column, whose data type is 'Numeric'.

I generated figures with ggplot to see how my mean reflectance data is distributed between tissues (whole seed, wing, and kernel). Across all tissues, the mean reflectance increased as wavelengths got longer. The mean reflectance in the wing tissue increased the most as the wavelengths got longer, and the mean reflectance of the kernel tissue increased the least. The mean reflectance of the whole seed tissue was between the kernel or wing in terms of increase.

# Activity 2/18/26

**1. What might be the fixed effects on your model?**

The wavelength traits, HSV color traits, morphology traits

**2. What might be the random effects on your model?**

The family the seeds come from (grandmother, mother)

**3. Do you expect random effects to change intercepts or slopes of the relationship between x and y?**

If we see differences in germination taits between families, then we would expect to see change in the slope of our data. Families that have higher germination rates would have greater y-intercepts, and families with lower germination would have lower y-intercepts.

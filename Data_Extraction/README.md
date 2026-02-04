The code within this folder is the data extraction pipeline for our multispectral images.

**2025_HIPS_conversion_HS:**

The VideometerLab device we used to take our multispectral images outputs images in a .HIPS format, which doesn't work with PlantCV. This file contains a function written by Haley Schuhl to convert these .HIPS images into a usable format, resulting in a .RAW and .HDR file for each image.

**seed-wing-kernel-analysis:**

This script was written with the assistance of Noah Fahlgren of the Donald Danforth Data Science Center team. This script allows us to test parameters to be put into our data extraction function (KernelWingFunction). As of now, there is no one-size-fits-all set of parameters we can use to extract data from these images, so this script exists to help vizualize what parameter changes we can use in the data extraction function. 

**KernelWingFunction:**

This function loops through all plates, extracts data from the achene, achene wing, and kernel structures, and save output images of each structure. The parameters we've used so far are listed below. See Plates_Run.csv to see which plates were properly processed by which set of parameters. Bold values are changed or added between runs. Work in progress.

**Run 1:**

colorspace = HSV, channel = h

c_thresh: ksize = 27000, offset = 40, object_type = Dark

roi rectangle: x = 277, y = 100, h = 2700, w = 3700

a_fill_img: size = 18000

wing_mask: threshold = 35, object_type = Light

kernel_err:: ksize = 3, i = 1

kernel_mask_clean: size = 2500

kernel_mask_dil: ksize = 3, i = 1

**Run 2:**

colorspace = HSV, channel = h

c_thresh: **ksize = 22000**, offset = 40, object_type = Dark

roi rectangle: x = 277, y = 100, h = 2700, w = 3700

a_fill_img: size = 18000

wing_mask: threshold = 35, object_type = Light

kernel_err:: ksize = 3, i = 1

kernel_mask_clean: size = 2500

kernel_mask_dil: ksize = 3, i = 1

**Run 3:**

colorspace = HSV, channel = h

c_thresh: ksize = 22000, offset = 40, object_type = Dark

roi rectangle: x = 277, y = 100, h = 2700, w = 3700

a_fill_img: size = 18000

wing_mask: **threshold = 40**, object_type = Light

kernel_err:: ksize = 3, i = 1

kernel_mask_clean: size = 2500

kernel_mask_dil: ksize = 3, i = 1

**Run 4:**

colorspace = HSV, channel = h

c_thresh: ksize = 22000, offset = 40, object_type = Dark

roi rectangle: x = 277, y = 100, h = 2700, w = 3700

a_fill_img: size = 18000

wing_mask: threshold = 40, object_type = Light

**wing_err: ksize = 4, i = 5**

**wing_mask_dil: ksize = 3, i = 1**

**wing_mask_clean: size = 2500**

kernel_err: **ksize = 4, i = 5**

kernel_mask_clean: **size = 2900**

kernel_mask_dil: **ksize = 4, i = 4**

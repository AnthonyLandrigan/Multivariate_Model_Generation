The code within this folder is the data extraction pipeline for our multispectral images.

**Image_Analysis_Workflow:**

This script was written with the assistance of Noah Fahlgren of the Donald Danforth Data Science Center team. This script allows us to test parameters to be put into our data extraction function (KernelWingFunction). As of now, there is no one-size-fits-all set of parameters we can use to extract data from these images, so this script exists to help vizualize what parameter changes we can use in the data extraction function. 

**Image_Analysis_Function:**

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

**Run 5:**

colorspace = HSV, channel = h

**Replace threshold.mean:**
**c_thresh = pcv.threshold.otsu(gray_img=c_img, object_type='dark')**

roi rectangle: x = 277, y = 100, h = 2700, **w = 3750**

a_fill_img: **size = 20000**

wing_mask: threshold = 40, object_type = Light

wing_err: ksize = 4, i = 5

wing_mask_dil: **ksize = 4, i = 2**

wing_mask_clean: size = 2500

**kernel mask now created from wing_mask_clean:**
**kernel_mask = flt_mask - wing_mask_clean**

kernel_err: **ksize = 10**, i = 5

kernel_mask_clean: size = 2900

kernel_mask_dil: **ksize = 8**, i = 4

**NEW: kernel_mask_fill = pcv.fill_holes(bin_img=kernel_mask_dil)**

**NEW: wing_mask_final = flt_mask - kernel_mask_fin**

**Create wing labels moved after the creation of wing_mask_final:**
**wing_labeled_mask, num = pcv.create_labels(mask=wing_mask, rois=rois)**

**Added morphological, spectral, and HSV data extraction steps for seed, wing, and kernel towards the end:**

**X_shape_img = pcv.analyze.size(img=img.pseudo_rgb, labeled_mask=X_mask, n_labels=num, label="X")**

**X_hsv_img = pcv.analyze.color(rgb_img=img.pseudo_rgb, labeled_mask=X_mask, n_labels=num, label="X")**

**X_analysis_img = pcv.analyze.spectral_reflectance(hsi=img, labeled_mask=X_mask, n_labels=num, label='X')**

setwd("C:/Users/alandrigan/Documents/Phenomic Selection/KernelWing")
library("tidyverse")

#anova
rawdata <- read.csv("C:/Users/alandrigan/Documents/Phenomic Selection/KernelWing/2025_Silphium_videometer_compiled_C2-4_includes_wing_kernel.csv")

rawdata_filt <- rawdata %>%
  filter(tissue %in% c('wing', 'kernel')) %>%
  filter(trait == 'area') %>%
  filter(Cohort == '2') %>%
  select('Barcode', 'trait', 'tissue', 'value') %>%
  pivot_wider(names_from = 'tissue', values_from = 'value') %>%
  mutate(kernel_wing_ratio = kernel/wing) %>%
  mutate(population = str_sub(Barcode, 1, 5))

anova(lm(data=rawdata_filt, kernel_wing_ratio~population))
anova(lm(data=rawdata_filt, wing~population))
anova(lm(data=rawdata_filt, kernel~population))

cor(rawdata_filt$kernel,rawdata_filt$wing)

#All
results.summary <- read.csv("C:/Users/alandrigan/Documents/Phenomic Selection/KernelWing/2026_silphium_performance_kernel_wing_by_cohort.csv")

#By cohort or total only
results.summary_total <- results.summary %>%
  filter(grepl("total$", Matrix))
results.summary_c2 <- results.summary %>%
  filter(grepl("c2$", Matrix))
results.summary_c3 <- results.summary %>%
  filter(grepl("c3$", Matrix))
results.summary_c4 <- results.summary %>%
  filter(grepl("c4$", Matrix))

#With and without morphology only
results.summary_with_morph <- results.summary[grepl("hsv_mean_morph", results.summary$Matrix), ]
results.summary_no_morph <- results.summary %>%
  filter(grepl("hsv_mean", Matrix),
         !grepl("hsv_mean_morph", Matrix))

#Seed
results.summary_seed_only <- results.summary %>%
  filter(grepl("seed", Matrix))
results.summary_seed_only_total <- results.summary %>%
  filter(grepl("seed", Matrix)) %>%
  filter(grepl("total$", Matrix))
results.summary_seed_only_c2 <- results.summary %>%
  filter(grepl("seed", Matrix)) %>%
  filter(grepl("c2$", Matrix))
results.summary_seed_only_c3 <- results.summary %>%
  filter(grepl("seed", Matrix)) %>%
  filter(grepl("c3$", Matrix))
results.summary_seed_only_c4 <- results.summary %>%
  filter(grepl("seed", Matrix)) %>%
  filter(grepl("c4$", Matrix))

#Wing
results.summary_wing_only <- results.summary %>%
  filter(grepl("wing", Matrix))
results.summary_wing_only_total <- results.summary %>%
  filter(grepl("wing", Matrix)) %>%
  filter(grepl("total$", Matrix))
results.summary_wing_only_c2 <- results.summary %>%
  filter(grepl("wing", Matrix)) %>%
  filter(grepl("c2$", Matrix))
results.summary_wing_only_c3 <- results.summary %>%
  filter(grepl("wing", Matrix)) %>%
  filter(grepl("c3$", Matrix))
results.summary_wing_only_c4 <- results.summary %>%
  filter(grepl("wing", Matrix)) %>%
  filter(grepl("c4$", Matrix))

#Kernel
results.summary_kernel_only <- results.summary %>%
  filter(grepl("kernel", Matrix))
results.summary_kernel_only_total <- results.summary %>%
  filter(grepl("kernel", Matrix)) %>%
  filter(grepl("total$", Matrix))
results.summary_kernel_only_c2 <- results.summary %>%
  filter(grepl("kernel", Matrix)) %>%
  filter(grepl("c2$", Matrix))
results.summary_kernel_only_c3 <- results.summary %>%
  filter(grepl("kernel", Matrix)) %>%
  filter(grepl("c3$", Matrix))
results.summary_kernel_only_c4 <- results.summary %>%
  filter(grepl("kernel", Matrix)) %>%
  filter(grepl("c4$", Matrix))


#All Total matrices
pdf('All_Matrices_Total.pdf', height=5, width=8)
results.summary_total %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#All cohort 2 matrices
pdf('All_Matrices_Cohort_2.pdf', height=5, width=8)
results.summary_c2 %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#All cohort 3 matrices
pdf('All_Matrices_Cohort_3.pdf', height=5, width=8)
results.summary_c3 %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#All cohort 4 matrices
pdf('All_Matrices_Cohort_4.pdf', height=5, width=8)
results.summary_c4 %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#All matrices with morphology
pdf('All_Matrices_Morph.pdf', height=5, width=8)
results.summary_with_morph %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#All matrices no morphology
pdf('All_Matrices_No_Morph.pdf', height=5, width=8)
results.summary_no_morph %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#All Seed matrices
pdf('All_Matrices_Seed_Only.pdf', height=5, width=8)
results.summary_seed_only %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#All Wing matrices
pdf('All_Matrices_Wing_Only.pdf', height=5, width=8)
results.summary_wing_only %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#All Kernel matrices
pdf('All_Matrices_Kernel_Only.pdf', height=5, width=8)
results.summary_kernel_only %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#Seed Only Total
pdf('Seed_Only_Total.pdf', height=5, width=8)
results.summary_seed_only_total %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#Seed Cohort 2
pdf('Seed_Only_c2.pdf', height=5, width=8)
results.summary_seed_only_c2 %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#Seed Cohort 3
pdf('Seed_Only_c3.pdf', height=5, width=8)
results.summary_seed_only_c3 %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#Seed cohort 4
pdf('Seed_Only_c4.pdf', height=5, width=8)
results.summary_seed_only_c4 %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#Wing Total
pdf('Wing_Only_Total.pdf', height=5, width=8)
results.summary_wing_only_total %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#Wing Cohort 2
pdf('Wing_Only_c2.pdf', height=5, width=8)
results.summary_wing_only_c2 %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#Wing Cohort 3
pdf('Wing_Only_c3.pdf', height=5, width=8)
results.summary_wing_only_c3 %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#Wing cohort 4
pdf('Wing_Only_c4.pdf', height=5, width=8)
results.summary_wing_only_c4 %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#Kernel Total
pdf('Kernel_Only_Total.pdf', height=5, width=8)
results.summary_kernel_only_total %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#Kernel Cohort 2
pdf('Kernel_Only_c2.pdf', height=5, width=8)
results.summary_kernel_only_c2 %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#Kernel Cohort 3
pdf('Kernel_Only_c3.pdf', height=5, width=8)
results.summary_kernel_only_c3 %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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

#Kernel cohort 4
pdf('Kernel_Only_c4.pdf', height=5, width=8)
results.summary_kernel_only_c4 %>% 
  ungroup() %>%
  ggplot(aes(x = Trait, y = pearson, fill= Matrix)) +
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



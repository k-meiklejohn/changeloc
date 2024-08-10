library(tidyverse)

#files to compare here from WoLFPSort
canon <- read.delim("results/WoLFPsort/canon.txt", row.names = NULL, sep = " ")
ext <- read.delim("results/WoLFPsort/ext.txt", row.names = NULL, sep = " ") 


#subset data frames for gene and prediction
canon <- canon[, c(1,2)]
ext <- ext[, c(1,2)]


#put all data frames into list
df_list <- list(canon, ext)

#merge all data frames in list
both<- df_list %>% reduce(full_join, by='ID')

both <- both %>% 
  mutate(P1.x = case_when(grepl("mito", P1.x) ~ "MTP",
                                  .default = "OTHER")) %>%
  mutate(P1.y = case_when(grepl("mito", P1.y) ~ "MTP",
                                  .default = "OTHER"))

#new column - what gene changes which
both <- both %>%
  mutate(change = case_when(P1.x == P1.y ~ P1.x,
                            P1.x != P1.y ~ paste0(P1.x, "-", P1.y)
  )
  ) 
#both <- both %>%
#  mutate(prob_change = )
#table(both$change)

for (i in unique(both$change)){
  x <- filter(both, change == i)
  assign(paste0("WPS_", i), x[ ,c(1,2)])
  
}

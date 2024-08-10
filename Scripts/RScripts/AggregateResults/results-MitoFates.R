library(tidyverse)

#files to compare here from MitoFates, edited to be csv
canon <- read.delim("results/MitoFates/canon.txt", row.names = NULL) 
ext <- read.delim("results/MitoFates/ext.txt", row.names = NULL) 


#subset data frames for gene and prediction
#canon <- canon[, c(1,2)]
#ext <- ext[, c(1,2)]


#put all data frames into list
df_list <- list(canon, ext)

#merge all data frames in list
both<- df_list %>% reduce(full_join, by='Sequence.ID')

both <- both %>% 
  mutate(Prediction.x = case_when(Prediction.x == "No mitochondrial presequence" ~ "OTHER",
                                  Prediction.x == "Possessing mitochondrial presequence" ~ "MTP")) %>%
  mutate(Prediction.y = case_when(Prediction.y == "No mitochondrial presequence" ~ "OTHER",
                                  Prediction.y == "Possessing mitochondrial presequence" ~ "MTP"))

#new column - what gene changes which
both <- both %>%
  mutate(change = case_when(Prediction.x == Prediction.y ~ Prediction.x,
                            Prediction.x != Prediction.y ~ paste0(Prediction.x, "-", Prediction.y)
  )
  ) %>%
  mutate(diff = Probability.of.presequence.y - Probability.of.presequence.x)
#both <- both %>%
#  mutate(prob_change = )
#table(both$change)

for (i in unique(both$change)){
  x <- filter(both, change == i)
  assign(paste0("MF_", i), x[, c(1,2,22,43)])

}

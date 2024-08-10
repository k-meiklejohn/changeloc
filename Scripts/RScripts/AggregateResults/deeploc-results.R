library(tidyverse)

#files to compare here from Deeploc2.0
canon <- read.csv("results/deeploc2/canon.csv")
ext <- read.csv("results/deeploc2/ext.csv") 


#subset data frames for gene and signal prediction
canon <- canon[, c(1,2,3)]
ext <- ext[, c(1,2,3)]


#put all data frames into list
df_list <- list(canon, ext)

#merge all data frames in list
both<- df_list %>% reduce(full_join, by='Protein_ID')

both <- both %>% 
  mutate(Signals.x = case_when(grepl("Mito", Signals.x) ~ "MTP",
                          .default = "OTHER")) %>%
  mutate(Signals.y = case_when(grepl("Mito", Signals.y) ~ "MTP",
                          .default = "OTHER"))

both <- both %>% 
  mutate(Localizations.x = case_when(grepl("Mito", Localizations.x) ~ "MTP",
                               .default = "OTHER")) %>%
  mutate(Localizations.y = case_when(grepl("Mito", Localizations.y) ~ "MTP",
                               .default = "OTHER"))


#new column - what gene changes which
both <- both %>%
  mutate(changeS = case_when(Signals.x == Signals.y ~ Signals.x,
                            Signals.x != Signals.y ~ paste0(Signals.x, "-", Signals.y)
  )
  ) 

both <- both %>%
  mutate(changeL = case_when(Localizations.x == Localizations.y ~ Localizations.x,
                            Localizations.x != Localizations.y ~ paste0(Localizations.x, "-", Localizations.y)
  )
  ) 
#both <- both %>%
#  mutate(prob_change = )
#table(both$change)

for (i in unique(both$changeL)){
  x <- filter(both, changeL == i)
  assign(paste0("DP_", i), x)
  
}


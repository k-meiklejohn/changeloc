library(tidyverse)

#files to compare here from Target P, edited to be csv
canon <- read.delim("results/TargetP/canon.txt") 
ext <- read.delim("results/TargetP/ext.txt") 


#subset data frames for gene and prediction
#canon <- canon[, c(1,2)]
#ext <- ext[, c(1,2)]


#put all data frames into list
df_list <- list(canon, ext)

#merge all data frames in list
both<- df_list %>% reduce(full_join, by='ID')


both <- both %>%
  mutate(Prediction.x = toupper(Prediction.x)) %>%
  mutate(Prediction.y = toupper(Prediction.y)) 

#new column - what gene changes which
both <- both %>%
  mutate(change = case_when(Prediction.x == Prediction.y ~ Prediction.x,
                            Prediction.x != Prediction.y ~ paste0(Prediction.x, "-", Prediction.y)
                            )
  )
#both <- both %>%
#  mutate(prob_change = )
#table(both$change)

for (i in unique(both$change)){
  x <- filter(both, change == i)
  assign(paste0("TGP_", i), x[, c(1,8,9,10)])
}

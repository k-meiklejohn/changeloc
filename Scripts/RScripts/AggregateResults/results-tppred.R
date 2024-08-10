library(tidyverse)

#files to compare here from MitoFates, edited to be csv
canon <- read.delim("results/Tppred3/canon.txt", row.names = NULL, skip = 1, header = FALSE) 
ext <- read.delim("results/Tppred3/ext.txt", row.names = NULL, skip = 1, header = FALSE) 


#subset data frames for gene and prediction
#canon <- canon[, c(1,2)]
#ext <- ext[, c(1,2)]

canon <- canon %>% distinct(V1, .keep_all = TRUE)
ext <- ext %>% distinct(V1, .keep_all = TRUE)


#put all data frames into list
df_list <- list(canon, ext)

#merge all data frames in list
both<- df_list %>% reduce(full_join, by='V1')

both <- both %>% 
  mutate(V3.x = case_when(V3.x == "Chain" ~ "OTHER",
                          V3.x == "Transit peptide" ~ "MTP")) %>%
  
  mutate(V3.y = case_when(V3.y == "Chain" ~ "OTHER",
                          V3.y == "Transit peptide" ~ "MTP"))

#new column - what gene changes which
both <- both %>%
  mutate(change = case_when(V3.x == V3.y ~ V3.x,
                            V3.x != V3.y ~ paste0(V3.x, "-", V3.y)
  )
  ) #%>%
  #mutate(diff = as.numeric(V6.y) - as.numeric(V6.x))
#both <- both %>%
#  mutate(prob_change = )
#table(both$change)

for (i in unique(both$change)){
  x <- filter(both, change == i)
  assign(paste0("TPR_", i), x[, c(1,6,14)])
  
}
library(tidyverse)

name <- c("MF", "TGP", "TPR", "WPS", "DP")
type <- c("OTHER", "MTP", "OTHER-MTP", "MTP-OTHER")


for (i in type){
  assign(i, NULL)
  for (y in name){
    assign(i, append(get(i), get(paste0(y, "_", i))[,1]))
    }
}

for (i in type){
  assign(i, as.data.frame(get(i)))
  assign(i, group_by_all(get(i))) 
  assign(i, filter(get(i), n()  >= 4)) 
  assign(i, unique(get(i)))  

}

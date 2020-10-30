##Create directory for work

dir.create("raw_data")
dir.create("processed_data")
dir.create("scripts")
dir.create("figures")

##Task1
##Import Human Development Index 
hdi <- read.csv("raw_data/Human-development-index.csv", header = T)

library(tidyverse)

str(hdi)
hdi2 <- hdi %>% 
  gather("year", "hdi", 3:32)

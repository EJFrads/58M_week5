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
  gather("year", "index", 3:32)

##filter and exclude data with missing index values

hdi_filter <- hdi2 %>% 
  filter(!is.na(index))


##get summary of the data
hdi_summary <- hdi_filter %>% 
  group_by(Country) %>% 
  summarise(mean_index = mean(index),
            n = length(index), 
            sd = sd(index),
            se = sd/sqrt(n))


##Filter the summary to get the 10 countries with the lowest hdi
hdi_summary_low <- hdi_summary %>% 
  filter(rank(mean_index) < 11)

hdi_summary_low

##Plot the 10 lowest countries
hdi_summary_low %>% 
  ggplot() +
  geom_point(aes(x = Country,
                 y = mean_index)) +
  geom_errorbar(aes(x = Country,
                    ymin = mean_index - se,
                    ymax = mean_index + se)) +
  scale_y_continuous(limits = c(0, 0.5),
                     expand = c(0, 0),
                     name = "HDI") +
  scale_x_discrete(expand = c(0, 0),
                   name = "") +
  theme_classic() +
  coord_flip()


###create a data pipeline that goes from hdi2 to the plot

hdi2 %>% 
  filter(!is.na(index)) %>% 
  group_by(Country) %>% 
  summarise(mean_index = mean(index),
            n = length(index), 
            sd = sd(index),
            se = sd/sqrt(n)) %>% 
  filter(rank(mean_index) < 11) %>% 
  ggplot() +
  geom_point(aes(x = Country,
                 y = mean_index)) +
  geom_errorbar(aes(x = Country,
                    ymin = mean_index - se,
                    ymax = mean_index + se)) +
  scale_y_continuous(limits = c(0, 0.5),
                     expand = c(0, 0),
                     name = "HDI") +
  scale_x_discrete(expand = c(0, 0),
                   name = "") +
  theme_classic() +
  coord_flip()

# Author: Jake Harvey - jakekharvey@gmail.com

library(tidyverse)
library(rgbif)
library(sf)

samples <- st_read(dsn=getwd(), layer="samples")

sll <- tibble()
for(i in 1:nrow(samples)){
    
    site <- st_as_text(samples$geometry[i])
    comp <- occ_search(geometry = site, limit = 50)$data
    
    comp <- comp %>%
        select(kingdom, phylum, order, family, genus, species) %>%
        drop_na(species) %>%
        distinct() %>%
        mutate(sample = i)
    sll <- bind_rows(sll, comp)
}

write_csv(sll, "st-lawrence-lowlands.csv")

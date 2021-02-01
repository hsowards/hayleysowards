library(tidyverse)
library(osmdata)

get_streets <- function(city) {
  getbb(paste0(city, " United States")) %>% 
    opq() %>% 
    add_osm_feature(key = "highway",
                    value = c("motorway", "primary",
                              "secondary", "tertiary")) %>% 
    osmdata_sf()
}

get_small_streets <- function(city) {
  getbb(paste0(city, " United States")) %>%
    opq() %>%
    add_osm_feature(key = "highway", 
                    value = c("residential", "living_street",
                              "unclassified",
                              "service", "footway")) %>%
    osmdata_sf()
}

get_river <- function(city){
  getbb(paste0(city, " United States"))%>%
    opq()%>%
    add_osm_feature(key = "waterway", value = "river") %>%
    osmdata_sf()
}
source("map_functions.R")

city = "Montgomery Village Maryland"

coord <- as.data.frame(getbb(paste0(city, " United States")))

streets <- get_streets(city)
small_streets <- get_small_streets(city)
river <- get_river(city)

#replace river with water for lakeville
water <- getbb(paste0(city, " United States"))%>%
  opq()%>%
  add_osm_feature(key = "natural", value = "water") %>%
  osmdata_sf()

#black background
ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "#ffbe7f",
          size = .4,
          alpha = .8) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = "#ffbe7f",          
          size = .2,
          alpha = .3) +
  geom_sf(data = water$osm_lines,          
          inherit.aes = FALSE,          
          color = "#7fc0ff",          
          size = .2,          
          alpha = .5) +
  coord_sf(xlim = c(coord$min[1], coord$max[1]), 
           ylim = c(coord$min[2], coord$max[2] +.005),
           expand = FALSE) +
  theme_void() +
  theme(plot.background = element_rect(fill = "#282828"),
        panel.border = element_blank())

ggsave("tempe.pdf", width = 8, height = 12)

#black and white
ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .4,
          alpha = .8) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",          
          size = .2,
          alpha = .3) +
  geom_sf(data = river$osm_lines,          
          inherit.aes = FALSE,          
          color = "#7fc0ff",          
          size = .2,          
          alpha = .5) +
  coord_sf(xlim = c(coord$min[1], coord$max[1]), 
           ylim = c(coord$min[2], coord$max[2]),
           expand = FALSE) +
  theme_void() +
  theme(panel.border = element_blank())

ggsave("jamestown_bw.pdf", width = 6, height = 6)
################################################################################
##
## [ PROJ ] < RP3 >
## [ FILE ] < 00-make-map.R >
## [ AUTH ] < Jeffrey Yo >
## [ INIT ] < 7/29/25 >
##
################################################################################

#Goal: Create CA map.

################################################################################

## ---------------------------
## libraries
## ---------------------------
library(tidyverse)
library(janitor)
library(readxl)
library(data.table)
library(maps)
library(mapdata)
library(ggrepel)

## ---------------------------
## directory paths
## ---------------------------

#see current directory
getwd()

## ---------------------------
## helper functions & strings
## ---------------------------


## ---------------------------
## load & inspect data
## ---------------------------



## -----------------------------------------------------------------------------
## Part 1 - Create Map
## -----------------------------------------------------------------------------

states <- map_data("state")
ca_df <- states %>% filter(region == "california")
counties <- map_data("county")
ca_county <- counties %>% filter(region == "california")
counties <- map_data("county")
ca_county <- counties %>% filter(region == "california")


rp3_map<-ggplot() +
  # Base California fill
  geom_polygon(data = california_map, aes(x = long, y = lat, group = group), 
               fill = '#DAEBFE', color = "black") +
  # County lines
  geom_path(data = ca_county, aes(x = long, y = lat, group = group), 
            color = "black", size = 0.4) +
  # Cities
  geom_point(data = cities, aes(x = long, y = lat), 
             color = "#FFBB1C", size = 3) +
  # geom_text_repel(data = cities, aes(x = long, y = lat, label = city), 
  #                 size = 5, fontface = "bold") +
  # Zoom to Southern California
  coord_fixed(1.3, xlim = c(-120.5, -116.5), ylim = c(32, 35.5)) +
  labs(title = "RP3 Sites") +
  theme_minimal() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.border = element_blank(),
    plot.title = element_text(hjust = 0.5) 
  )

rp3_map

## -----------------------------------------------------------------------------
## Part 3 - Export Data
## -----------------------------------------------------------------------------

#export dataset
ggsave("rp3.png")

## -----------------------------------------------------------------------------
## END SCRIPT
## -----------------------------------------------------------------------------
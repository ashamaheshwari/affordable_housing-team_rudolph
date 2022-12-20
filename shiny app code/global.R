library(shiny)
library(shinythemes)
library(tidyverse)
library(highcharter)
library(leaflet)
library(leaflet.extras)
library(sf)

#variables of interest: distance, owner_yr, amount, group

omfy <- readRDS('nearli_sales.rds')

test <- read_csv('one_mi_five_yr.csv')

omfy$ownerdate <- as.Date(omfy$ownerdate, "%m/%d/%y" )

#remove outlier amount 2.2mil
omfy_filt <- omfy %>% filter(amount_dol != max(amount_dol))

#st data
omfy_filt_sf <- st_as_sf(omfy_filt, coords=c("lon","lat"),crs=4326)

zip <- st_read("Zip Codes.geojson")

LIHTC <- read_csv('LIHTC_updated.csv')

LIHTC <- LIHTC[-c(1, 2, 3, 4, 5), ]

icons <- awesomeIcons(
  icon = "home",
  iconColor = "#FFFFFF",
  markerColor = "cadetblue",
  library = "fa",
  squareMarker = TRUE)


  
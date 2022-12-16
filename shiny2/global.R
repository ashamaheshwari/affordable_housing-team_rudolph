library(shiny)
library(shinythemes)
library(tidyverse)
library(highcharter)
library(leaflet)
library(sf)

#variables of interest: distance, owner_yr, amount, group

omfy <- read_csv('../one_mi_five_yr.csv')

omfy$ownerdate <- as.Date(omfy$ownerdate, "%m/%d/%y" )

#remove outlier amount 2.2mil
omfy_filt <- omfy %>% filter(amount != max(amount))

#st data
omfy_filt_sf <- omfy_filt %>% 
  mutate(geom = gsub(geometry,pattern="(\\))|(\\()|c",replacement = ""))%>%
  separate(geom, into = c("lat", "lon"), sep=",") %>%
  st_as_sf(., coords=c("lat","lon"),crs=4326)


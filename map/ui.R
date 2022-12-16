#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(leaflet.extras)

# Define UI for application that draws a histogram
ui <- fillPage(
  leafletOutput('mymap', width = "100%", height = "100%"),
  p(),
  actionButton("recalc", "New points")
)

server <- function(input, output, session) {
  
  points <- eventReactive(input$recalc, {
    cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
  }, ignoreNULL = FALSE)
  
  output$mymap <- renderLeaflet({
    zip %>% 
      leaflet()  %>% 
      addProviderTiles("Stamen.TonerHybrid")  %>% 
      addPolygons(color ="grey", opacity=1, weight = 1,
                  highlightOptions = highlightOptions(
                    weight = 5,
                    fillOpacity = 0.7,
                    bringToFront = FALSE),
                    label=zip$zipcode) %>%
      addCircleMarkers(data = pre, radius = 1 , weight=0.5, color="mediumspringgreen", group="pre") %>%
      addCircleMarkers(data = post, radius = 1 , weight=0.5, color="blue",group="post") %>%
      addCircleMarkers(data = outside, radius = 1 , weight=0.5, color="purple",group="outside") %>%
      addCircleMarkers(data = mid, radius = 1 , weight=0.5, color="violet",group="mid") %>%
      addCircleMarkers(data = LIHTC, radius = 1 , popup = LIHTC$PROJECT, color="red") %>%
      addLayersControl(
        overlayGroups = c("pre", "post", "outside", "mid"),
        options = layersControlOptions(collapsed = FALSE)
      ) %>% 
      hideGroup(c("pre", "post", "outside", "mid")) %>% 
      setView(lat = 36.1627, lng = -86.7816, zoom = 11)
  })
}

shinyApp(ui, server, options = list(height = 1080))

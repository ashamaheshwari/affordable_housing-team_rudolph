

# Define server logic required to draw a histogram

#Define server function
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    omfy %>% 
      filter((dist>=input$dist[1]) & (dist <= input$dist[2])) %>% 
      ggplot()+
      geom_point(aes(square_footage, amount, color = group))+
      labs(x = "Square Footage", y = "Price") +
      scale_color_manual(values = c("post" = "blue",
                                    "mid"="red", 
                                    "pre" = "forestgreen", 
                                    "outside" = "orange"))+
      ggtitle("Relationship between Square Footage and Price")+
      facet_wrap((.~group))
    
  })#pg2 plot
  output$timeseries <- renderPlot({
    omfy_filt %>% 
      filter(group == input$checkGroup) %>% 
      group_by(sale_yr, group) %>% 
      summarize(mean_amt = mean(amount)) %>% 
      ggplot(aes(sale_yr, mean_amt, color = group, group = group)) +
      geom_line() + labs(x = "Sale Year", y = "Average Price") +
      scale_color_manual(values = c("post" = "blue",
                                    "mid"="red", 
                                    "pre" = "forestgreen", 
                                    "outside" = "orange"))
    
  })
  #NAV:TEST PAGE: TIME SERIES AND MAP
  output$plotb <- renderPlot({
    options(scipen = 999)
    omfy_filt_sf %>%
      filter(group == input$checkGroupb) %>% 
      group_by(sale_yr, group) %>% 
      summarize(mean_amt = mean(amount)) %>% 
      ggplot(aes(sale_yr, mean_amt, color = group, fill=group, group = group)) +
      scale_color_manual(values = c("post" = "blue",
                                    "mid"="red", 
                                    "pre" = "forestgreen", 
                                    "outside" = "orange"))+
      geom_area(size = 1.5, alpha = 0.5, position = position_dodge(0.8))+
      theme_minimal()+
      
      scale_fill_manual(values = c("post" = "blue",
                                   "mid"="red", 
                                   "pre" = "forestgreen", 
                                   "outside" = "orange"))+
      scale_x_continuous(breaks = seq(1980, 2022, 5))+
      scale_y_continuous() + labs(x = "Sale Year", y = "Average Price")
  })
  
  df_fil <- reactive({
    w <- omfy_filt_sf %>% filter(group == input$checkGroupb) 
    return(w)
  })
  #MAP
  #define reactive 
  filtered <- reactive({
    LIHTC[LIHTC$PROJECT == input$select,]
  })
  
  output$mymap <- renderLeaflet({
    
    pal <- colorFactor(palette = c("blue", "red", "forestgreen", "orange"), 
                       levels = c("post", "mid", "pre", "outside"))
   # main map code 
    df_fil() %>% 
      leaflet(options = leafletOptions(minZoom = 10, preferCanvas = TRUE)) %>% 
      addProviderTiles(provider = "Stamen.TonerHybrid", group = "ST") %>%
      addProviderTiles(
        "OpenStreetMap",
        group = "OpenStreetMap"
      ) %>% addLayersControl(
        baseGroups = c(
          "ST", "OpenStreetMap"
        ),
        position = "topleft"
      ) %>% 
      addPolygons(data = zip, color ="grey", opacity=1, weight = 1,
                  highlightOptions = highlightOptions(
                    weight = 5,
                    fillOpacity = 0.7,
                    bringToFront = FALSE),
                  label=zip$zipcode) %>% 
      addCircleMarkers(fillOpacity = 0.2, 
                       opacity = 0.5, 
                       radius = 1, 
                       weight = 0.5, 
                       color = ~pal(group)) %>%
      addCircleMarkers(data = LIHTC, 
                       radius = 2 , 
                       popup = paste(LIHTC$PROJECT, "<br>", 
                                     "Year:", LIHTC$YR_PIS,"<br>",
                                     "Address:", LIHTC$PROJ_ADD), color="darkcyan") %>% 
      setView(lng = -86.7816, lat = 36.1627, zoom = 10) %>% addResetMapButton()
  })
  # this is the code for selecting individual properties
  map_leaf <- leafletProxy("mymap")
  
  observe({
    f_map <- filtered()
    map_leaf %>%
      addAwesomeMarkers(data = LIHTC[LIHTC$PROJECT == input$select,],
                        icon = icons,
                        popup = paste(f_map$PROJECT, "<br>", 
                                      "Year:", f_map$YR_PIS, "<br>",
                                      "Address:", f_map$PROJ_ADD)) %>%
      flyTo(lng = f_map$LONGITUDE, lat = f_map$LATITUDE, zoom = 12) 
    
    
  })
}
)
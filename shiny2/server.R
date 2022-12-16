

# Define server logic required to draw a histogram

#Define server function
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    omfy %>% 
      filter((distance>=input$distance[1]) & (distance <= input$distance[2])) %>% 
      ggplot()+
      geom_point(aes(square_footage, amount, color = group))+
      ggtitle("Relationship between Square Footage and Price")+
      facet_wrap((.~group))
      
  })#pg2 plot
  output$timeseries <- renderPlot({
    omfy_filt %>% 
      filter(group == input$checkGroup) %>% 
      group_by(owner_yr, group) %>% 
      summarize(mean_amt = mean(amount)) %>% 
      ggplot(aes(owner_yr, mean_amt, color = group, group = group)) +
      geom_line()
    
  })
  #NAV:TEST PAGE: TIME SERIES AND MAP
  output$plotb <- renderPlot({
    options(scipen = 999)
    omfy_filt_sf %>%
      filter(group == input$checkGroupb) %>% 
      group_by(owner_yr, group) %>% 
      summarize(mean_amt = mean(amount)) %>% 
      ggplot(aes(owner_yr, mean_amt, color = group, group = group)) +
      scale_color_manual(values = c("post" = "blue",
                                    "mid"="red", 
                                    "pre" = "forestgreen", 
                                    "outside" = "orange"))+
      geom_line(size = 1.5)+
      theme_minimal()+
      scale_x_continuous(breaks = seq(1980, 2022, 5))+
      scale_y_continuous()
  })
 #MAP
  #define reactive 
  df_fil <- reactive({
    w <- omfy_filt_sf %>% filter(group == input$checkGroupb)
    return(w)
  })
  
  #output map
  output$mymap <- renderLeaflet({
    
  pal <- colorFactor(palette = c("blue", "red", "forestgreen", "orange"), 
                                 levels = c("post", "mid", "pre", "outside"))
  
  
  df_fil() %>% 
    leaflet() %>% 
    addProviderTiles(provider = "CartoDB.PositronNoLabels") %>%
    setView(lng = -86.7816, lat = 36.1627, zoom = 12) %>% 
    addCircleMarkers(fillOpacity = 0.2,
                     opacity = 0.5,
                     radius = 5,
                     color = ~pal(group)
                     )
      })
})
  



  
  
  # output$testing <- renderHighchart({
  #   highchart() %>% 
  #     hc_chart(type = 'line') %>% 
  #     hc_series(list(name = 'Outside', 
  #                    data =omfy_filt$amount[omfy_filt$group=='outside'], 
  #                    color='green', marker = list(symbol = 'circle') ),
  #               list(name = 'Post', 
  #                    data =omfy_filt$amount[omfy_filt$group=='post'], 
  #                    color='red', marker = list(symbol = 'triangle'))) %>% 
  #     hc_xAxis(categories = unique(omfy_filt$owner_yr)) %>% 
  #     hc_yAxis(title = list(text="amount")) %>% 
  #           hc_plotOptions(enableMouseTracking = T)
  # })#testing
  
  # output$testing2 <- renderHighchart({
  #   hchart(omfy_filt, "line", 
  #         hcaes(y="amount", x= "owner_yr"))


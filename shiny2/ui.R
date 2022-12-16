#Shiny Project Affordable Housing UI


# Define UI for application that draws a histogram
shinyUI( fluidPage(theme = shinytheme("cerulean"),
                        navbarPage(theme = "cerulean", "AH",
                        
                        
                        tabPanel("Nav:Distance and Price", 
                                 sidebarPanel(
                                   sliderInput("distance", "Select Distance",
                                               min = 0,
                                               max = 1,
                                               value = c(0.1, 0.9),
                                               step = 0.1)),#sidbarpanel
                                 mainPanel(plotOutput("distPlot")) #mainpanel
                                 ),
                        #tabPanel("Navbar3", "Insert content here"),
                        tabPanel("Nav: Year and Price", 
                                 sidebarPanel(checkboxGroupInput("checkGroup", 
                                                                 label = h3("Select groups to compare"), 
                                                                 choices = list("Outside" = "outside", 
                                                                                "2-5 yrs prior" = "pre",
                                                                                "0-2 yrs prior" = "mid",
                                                                                "Post" = "post"),
                                                                 selected = "post")),
                                 mainPanel(plotOutput("timeseries"))
                                 ), #tabpanel
                        #NAV:TESTING TIME SERIES AND MAP
                        tabPanel("Nav:testing map",
                                 sidebarPanel(checkboxGroupInput("checkGroupb",
                                                                 label = h3("Select groups to compare"), 
                                                                 choices = list("Outside" = "outside", 
                                                                                "2-5 yrs prior" = "pre",
                                                                                "0-2 yrs prior" = "mid",
                                                                                "Post" = "post"),
                                                                 selected = "post")),
                                 mainPanel( plotOutput("plotb"),
                                            leafletOutput("mymap"))
                                   
                                 )
                                 #mainPanel(highchartOutput("testing2"))
                                      #fluidrow
                                 #)#tabpanel
                                 )#navbarPage
                   )#fluidpage
              )#shinyUI







# column(6, plotOutput("plotb"))),
# fluidRow(
#   column(8, leafletOutput("mymap"),
#          p(),
#          actionButton("recalc", "New Points")),
#   column(4, textInput("text3", "add something")))

shinyUI( fluidPage(theme = shinytheme("cerulean"),
                   navbarPage(theme = "cerulean", "Affordable Housing",
                              
                              
                             tabPanel("Distance and Price", 
                                       sidebarPanel(
                                         sliderInput("dist", "Select Distance",
                                                     min = 0,
                                                     max = 1,
                                                     value = c(0.1, 0.9),
                                                     step = 0.1)),#sidbarpanel
                                       mainPanel(plotOutput("distPlot"),
                                                 div(code("'pre'", style = "color:forestgreen"), 
                                                     "- homes less than half a mile from AH and sold 2-5 years prior to when AH was placed in service."),
                                                 p(code("'mid'", style = "color:red"), 
                                                   "- homes less than half a mile from AH and sold 0-2 years prior to when AH was placed in service."),
                                                 p(code("'post'", style = "color:blue"), 
                                                   "- homes less than half a mile from AH and sold after AH was placed in service."),
                                                 p(code("'outside'", style = "color:orange"), 
                                                   "- homes more than half a mile from AH and sold no more than 5 years prior to when AH was placed in service.")) #mainpanel
                              ),
                              #tabPanel("Navbar3", "Insert content here"),
                              tabPanel("Year and Price", 
                                       sidebarPanel(checkboxGroupInput("checkGroup", 
                                                                       label = h3("Select groups to compare"), 
                                                                       choices = list( 
                                                                                      "pre" = "pre",
                                                                                      "mid" = "mid",
                                                                                      "post" = "post",
                                                                                      "outside" = "outside"),
                                                                       selected = "pre")),
                                       mainPanel(plotOutput("timeseries"),
                                                 div(code("'pre'", style = "color:forestgreen"), 
                                                     "- homes less than half a mile from AH and sold 2-5 years prior to when AH was placed in service."),
                                                 p(code("'mid'", style = "color:red"), 
                                                   "- homes less than half a mile from AH and sold 0-2 years prior to when AH was placed in service."),
                                                 p(code("'post'", style = "color:blue"), 
                                                   "- homes less than half a mile from AH and sold after AH was placed in service."),
                                                 p(code("'outside'", style = "color:orange"), 
                                                   "- homes more than half a mile from AH and sold no more than 5 years prior to when AH was placed in service."))
                              ), #tabpanel
                              #NAV:TESTING TIME SERIES AND MAP
                              tabPanel("Map and Price",
                                       sidebarPanel(checkboxGroupInput("checkGroupb",
                                                                       label = h3("Select groups to compare"), 
                                                                       choices = list( 
                                                                                      "pre" = "pre",
                                                                                      "mid" = "mid",
                                                                                      "post" = "post",
                                                                                      "outside" = "outside"),
                                                                       selected = "pre"),
                                                    selectInput("select", label = h3("Select Property"), 
                                                                choices = sort(LIHTC$PROJECT), 
                                                                selected = 1)), 
                                                  mainPanel(plotOutput("plotb"),
                                                            div(code("'pre'", style = "color:forestgreen"), 
                                                                "- homes less than half a mile from AH and sold 2-5 years prior to when AH was placed in service."),
                                                            p(code("'mid'", style = "color:red"), 
                                                              "- homes less than half a mile from AH and sold 0-2 years prior to when AH was placed in service."),
                                                            p(code("'post'", style = "color:blue"), 
                                                              "- homes less than half a mile from AH and sold after AH was placed in service."),
                                                            p(code("'outside'", style = "color:orange"), 
                                                              "- homes more than half a mile from AH and sold no more than 5 years prior to when AH was placed in service.")),
                                                  leafletOutput("mymap"))
                                       
                              )
                              #mainPanel(highchartOutput("testing2"))
                              #fluidrow
                              #)#tabpanel
                   )#navbarPage
)#fluidpage
#shinyUI







# column(6, plotOutput("plotb"))),
# fluidRow(
#   column(8, leafletOutput("mymap"),
#          p(),
#          actionButton("recalc", "New Points")),
#   column(4, textInput("text3", "add something")))

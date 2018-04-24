shinyUI(
  
  navbarPage(
    title = 'FIFA',
    fluid = FALSE,
    collapsible = FALSE,
    
    ######################################      Welcome       ######################################
    tabPanel('Welcome',
             tags$head(includeCSS('www/style.css')),
             tags$head(tags$script(src="floating_sidebar.js")),
             img(class = 'background', src = 'background.jpg')
    ),
    
    ######################################      History       ######################################
    tabPanel('History',
             tabsetPanel(
               
               tabPanel('Overall', plotOutput("overall", width = "100%", height = "500px")),
               
               tabPanel("Final Rounds",
                        
                        sidebarLayout(
                          
                          sidebarPanel(
                            selectInput('Year','Select Year', 
                                        choices = list(1986,1990,1994,1998,2002,2006,2010,2014),
                                        selected = 1986),
                            width = 3
                          ),
                          
                          mainPanel(
                            plotOutput("round", width = "100%", height = "500px")
                            
                          )
                        )
               )
             )
    ),  

    ######################################     Statistics     ######################################
    tabPanel('2018 Statistics',
             sidebarLayout(
               
               sidebarPanel(
                 selectInput('country1','Select Country',
                             choices = c('All',round16_team),
                             selected = 'All'),
                 selectInput('country2','Select Comparing Country',
                             choices = c('All',round16_team),
                             selected = 'Germany'),
                 selectInput('N','Select Top Numbers',
                             choices = c(1,3,5,10,15,20,30,40,50),
                             selected = 20),
                 
                 downloadButton('downloadData', 'Download Data'),
                 width = 3
               ),
               
               mainPanel(
                 
                 tabsetPanel(
                   
                   tabPanel('Player',
                            DT::dataTableOutput('player', width = '110%')
                   ),                 
                   tabPanel(
                     'Value of Players',
                     br(),
                     plotOutput('Value1', width = '100%',height = 600)
                   )
                 )
               )
             )
    ),

    ######################################     Prediction     ######################################
    tabPanel('Prediction'
    ),

    ######################################        About       ######################################
    tabPanel('About'
    )
  )
)

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
                   ),
                   tabPanel(
                     '3D-Plot',
                     br(),
                     plotlyOutput('D3', width = '100%',height = 600)
                   )
                 )
               )
             )
    ),

    ######################################     Prediction     ######################################
    tabPanel('Prediction'
    ),

    ######################################        About       ######################################
    tabPanel('About',
             
             fixedRow(        
               column(
                 img(src = 'history.jpg', id = 'ribbon-about', height = 230),
                 width = 12
               )
             ),
             br(),
             
             fixedRow(
               
               column(
                 HTML('<ul class="nav nav-pills nav-justified">
                      <li class="active">
                      <a href="#about-tab-1" data-toggle="tab" data-value="Teams/Matches">Teams / Matches</a>
                      </li>
                      <li>
                      <a href="#about-tab-2" data-toggle="tab" data-value="Total Goals">Total Goals</a>
                      </li>
                      <li>
                      <a href="#about-tab-3" data-toggle="tab" data-value="Final Rounds">Final Rounds</a>
                      </li>
                      </ul>'),
                 width = 12
                 )
               ),
             
             HTML('<div class="container-fluid">
                  <div class="tab-content">
                  <div class="tab-pane active" data-value="Teams/Matches" id="about-tab-1">'),
             
             br(),
             br(),
             br(),
             
             #####
             
             HTML('     </div>
                  <div class="tab-pane" data-value="Total Goals" id="about-tab-2">'),
             
             br(),
             br(),
             br(),
             
             #####
             
             column(width = 2),
             
             HTML('     </div>
                  <div class="tab-pane" data-value="Final Rounds" id="about-tab-3">'),
             
             br(),
             br(),
             br()
             
             ######
    )
  )
)
    


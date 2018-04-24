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
             
             fixedRow(        
               column(
                 img(src = 'FIFA.jpeg', id = 'ribbon-about', height = 80),
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
             plotOutput("tm", width = "100%", height = "400px"),
             
             HTML('     </div>
                  <div class="tab-pane" data-value="Total Goals" id="about-tab-2">'),
             
             br(),
             plotOutput("goals", width = "100%", height = "400px"),
             
             HTML('     </div>
                  <div class="tab-pane" data-value="Final Rounds" id="about-tab-3">'),
             
             br(),
             sidebarLayout(
               
               sidebarPanel(
                 selectInput('Year','Select Year', 
                             choices = years,
                             selected = 2014),
                 width = 3
               ),
               
               mainPanel(
                 plotOutput("round", width = "100%", height = "400px"),
                 width = 9
               )
             ),
             
             HTML('     </div>
                      </div>
                    </div>')
    ),  

    ######################################     Statistics     ######################################
    tabPanel('2018 Statistics',
             fixedRow(        
               column(
                 img(src = 'FIFA.jpeg', id = 'ribbon-about', height = 80),
                 width = 12
               )
             ),
             br(),
             
             fixedRow(
               tabsetPanel(
                 tabPanel('Countries',
                          sidebarLayout(
                            sidebarPanel(
                              selectInput('country_map','Select Country',
                                          choices = c('All',round16_team),
                                          selected = 'France'),
                              width = 3
                              ),
                            
                            mainPanel(
                              leafletOutput("map", width="100%", height = "500px")
                              )
                          )
                 ),
                 
                 tabPanel('Players',
                          sidebarLayout(
                            sidebarPanel(
                              selectInput('country_player','Select Country',
                                          choices = c('All',round16_team),
                                          selected = 'All'),
                              downloadButton('downloadData', 'Download Data'),
                              width = 3),
                            
                            mainPanel(
                              DT::dataTableOutput('player', width = '110%')
                            )
                          )
                 ),
                 
                 tabPanel('Top Players',
                          sidebarLayout(
                            sidebarPanel(
                              selectInput('country1_v','Select Country',
                                          choices = c('All',round16_team),
                                          selected = 'All'),
                              selectInput('country2_v','Select Comparing Country',
                                          choices = c('All',round16_team),
                                          selected = 'Germany'),
                              selectInput('N','Select Top Numbers',
                                          choices = c(1,3,5,10,15,20,30,40,50),
                                          selected = 20),
                              width = 3),
                            
                            mainPanel(
                              plotOutput('value', width = '100%',height = 600)
                            )
                          )
                 ),
                 
                 tabPanel('3D-Plot',
                          sidebarLayout(
                            sidebarPanel(
                              selectInput('country1_3D','Select Country',
                                          choices = c('All',round16_team),
                                          selected = 'All'),
                              selectInput('country2_3D','Select Comparing Country',
                                          choices = c('All',round16_team),
                                          selected = 'Germany'),
                              selectInput('N_3D','Select Top Numbers',
                                          choices = c(1,3,5,10,15,20,30,40,50),
                                          selected = 20),
                              width = 3),
                            
                            mainPanel(
                              plotlyOutput('D3', width = '100%',height = 600)
                            )
                          )
                 )
               )
             )
    ),

    ######################################     Prediction     ######################################
    tabPanel('Prediction',
             fixedRow(        
               column(
                 img(src = 'FIFA.jpeg', id = 'ribbon-about', height = 80),
                 width = 12
               )
             ),
             br(),
             
             fixedRow()
    ),

    ######################################        About       ######################################
    tabPanel('About',
             fixedRow(        
               column(
                 img(src = 'FIFA.jpeg', id = 'ribbon-about', height = 80),
                 width = 12
               )
             ),
             br(),
             
             fixedRow()
    )
  )
)
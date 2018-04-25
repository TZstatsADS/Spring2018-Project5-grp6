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
               
               column(
                 HTML('<ul class="nav nav-pills nav-justified">
                      <li class="active">
                      <a href="#about-tab-4" data-toggle="tab" data-value="Teams">Teams</a>
                      </li>
                      <li>
                      <a href="#about-tab-5" data-toggle="tab" data-value="Players">Players</a>
                      </li>
                      </ul>'),
                 width = 12
                 )
               ),
             
             HTML('<div class="container-fluid">
                  <div class="tab-content">
                  <div class="tab-pane active" data-value="Teams" id="about-tab-4">'),
             
             br(),
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
               )
             ),
             
             HTML('     </div>
                  <div class="tab-pane" data-value="Players" id="about-tab-5">'),
            
            br(), 
            tabsetPanel(
              tabPanel('Visualization',
                       sidebarLayout(
                         sidebarPanel(
                           selectInput('country1','Country 1',
                                       choices = round16_team,
                                       selected = 'Russia'),
                           selectInput('country2','Country 2',
                                       choices = round16_team,
                                       selected = 'Germany'),
                           selectInput('category','Category',
                                       choices = category,
                                       selected = 'ValueNum'),
                           selectInput('N','Top Numbers',
                                       choices = c(1,3,5,10,15,20,30,40,50),
                                       selected = 20),
                           width = 3),
                         
                         mainPanel(
                           plotOutput('compare', width = '100%', height = "400px"),
                           br(),
                           plotlyOutput('D3', width = '100%', height = "400px")
                         )
                       )
              ),
              
              tabPanel('Table',
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
              )
            ),

             HTML('     </div>
                      </div>
                  </div>')
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
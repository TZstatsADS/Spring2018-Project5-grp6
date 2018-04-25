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
               tabPanel('Comparison',
                        sidebarLayout(
                          sidebarPanel(
                            selectInput('country1_t','Country 1',
                                        choices = round16_team,
                                        selected = 'Russia'),
                            selectInput('country2_t','Country 2',
                                        choices = round16_team,
                                        selected = 'Germany'),
                            width = 3
                          ),
                          
                          mainPanel(
                            br(),
                            plotOutput("overall", width="110%", height = "200px"),
                            br(),
                            plotOutput("radar", width="100%", height = "500px"),
                            br(),
                            plotOutput("bar", width="100%", height = "500px")
                          )
                        )
               ),
               
               tabPanel('Location',
                        sidebarLayout(
                          sidebarPanel(
                            selectInput('country_map','Select Country',
                                        choices = c('All',all_team),
                                        selected = 'Germany'),
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
              tabPanel('Comparison',
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
                           br(),
                           br(),
                           plotOutput('compare', width = '100%', height = "400px"),
                           br(),
                           br(),
                           br(),
                           br(),
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
             
             fixedRow(
               column(div(id = 'about',
                      HTML('This summer, one of the most famous and world-wide banquet, 
                            the World Cup, will be held in Russia through June and July. 
                            This championship draws the attention from the people 
                            all over the world for every single time.
                            As a consequence, it will be significantly intriguing on 
                            knowing something about the World Cup and making predictions on it.
                            <br><br>
                            In this website, our team shows all of the informaion about 
                            the 16 teams we assumed in the round 16 elimination stage. 
                            Simultaneously, we also make our own predictions on 
                            who will get to the end of the championship 
                            by creating our own models.
                            <br><br>
                            You can find all of the useful information about 
                            soccer and World Cup in this website, 
                            and you can also check out our predictions in it. 
                            Try it, and enjoy it!')),
                      width = 12),
               
               br(),
               column(h3('Data'), 
                      div(id = 'about', 'The data in this website comes from', 
                          a(id = 'footy', 'FIFA worldcup 2018 Dataset', 
                            href = 'https://www.kaggle.com/ahmedelnaggar/fifa-worldcup-2018-dataset'),
                          'and',
                          a(id = 'footy', 'FIFA 18 Complete Player Dataset', 
                            href = 'https://www.kaggle.com/thec03u5/fifa-18-demo-player-dataset'),
                          '.'),
                      width = 12),
               
               br(),
               column(h3('Contact'), 
                      div(id = 'about', 'Please feel free to',
                          a(id = 'HC', 'contact us', href = 'https://github.com/TZstatsADS/Spring2018-Project5-grp_6'),
                          'if you have any questions or comments regarding this website.'),
                      width = 12)
             )
    )
  )
)
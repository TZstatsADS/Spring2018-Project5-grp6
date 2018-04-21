library(shiny)

round16_team <- c("Russia", "Uruguay", "Spain", "Portugal", "France", "Denmark", "Argentina", "Croatia",
                  "Brazil", "Switzerland", "Germany", "Sweden", "Belgium", "England", "Poland", "Colombia")
years <- seq(1986, 2014, len=8)

shinyUI(
  navbarPage(
    title = 'FIFA',
    fluid = FALSE,
    collapsible = FALSE,
    #tab welcome top of app
    tabPanel('Welcome', 
          div(class = 'bg', 
              div(class = 'first_line', strong('FIFA World Cup')),
              br(),
              div(class = 'second_line', 
                  'des')
          ),
          img(class = 'background', 
              src = 'football_4-wallpaper-1920x1080_new_cropped.jpg')

    ),
    
    #tab History top of app
    tabPanel('History',
             tabsetPanel(
               
               tabPanel('Overall', plotOutput("overall", width = "100%", height = "500px")),
               
               tabPanel("Final Rounds",
                        sidebarPanel(
                          selectInput('Year', 
                                      'Select Year', 
                                      choices = years,
                                      selected = '2014'),
                          plotOutput("round", width = "100%", height = "300px")
                        )
               )
             )
    ),        

    #tab 2018 Statistics top of app
    tabPanel('2018 Statistics',
      sidebarLayout(
       
        #sidebar starts here
        sidebarPanel(
         
          selectInput('country', 
                      'Select Country', 
                      choices = round16_team,
                      selected = 'Germany')
        ),
         
        #main panel starts here
        mainPanel(
         
          tabsetPanel(
           
            #tab Player in Statistics tab
            tabPanel('Player'
                     ),
            
            
            #tab Raw Table in Statistics tab
            tabPanel('Raw Table',
                     br(),
                     fixedRow(
                       column(DT::dataTableOutput('data', width = '100%'), 
                              width = 10),
                       br(),
                       br(),
                       column(downloadButton('downloadData', 
                                             'Download Data'), 
                              width = 2)
                     ))
          ),    
        width = 9)
      )
    ),
    
    #tab About top of app
    tabPanel('About'
    )
  )
)

library(shiny)
library(scales)
library(RColorBrewer)
library(ggthemes)
library(gridExtra)

round16_team <- c("Russia", "Uruguay", "Spain", "Portugal", "France", "Denmark", "Argentina", "Croatia",
                  "Brazil", "Switzerland", "Germany", "Sweden", "Belgium", "England", "Poland", "Colombia")

worldCups <- read.csv("../data/fifa-world-cup/WorldCups.csv",sep=',',stringsAsFactors=F)
worldCups$Attendance <- sapply(worldCups$Attendance, function(x) as.numeric(gsub("\\.","",x)))
worldCups$DateTS <- as.Date(paste0(worldCups$Year,'-01-01'))

shinyServer(function(input, output, session) { 
  
  
  #####Welcome
  
  #####History
  output$overall <- renderPlot({
    countries <-unique(sort(append(unique(worldCups$Winner),unique(worldCups$Country))))
    cols<-colorRampPalette(brewer.pal(9,'Set1'))(length(countries))
    COLS <- data.frame(color = cols, country = countries)
    COLS$color <- as.character(COLS$color)
    COLS$country <- as.character(COLS$country)
    COLS$index <- 1:nrow(COLS)
    
    # adding country host color
    worldCups$CountryColor <- sapply(worldCups$Country, function(x) COLS$color[match(x,COLS$country)])
    # adding winner country color
    worldCups$WinnerColor <- sapply(worldCups$Winner, function(x) COLS$color[match(x,COLS$country)])
    
    # make a legend plot
    myleg <- COLS %>% ggplot(aes(x=reorder(country,-index),y=1)) + 
      geom_bar(stat='identity',aes(fill=color)) + 
      coord_flip() + scale_fill_identity()+ 
      theme_fivethirtyeight() + 
      theme(panel.grid= element_blank() ,axis.text.x = element_blank())
    
    # add limits for the x-axis
    lims <- as.POSIXct(strptime(c("1927-01-01","2015-01-01"), format = "%Y-%m-%d"))
    
    # plot of goals vs year
    g1 <- worldCups %>% ggplot(aes(x=as.POSIXct(DateTS),y=GoalsScored)) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1930-01-01')),alpha=.5) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1934-01-01')),alpha=.5) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1966-01-01')),alpha=.5) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1978-01-01')),alpha=.5) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1998-01-01')),alpha=.5) + 
      geom_line(alpha=.1,size=4) + 
      geom_point(aes(color=WinnerColor),size=4) + 
      theme_fivethirtyeight() + 
      scale_x_datetime(limits =lims, date_breaks="4 year", labels = date_format("%Y")) + 
      scale_color_identity()
    
    # add the legend plot
    g11 <- g1 + annotation_custom( ggplotGrob(myleg), 
                                   xmin=as.numeric(as.POSIXct(as.Date('1922-01-01'))),
                                   xmax=as.numeric(as.POSIXct(as.Date('1936-01-01'))),
                                   ymin=90,ymax=180) + 
      labs(title='Total Goals Scored per World Cup',
           subtitle='vertical lines show editions for which the host country also won')
    
    # plot of Attendance vs year                    
    g2 <- worldCups %>% ggplot(aes(x=as.POSIXct(DateTS),y=Attendance)) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1930-01-01')),alpha=.5) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1934-01-01')),alpha=.5) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1966-01-01')),alpha=.5) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1978-01-01')),alpha=.5) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1998-01-01')),alpha=.5) + 
      geom_line(alpha=.1,size=4) + 
      geom_point(aes(color=CountryColor),size=4) + 
      theme_fivethirtyeight() + 
      theme(axis.text.y =element_text(angle=75)) +
      scale_x_datetime(
        limits =lims, 
        date_breaks="4 year", 
        labels = date_format("%Y")) +
      scale_color_identity() + theme(axis.text.x=element_blank()) + 
      labs(title='Attendance per World Cup')
    
    # assemble everything
    grid.arrange(g11,g2,ncol=1)
  })
  
  
  #####Statistics
  output$downloadData <- downloadHandler(
    filename = function() {
      paste('../data/fifa-18-demo-player-dataset/CompleteDataset', Sys.Date(), '.csv', sep='')
    },
    content = function(con) {
      write.csv(output$data, con, row.names = FALSE)
    }
  )
  
  #####About
})
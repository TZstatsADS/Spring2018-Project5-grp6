setwd("d:/Personal/Documents/GitHub/Spring2018-Project5-grp_6")
worldCups <- read.csv("data/fifa-world-cup/WorldCups.csv",sep=',',stringsAsFactors=F)
worldMatch <- read.csv("data/fifa-world-cup/WorldCupMatches.csv",sep=',',stringsAsFactors=F)
load("output/CompleteDataset.RData")


shinyServer(function(input, output, session) { 
  ######################################      Welcome       ######################################
  
  ######################################      History       ######################################
  #overall
  output$overall <- renderPlot({
    
    worldCups$Attendance <- sapply(worldCups$Attendance, function(x) as.numeric(gsub("\\.","",x)))
    worldCups$DateTS <- as.Date(paste0(worldCups$Year,'-01-01'))
    
    #add color
    countries <-unique(sort(append(unique(worldCups$Winner),unique(worldCups$Country))))
    cols<-colorRampPalette(brewer.pal(9,'Set1'))(length(countries))
    COLS <- data.frame(color = cols, country = countries)
    COLS$color <- as.character(COLS$color)
    COLS$country <- as.character(COLS$country)
    COLS$index <- 1:nrow(COLS)
    worldCups$CountryColor <- sapply(worldCups$Country, function(x) COLS$color[match(x,COLS$country)])
    worldCups$WinnerColor <- sapply(worldCups$Winner, function(x) COLS$color[match(x,COLS$country)])
    
    #make a legend plot
    myleg <- COLS %>% ggplot(aes(x=reorder(country,-index),y=1)) + 
      geom_bar(stat='identity',aes(fill=color)) + 
      coord_flip() + scale_fill_identity()+ 
      theme_fivethirtyeight() + 
      theme(panel.grid= element_blank() ,axis.text.x = element_blank())
    
    #add limits for the x-axis
    lims <- as.POSIXct(strptime(c("1927-01-01","2015-01-01"), format = "%Y-%m-%d"))
    
    #plot of goals vs year
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
      scale_color_identity() + theme(axis.text.x=element_blank())
    
    #add the legend plot
    g1 <- g1 + annotation_custom(ggplotGrob(myleg),
                                 xmin=as.numeric(as.POSIXct(as.Date('1922-01-01'))),
                                 xmax=as.numeric(as.POSIXct(as.Date('1936-01-01'))),
                                 ymin=90,ymax=180) +
      labs(title='Total Goals Scored per World Cup',
           subtitle='vertical lines show editions for which the host country also won')
    
    #plot of Attendance vs year                    
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
      scale_color_identity() + 
      labs(title='Attendance per World Cup')
    
    #assemble plots
    grid.arrange(g1,g2,ncol=1)
  })
  
  output$round <- renderPlot({
    load("./output/alluvials.RData")
    roundyear <- as.numeric(input$Year)
    do.call(grid.arrange, list(alluvials[[(roundyear - 1986)/4 + 1]]))
  })

  ######################################     Statistics     ######################################
  #player
  
  output$player <- DT::renderDataTable(DT::datatable({
    player_table <- CompleteDataset[,-c(3,5,9)]
    if (input$country1 == 'All'){
      player_table
    }
    else{
      player_table <- player_table[player_table$Nationality == input$country1,] 
      player_table
    }
    }, options = list(autoWidth = TRUE, dom = 'tp', scrollX = TRUE)))
  
  #by_ages
  
  output$Value1<- renderPlot({
    if (input$country1 == 'All'){selectdf_1 <- CompleteDataset}
    else{selectdf_1 <- CompleteDataset[CompleteDataset$Nationality == input$country1, ]}
    
    if (input$country2 == 'All'){selectdf_2 <- CompleteDataset}
    else{selectdf_2 <- CompleteDataset[CompleteDataset$Nationality == input$country2, ]}
    
    
    select_by_value_1 <-selectdf_1[order(selectdf_1$ValueNum,decreasing = T)[1:input$N], ]
    select_by_value_2 <-selectdf_2[order(selectdf_2$ValueNum,decreasing = T)[1:input$N], ]
    
    p1 <- ggplot(select_by_value_1, aes( y=ValueNum, x=reorder(Name,-ValueNum),fill= -Overall)) + 
      geom_col( position="dodge")+
      labs(title=paste("Top",input$N,"Players'value of",input$country1) , x="Players", y="Value (Millions €)")+
      theme(
        plot.title = element_text(size=20, face="bold",hjust = 0.5),
        axis.title.x = element_text(size=12, face="bold"),
        axis.title.y = element_text(size=10, face="bold"),
        axis.text.x = element_text(size=10, face="bold",angle = 45,vjust=0.5)
        )+
      ylim(c(0,125))
    
    p2 <- ggplot(select_by_value_2, aes(y=ValueNum, x=reorder(Name,-ValueNum),fill= -Overall)) + 
      geom_col( position="dodge")+
      labs(title=paste("Top",input$N,"Players'value of",input$country2) , x="Players", y="Value (Millions €)")+
      theme(
        plot.title = element_text(size=20, face="bold",hjust = 0.5),
        axis.title.x = element_text(size=12, face="bold"),
        axis.title.y = element_text(size=10, face="bold"),
        axis.text.x = element_text(size=10, face="bold",angle = 45,vjust=0.5)
        
        
      )+
      ylim(c(0,125))
    
    grid.arrange(p1,p2, ncol=1, nrow=2)
    
  })
  
  #download
  output$downloadData <- downloadHandler(
    filename = function() {
      paste('fifa-18-player-', input$country, '.csv', sep='')
    },
    content = function(file) {
      write.csv(player_table, file)
    }
  )
  
  ######################################     Prediction     ######################################
  
  ######################################        About       ######################################
  
})
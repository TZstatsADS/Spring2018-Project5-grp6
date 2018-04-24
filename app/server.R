setwd("~/Documents/GitHub/Spring2018-Project5-grp_6")
worldCups <- read.csv("data/fifa-world-cup/WorldCups.csv",sep=',',stringsAsFactors=F)
worldCups$DateTS <- as.Date(paste0(worldCups$Year,'-01-01'))
load("output/CompleteDataset.RData")


shinyServer(function(input, output, session) { 
  ######################################      Welcome       ######################################
  
  ######################################      History       ######################################
  #teams/matches
  output$tm <- renderPlot({
    
    #add limits for the x-axis
    lims <- as.POSIXct(strptime(c("1927-01-01","2015-01-01"), format = "%Y-%m-%d"))
    
    #teams
    qualifiedTeams<-worldCups %>% ggplot(aes(x=as.POSIXct(DateTS),y=QualifiedTeams)) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1930-01-01')),size=1.5,alpha=1,color='red') + 
      geom_vline(xintercept= as.POSIXct(as.Date('1934-01-01')),size=1.5,alpha=1,color='darkgreen') + 
      geom_vline(xintercept= as.POSIXct(as.Date('1938-01-01')),size=1.5,alpha=1,color='darkgreen') + 
      geom_vline(xintercept= as.POSIXct(as.Date('1950-01-01')),size=1.5,alpha=1,color='blue') + 
      geom_vline(xintercept= as.POSIXct(as.Date('1954-01-01')),size=1.5,alpha=1,color='gold') + 
      geom_vline(xintercept= as.POSIXct(as.Date('1970-01-01')),size=1.5,alpha=1,color='gold') + 
      geom_vline(xintercept= as.POSIXct(as.Date('1974-01-01')),size=1.5,alpha=1,color='skyblue') +
      geom_vline(xintercept= as.POSIXct(as.Date('1978-01-01')),size=1.5,alpha=1,color='skyblue') +
      geom_vline(xintercept= as.POSIXct(as.Date('1982-01-01')),size=1.5,alpha=1,color='purple') +
      geom_vline(xintercept= as.POSIXct(as.Date('1986-01-01')),size=1.5,alpha=1,color='salmon') +
      geom_vline(xintercept= as.POSIXct(as.Date('1994-01-01')),size=1.5,alpha=1,color='salmon') + 
      geom_vline(xintercept= as.POSIXct(as.Date('1998-01-01')),size=1.5,alpha=1,color='black') +
      geom_vline(xintercept= as.POSIXct(as.Date('2014-01-01')),size=1.5,alpha=1,color='black') +
      geom_line(alpha=.2,size=3) + geom_point(size=3) + 
      theme_fivethirtyeight() + 
      scale_x_datetime(limits =lims, date_breaks="4 year", labels = date_format("%Y")) + 
      scale_color_identity() + 
      labs(title='Qualified teams',
           subtitle='Lines denote the changes in the format of each final tournament:\nhttps://en.wikipedia.org/wiki/History_of_the_FIFA_World_Cup') +
      theme(axis.text.x=element_blank())
    
    #matches
    matchesPlayed<-worldCups %>% ggplot(aes(x=as.POSIXct(DateTS),y=MatchesPlayed)) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1930-01-01')),size=1.5,alpha=1,color='red') + 
      geom_vline(xintercept= as.POSIXct(as.Date('1934-01-01')),size=1.5,alpha=1,color='darkgreen') + 
      geom_vline(xintercept= as.POSIXct(as.Date('1938-01-01')),size=1.5,alpha=1,color='darkgreen') + 
      geom_vline(xintercept= as.POSIXct(as.Date('1950-01-01')),size=1.5,alpha=1,color='blue') + 
      geom_vline(xintercept= as.POSIXct(as.Date('1954-01-01')),size=1.5,alpha=1,color='gold') + 
      geom_vline(xintercept= as.POSIXct(as.Date('1970-01-01')),size=1.5,alpha=1,color='gold') + 
      geom_vline(xintercept= as.POSIXct(as.Date('1974-01-01')),size=1.5,alpha=1,color='skyblue') +
      geom_vline(xintercept= as.POSIXct(as.Date('1978-01-01')),size=1.5,alpha=1,color='skyblue') +
      geom_vline(xintercept= as.POSIXct(as.Date('1982-01-01')),size=1.5,alpha=1,color='purple') +
      geom_vline(xintercept= as.POSIXct(as.Date('1986-01-01')),size=1.5,alpha=1,color='salmon') +
      geom_vline(xintercept= as.POSIXct(as.Date('1994-01-01')),size=1.5,alpha=1,color='salmon') + 
      geom_vline(xintercept= as.POSIXct(as.Date('1998-01-01')),size=1.5,alpha=1,color='black') +
      geom_vline(xintercept= as.POSIXct(as.Date('2014-01-01')),size=1.5,alpha=1,color='black') +
      geom_line(alpha=.2,size=3) + geom_point(size=3) + 
      theme_fivethirtyeight() +
      scale_x_datetime(limits =lims, date_breaks="4 year", labels = date_format("%Y")) + 
      labs(title='Matches played')
      #theme(axis.text.x=element_text(size=11))

    #assemble plots
    grid.arrange(qualifiedTeams, matchesPlayed, ncol=1)
  })
    
  #total goals
  output$goals <- renderPlot({
    
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
    g1 <- worldCups %>% ggplot(aes(x=as.POSIXct(DateTS),y=GoalsScored,label = Winner)) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1930-01-01')),alpha=.5) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1934-01-01')),alpha=.5) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1966-01-01')),alpha=.5) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1978-01-01')),alpha=.5) + 
      geom_vline(xintercept= as.POSIXct(as.Date('1998-01-01')),alpha=.5) + 
      geom_line(alpha=.1,size=4) + 
      geom_point(aes(color=WinnerColor),size=4) + 
      theme_fivethirtyeight() + 
      scale_x_datetime(limits =lims, date_breaks="4 year", labels = date_format("%Y")) + 
      scale_color_identity() + 
      geom_text(vjust = 0, nudge_y = 4,check_overlap = T)
    
    #add the legend plot
    g1 <- g1 + annotation_custom(ggplotGrob(myleg),
                                 xmin=as.numeric(as.POSIXct(as.Date('1922-01-01'))),
                                 xmax=as.numeric(as.POSIXct(as.Date('1936-01-01'))),
                                 ymin=90,ymax=180) +
      labs(title='Total Goals Scored per World Cup',
           subtitle='Vertical lines show editions for which the host country also won')
    
    #assemble plots
    grid.arrange(g1)
  })
  
  #final rounds
  output$round <- renderPlot({
    load("output/alluvials.RData")
    roundyear <- as.numeric(input$Year)
    do.call(grid.arrange, list(alluvials[[(roundyear - 1986)/4 + 1]]))
  })

  ######################################     Statistics     ######################################
  #country
  output$map <- renderLeaflet({
    countries <- readOGR("app/www/countries.geo.json", "OGRGeoJSON")
    if (input$country_map == 'All'){
      index <- which(countries$name %in% round16_team)
      leaflet(countries[index,]) %>% 
        addTiles() %>%
        addPolygons(weight = 1, fillColor = "red", fillOpacity = 0.5)
    }
    else{
      index <- which(countries$name == input$country_map)
      leaflet(countries[index,]) %>% 
        #setView(lng, lat, zoom = 3) %>%
        addTiles() %>%
        addPolygons(weight = 1, fillColor = "red", fillOpacity = 0.5)
    }
  })
    
  #player
  output$player <- DT::renderDataTable(DT::datatable({
    player_table <- CompleteDataset[,-c(3,5,9)]
    if (input$country_player == 'All'){
      player_table
    }
    else{
      player_table <- player_table[player_table$Nationality == input$country_player,] 
      player_table
    }
    }, options = list(autoWidth = TRUE, dom = 'tp', scrollX = TRUE)))
  
  #value
  output$value <- renderPlot({
    if (input$country1_v == 'All'){selectdf_1 <- CompleteDataset}
    else{selectdf_1 <- CompleteDataset[CompleteDataset$Nationality == input$country1_v, ]}
    
    if (input$country2_v == 'All'){selectdf_2 <- CompleteDataset}
    else{selectdf_2 <- CompleteDataset[CompleteDataset$Nationality == input$country2_v, ]}

    select_by_value_1 <-selectdf_1[order(selectdf_1$ValueNum,decreasing = T)[1:input$N], ]
    select_by_value_2 <-selectdf_2[order(selectdf_2$ValueNum,decreasing = T)[1:input$N], ]
    
    p1 <- ggplot(select_by_value_1, aes( y=ValueNum, x=reorder(Name,-ValueNum),fill= -Overall)) + 
      geom_col( position="dodge")+
      labs(title=paste("Top",input$N,"Players' value of",input$country1_v) , x="Players", y="Value (Millions €)")+
      theme(
        plot.title = element_text(size=20, face="bold",hjust = 0.5),
        axis.title.x = element_text(size=12, face="bold"),
        axis.title.y = element_text(size=10, face="bold"),
        axis.text.x = element_text(size=10, face="bold",angle = 45,vjust=0.5)
        )+
      ylim(c(0,125))
    
    p2 <- ggplot(select_by_value_2, aes(y=ValueNum, x=reorder(Name,-ValueNum),fill= -Overall)) + 
      geom_col( position="dodge")+
      labs(title=paste("Top",input$N,"Players' value of",input$country2_v) , x="Players", y="Value (Millions €)")+
      theme(
        plot.title = element_text(size=20, face="bold",hjust = 0.5),
        axis.title.x = element_text(size=12, face="bold"),
        axis.title.y = element_text(size=10, face="bold"),
        axis.text.x = element_text(size=10, face="bold",angle = 45,vjust=0.5)
      )+
      ylim(c(0,125))
    
    grid.arrange(p1, p2, ncol=1)
  })
  
  #3D
  output$D3 <- renderPlotly({
    if (input$country1_3D == 'All'){selectdf_a <- CompleteDataset}
    else{selectdf_a <- CompleteDataset[CompleteDataset$Nationality == input$country1_3D, ]}
    
    if (input$country2_3D == 'All'){selectdf_b <- CompleteDataset}
    else{selectdf_b <- CompleteDataset[CompleteDataset$Nationality == input$country2_3D, ]}
    
    select_by_value_a <-selectdf_a[order(selectdf_a$ValueNum,decreasing = T)[1:input$N_3D], ]
    select_by_value_b <-selectdf_b[order(selectdf_b$ValueNum,decreasing = T)[1:input$N_3D], ]
    select_by_value <- rbind(select_by_value_a,select_by_value_b)
    
    plot_ly(x = ~Age, y = ~ValueNum, z = ~Overall, 
            color = ~Nationality, colors = c('#BF382A', '#0C4B8E'),
            type = 'scatter3d', mode = 'markers', 
            data = select_by_value,marker = list(size = 8)) %>% 
      layout(plot_bgcolor='black') %>% 
      layout(paper_bgcolor='transparent') %>%
      layout(scene = list(xaxis = list(title="Age"),
                          yaxis = list(title="Value"),
                          zaxis = list(title="Overall")))
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
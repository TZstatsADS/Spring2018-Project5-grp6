setwd("~/Documents/GitHub/Spring2018-Project5-grp_6")
worldCups <- read.csv("data/fifa-world-cup/WorldCups.csv",sep=',',stringsAsFactors=F)
worldCups$DateTS <- as.Date(paste0(worldCups$Year,'-01-01'))
load("output/CompleteDataset.RData")
team_rating <- read.csv("output/World Cup Round16 Team Ratings.csv")

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
           subtitle='Vertical lines denote the changes in the format of each final tournament.\nhttps://en.wikipedia.org/wiki/History_of_the_FIFA_World_Cup') +
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
           subtitle='Vertical lines show editions for which the host country also won.')
    
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
  #team_map
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
  
  #team_radar
  output$radar <- renderPlot({
  
    # X Axis Breaks and Labels 
    team_1 <-  team_rating[team_rating$X==input$country1_t, ][, -1]
    team_2 <- team_rating[team_rating$X==input$country2_t, ][, -1]
    df <- rbind(team_1,team_2)[,-c(1,2)]
    rownames(df) <- c(input$country1_t,input$country2_t)
    df <- rbind(rep(100,6),rep(0,6),df)

    # Plot: Same plot with custom features
    colors_border=c(rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
    colors_in=c(rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )
    radarchart( df, axistype=1 , 
                #custom polygon
                pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
                #custom the grid
                cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(20,100,20), cglwd=0.8,
                #custom labels
                vlcex=0.6,
                title = "Radar Chart"
    )
    legend(x=1.5, y=1, legend = rownames(df[-c(1,2),]), bty = "n", pch=20 , 
           col=colors_in , text.col = "grey", cex=1.2, pt.cex=3)
  })
  
  #team_overall
  output$overall <- renderPlot({
    
    # X Axis Breaks and Labels 
    overall_1 <-  team_rating[team_rating$X==input$country1_t, ]$Overall
    overall_2 <- team_rating[team_rating$X==input$country2_t, ]$Overall
    df <- data.frame(c("Overall","Overall"),c(overall_1,overall_2),c(input$country1_t,input$country2_t))
    colnames(df) <- c("Overall","Value","Nationality")
    
    # Plot
    ggplot(df, aes(x = Overall, y = Value, fill = Nationality)) +  
      geom_bar(stat = "identity", width = .1) +   
      coord_flip() + 
      labs(title="Overall",
           subtitle=paste("\n\n",
                          input$country1_t," : ", overall_1,
                          "\n\n",
                          input$country2_t, " : ", overall_2)) +
      theme_tufte() +  
      theme(plot.title = element_text(size=17, face="bold", hjust = 0.5),
            plot.subtitle = element_text(size=15, face="bold", hjust = 0.5),
            axis.text.x=element_blank(),
            axis.text.y=element_blank(),
            axis.title=element_blank(),
            axis.ticks=element_blank())
            #legend.position="none")
      #scale_fill_brewer(palette = "Dark2")  
  })
  
  #team_bar
  output$bar <- renderPlot({
    
    # X Axis Breaks and Labels 
    team_1 <-  team_rating[team_rating$X==input$country1_t, ][,-c(1,2)]
    team_2 <- team_rating[team_rating$X==input$country2_t, ][,-c(1,2)]
    df1 <- data.frame(t(rbind(colnames(team_1),team_1)))
    df1 <- cbind(df1,rep(input$country1_t,16))
    colnames(df1) <- c("Category","Value","Nationality")
    #df1$Category <- factor(df1$Category, levels = df1$Category)
    df1$Value <- as.numeric(levels(df1[,2]))[df1[,2]]
    df2 <- data.frame(t(rbind(colnames(team_2),team_2)))
    df2 <- cbind(df2,rep(input$country2_t,16))
    colnames(df2) <- c("Category","Value","Nationality")
    #df2$Category <- factor(df2$Category, levels = df2$Category)
    df2$Value <- as.numeric(levels(df2[,2]))[df2[,2]] * -1
    df <- rbind(df1,df2)

    # Plot
    ggplot(df, aes(x = Category, y = Value, fill = Nationality)) +  
      geom_bar(stat = "identity", width = .6) +   
      coord_flip() + 
      labs(title="Bar Chart") +
      theme_tufte() +  
      theme(plot.title = element_text(size=17, face="bold", hjust = .5), 
            axis.ticks = element_blank()) +  
      scale_fill_brewer(palette = "Dark2")  
  })
    
  #player_table
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
  
  #player_download
  output$downloadData <- downloadHandler(
    filename = function() {
      paste('fifa-18-player-', input$country_player, '.csv', sep='')
    },
    content = function(file) {
      player_table <- CompleteDataset[,-c(3,5,9)]
      if (input$country_player != 'All'){
        player_table <- player_table[player_table$Nationality == input$country_player,] 
      }
      write.csv(player_table, file)
    }
  )
  
  #player_compare
  output$compare <- renderPlot({
    
    selectdf_1 <- CompleteDataset[CompleteDataset$Nationality == input$country1, ]
    selectdf_2 <- CompleteDataset[CompleteDataset$Nationality == input$country2, ]
    
    selectdf_1_N <- selectdf_1[order(selectdf_1$Overall, decreasing = T)[1:input$N],]
    selectdf_1_N[input$category] <- as.numeric(unlist(selectdf_1_N[input$category]))

    selectdf_2_N <- selectdf_2[order(selectdf_2$Overall, decreasing = T)[1:input$N],]
    selectdf_2_N[input$category] <- as.numeric(unlist(selectdf_2_N[input$category]))

    p1 <- ggplot(selectdf_1_N, aes_string(y=input$category, x=paste0("reorder(Name,-", input$category,")"), fill="Overall")) + 
      geom_col( position="dodge")+
      labs(title=paste("Top",input$N,"Players'",input$category,"of",input$country1) , x="Players", y="Value (Millions €)")+
      theme(
        plot.title = element_text(size=17, face="bold",hjust = 0.5),
        axis.title.x = element_text(size=12, face="bold"),
        axis.title.y = element_text(size=10, face="bold"),
        axis.text.x = element_text(size=10, face="bold",angle = 45,vjust=0.5)
        )+
      ylim(c(0,125))
    
    p2 <- ggplot(selectdf_2_N, aes_string(y=input$category, x=paste0("reorder(Name,-", input$category,")"), fill="Overall")) + 
      geom_col( position="dodge")+
      labs(title=paste("Top",input$N,"Players'",input$category,"of",input$country2) , x="Players", y="Value (Millions €)")+
      theme(
        plot.title = element_text(size=17, face="bold",hjust = 0.5),
        axis.title.x = element_text(size=12, face="bold"),
        axis.title.y = element_text(size=10, face="bold"),
        axis.text.x = element_text(size=10, face="bold",angle = 45,vjust=0.5)
      )+
      ylim(c(0,125))
    
    grid.arrange(p1, p2, ncol=1)
    
  })
  
  output$D3 <- renderPlotly({
    
    selectdf_1 <- CompleteDataset[CompleteDataset$Nationality == input$country1, ]
    selectdf_2 <- CompleteDataset[CompleteDataset$Nationality == input$country2, ]
    
    select_by_value_1 <-selectdf_1[order(selectdf_1$Overall, decreasing = T)[1:input$N], ]
    select_by_value_2 <-selectdf_2[order(selectdf_2$Overall, decreasing = T)[1:input$N], ]
    select_by_value <- rbind(select_by_value_1, select_by_value_2)
    
    plot_ly(x = ~Age, y = ~ValueNum, z = ~Overall, 
            color = ~Nationality, colors = c('#BF382A', '#0C4B8E'),
            type = 'scatter3d', mode = 'markers', 
            data = select_by_value,marker = list(size = 8)) %>% 
      layout(plot_bgcolor='black') %>% 
      layout(paper_bgcolor='transparent') %>%
      layout(scene = list(xaxis = list(title="Age"),
                          yaxis = list(title="Value"),
                          zaxis = list(title="Overall"))) %>%
      layout(title = "<b>Top Players' Overall-Value-Age 3D Scatter Plot</b>")
  })
  
  ######################################     Prediction     ######################################
  
  ######################################        About       ######################################
  
})
#check and install packages
packages.used <- c("shiny", "scales","magrittr","ggplot2","ggthemes",
                   "gridExtra","RColorBrewer","DT","gridExtra","plotly",
                   "ggalluvial","leaflet","rgdal","fmsb")

packages.needed <- setdiff(packages.used, 
                           intersect(installed.packages()[,1], packages.used))

if(length(packages.needed)>0){
  install.packages(packages.needed, dependencies = TRUE)
}

library(shiny)
library(scales)
library(magrittr)
library(ggplot2)
library(ggthemes)
library(gridExtra)
library(RColorBrewer)
library(DT)
library(gridExtra)
library(plotly)
library(ggalluvial)
library(leaflet)
library(rgdal)
library(fmsb)

#team
all_team <- sort(c("Russia","Uruguay","Saudi Arabia","Egypt",
                   "Spain", "Portugal","Morocco","Iran",
                   "France", "Denmark", "Argentina", "Croatia",
                   "Australia","Iceland","Peru","Nigeria",
                   "Costa Rica","Serbia","Germany","Mexico",
                   "Brazil", "Switzerland","Sweden","South Korea",
                   "Belgium", "United Kingdom","Panama","Tunisia",
                   "Poland", "Colombia","Japan","Senegal"
                   ))
round16_team <- sort(c("Russia", "Uruguay", "Spain", "Portugal", "France", "Denmark", "Argentina", "Croatia",
                       "Brazil", "Switzerland", "Germany", "Sweden", "Belgium", "England", "Poland", "Colombia"))
round16_team_map <- sort(c("Russia", "Uruguay", "Spain", "Portugal", "France", "Denmark", "Argentina", "Croatia",
                           "Brazil", "Switzerland", "Germany", "Sweden", "Belgium", "Poland", "Colombia"))

#year
years <- seq(1986, 2014, len=8)

#category
category <- c("ValueNum", "Age",
              "Acceleration","Ball.control","Dribbling","Finishing","Heading.accuracy",
              "Interceptions","Long.shots","Positioning","Short.passing","Sliding.tackle",
              "Stamina","Standing.tackle","Strength","Vision")



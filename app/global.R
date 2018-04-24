#check and install packages
packages.used <- c("shiny", "scales","magrittr","ggplot2","ggthemes",
                   "gridExtra","RColorBrewer","DT","gridExtra","plotly",
                   "ggalluvial","leaflet","rgdal")

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

#teams
round16_team <- sort(c("Russia", "Uruguay", "Spain", "Portugal", "France", "Denmark", "Argentina", "Croatia",
                       "Brazil", "Switzerland", "Germany", "Sweden", "Belgium", "England", "Poland", "Colombia"))

#years
years <- seq(1986, 2014, len=8)
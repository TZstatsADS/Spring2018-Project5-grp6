
CompleteDataset <- read.csv("../data/fifa-18-demo-player-dataset/CompleteDataset.csv",sep=',',stringsAsFactors=F)[,-1]
##### Caluate the num of each player's value & wage
value <- CompleteDataset$Value
for(i in 1:length(value)){
  if(substr(value[i],nchar(value[i]),nchar(value[i])) == "M"){
    value[i] <- as.numeric(substr(value[i],2,nchar(value[i])-1)) * 1000000
  }
  else{
    value[i] <- as.numeric(substr(value[i],2,nchar(value[i])-1)) * 1000
  }
}
value[which(is.na(value)==T)] <- 0
CompleteDataset$ValueNum <- as.numeric(value)/1000000

wage <- CompleteDataset$Wage
for(i in 1:length(wage)){
  if(substr(wage[i],nchar(wage[i]),nchar(wage[i])) == "K"){
    wage[i] <- as.numeric(substr(wage[i],2,nchar(wage[i])-1)) * 1000
  }
  else{
    wage[i] <- 0
  }
}
value[which(is.na(wage)==T)] <- 0
CompleteDataset$WageNum <- as.numeric(wage)/1000

save(CompleteDataset,file = "../output/CompleteDataset.RData")


win_loss<-read.csv("P5_use.csv", encoding = "UTF-8")
win_loss<-win_loss[,1:3]
win_loss_HA<-win_loss[which(win_loss$FTR == "H"|win_loss$FTR == "A"),]
names(win_loss_HA)<-c("Home", "Away", "R")
teamNamesH<-unique(win_loss_HA$Home)
teamNamesA<-unique(win_loss_HA$Away)

teams<-union(teamNamesA, teamNamesH)
write.csv(win_loss_HA, "Club_result.csv")
save("team_ratings.RData", team_ratings)

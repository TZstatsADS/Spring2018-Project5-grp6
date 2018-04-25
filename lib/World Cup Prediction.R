WC<-read.csv("Round 16 Matches.csv", sep = ",")
nation_rating<-read.csv("World Cup Round16 Team Ratings.csv")
nation_table<-data.frame()
for(i in 1: nrow(WC)){
  HH<-which(nation_rating$X ==as.character(WC$Home[i]))
  AA<-which(nation_rating$X ==as.character(WC$Away[i]))
  nation_table<-rbind(nation_table, nation_rating[HH,-1]-nation_rating[AA,-1])
}

pre16round_svm<-predict(fit_svm2, newdata = nation_table)

pre16round_nnw<-compute(nn_fit, nation_table)
pre16round_nnw<-ifelse(unlist(pre16round_nnw$net.result)>=1.5, 2, 1)
pre_RF<-predict(fit_forest, nation_table)
pre16round_svm
pre16round_nnw
pre_RF

result<-read.csv("Club_result.csv")
club_rating<-read.csv("clubs_rating.csv")
#club_rating_long<-read.csv("clubs_rating.csv")



#################################################
###########add opposite but symmetric Rows######

################################################
match_table<-data.frame()

for(i in 1: nrow(result)){
  HH<-which(club_rating$X ==result$Home[i])
  AA<-which(club_rating$X ==result$Away[i])
  match_table<-rbind(match_table, club_rating[HH,-1]-club_rating[AA,-1])
}

match_table$r<-as.factor(ifelse(result$R == "H", 1, 0))
# match_table$H<-result$Home
# match_table$A<-result$Away
#################################################
###########add opposite but symmetric Rows######
# match_table_oppo<--1*match_table[, -18]
# match_table_oppo$r<-as.factor(ifelse(result$R == "H", 0, 1))
# match_table<-rbind(match_table, match_table_oppo)
################################################
### ML methods

### SVM
library(e1071)
train<-sample(1:nrow(match_table), 900)

fit_svm1<-svm(r~., data = match_table[train,], kernel = "linear", scale = FALSE)
pre_svm1<-predict(fit_svm1, newdata = match_table[-train,-18])
mean(pre_svm1==match_table$r[-train])

tune.out_nonlinear<-tune.svm(r~., data = match_table[train,], kernel = "radial", scale = TRUE, cost = seq(10, 20, 1), gamma = seq(0.0001, 0.03, 0.005))
tune.out_nonlinear
fit_svm2<-svm(r~., data = match_table[train,], kernel = "radial", scale = TRUE, cost = 11, gamma = 0.0151)
pre_svm2<-predict(fit_svm2, newdata = match_table[-train,-18])

mean(pre_svm2==match_table$r[-train])


### Tree & Random Forest
library(rpart)
library(rpart.plot)

fitTree_cla<-rpart(r~., data = match_table[train,], 
                   control = rpart.control(maxdepth =  8, minbucket =  20, cp = 0.01))
rpart.plot(fitTree_cla)
pre_cla<-predict(fitTree_cla, newdata = match_table[-train,])
pre_cla<-apply(pre_cla, 1, which.max)-1

mean(pre_cla == match_table$r[-train])


library(randomForest)

fit_forest<-randomForest(r~., data = match_table[train,], ntree = 1000)
pre_RF<-predict(fit_forest, newdata = match_table[-train,])
mean(pre_RF==match_table$r[-train])

  

## Xgboost
match_tableXG<-apply(match_table, 2, as.numeric)
library(xgboost)
library(DiagrammeR)
rr<-match_table[, 18]
X<-xgb.DMatrix(data = data.matrix(match_tableXG[, -18]), label = rr)

xgboost_para <- function(dat_train,label_train,K){
  dtrain = xgb.DMatrix(data=data.matrix(dat_train),label=label_train)
  max_depth<-c(3,5,7)
  eta<-c(0.1,0.3,0.5)
  best_params <- list()
  best_err <- Inf 
  para_mat = matrix(nrow=3, ncol=3)
  
  for (i in 1:3){
    for (j in 1:3){
      my.params <- list(max_depth = max_depth[i], eta = eta[j])
      set.seed(11)
      cv.output <- xgb.cv(data=dtrain, params=my.params, 
                          nrounds = 100, gamma = 0, subsample = 0.5,
                          objective = "multi:softprob", num_class = 3,
                          nfold = K, nthread = 2, early_stopping_rounds = 5, 
                          verbose = 0, maximize = F, prediction = T)
      
      min_err <- min(cv.output$evaluation_log$test_merror_mean)
      para_mat[i,j] <- min_err
      
      if (min_err < best_err){
        best_params <- my.params
        best_err <- min_err
      }
    }
  }
  best_params$num_class <- 2
  return(list(para_mat, best_params, best_err))
}

xg<-xgboost_para(match_tableXG[train,-18], rr[train], 5)
xg_fit<- xgb.train(data=X[train], params = list(max_depth = 3, eta = 0.1), nrounds = 100)
test<-as.matrix(match_tableXG[-train, -18])
pre_xg<-predict(xg_fit, newdata = test)
pre_xg<-ifelse(pre_xg>=1.5, 1, 0)
mean(pre_xg == match_table[-train,18])
xgb.plot.multi.trees(xg_fit)


### NNW
library(neuralnet)
n <- names(match_table)
match_nn<-apply(match_table[, -18], 2, scale)
match_nn<-cbind(match_nn, as.numeric(match_table$r)+1)
names(match_nn)<-names(match_table)
f <- as.formula(paste("as.numeric(r) ~", paste(n[!n %in% "r"], collapse = " + ")))


nn_fit <- neuralnet(f,data= match_table[train,],hidden=c(9), stepmax = 10e8)
pre_net<-unlist(nn_fit$net.result)

pre_net_test<-compute(nn_fit, match_table[-train,-18])
pre_net_test<-unlist(pre_net_test$net.result)
pre_net_test<-ifelse(pre_net_test>=1.5, 2, 1)
pre_net<-ifelse(pre_net>=1.5, 2, 1)
mean(pre_net_test == as.numeric(match_table$r[-train]))
#pre_nn<-compute(nn_fit, match_table[-train,-18])
  
pre_nn$net.result


teamstats <- read.csv("CompleteDataset.csv", header = TRUE)

round16_team <- c("Russia", "Uruguay", "Spain", "Portugal", "France", "Denmark", "Argentina", "Croatia",
                  "Brazil", "Switzerland", "Germany", "Sweden", "Belgium", "England", "Poland", "Colombia")

team_players <- list()

for(i in 1:length(round16_team)) {
  team_players[[i]] <- teamstats[teamstats$Nationality == round16_team[i], ]
}

team_players[[1]]

names(team_players) <- round16_team

team_best_players <-list()

for(i in 1:length(round16_team)) {
  team_best_players[[i]] <- team_players[[i]][order(team_players[[i]]$Overall, decreasing = TRUE), ]
  team_best_players[[i]] <- team_best_players[[i]][1:30, ]
}

team_best_players

attack_rating <- function(list1) {
  # CAM Ratings
  best_CAM_ratings <- NULL
  best_CAM <- list()
  for(i in 1:length(list1)) {
    best_CAM[[i]] <- list1[[i]][order(list1[[i]]$CAM, decreasing = TRUE), ]
    best_CAM[[i]] <- best_CAM[[i]][1:5, ]
    best_CAM_ratings <- rbind(best_CAM_ratings, c(mean(as.numeric(as.character(best_CAM[[i]]$Acceleration))), mean(as.numeric(as.character(best_CAM[[i]]$Dribbling))), 
                               mean(as.numeric(as.character(best_CAM[[i]]$Finishing))), mean(as.numeric(as.character(best_CAM[[i]]$Heading.accuracy)))))
  }
  
  # ST Ratings
  best_ST_ratings <- NULL
  best_ST <- list()
  for(i in 1:length(list1)) {
    best_ST[[i]] <- list1[[i]][order(list1[[i]]$ST, decreasing = TRUE), ]
    best_ST[[i]] <- best_ST[[i]][1:5, ]
    best_ST_ratings <- rbind(best_ST_ratings, c(mean(as.numeric(as.character(best_CAM[[i]]$Acceleration))), mean(as.numeric(as.character(best_CAM[[i]]$Dribbling))), 
                                                mean(as.numeric(as.character(best_CAM[[i]]$Finishing))), mean(as.numeric(as.character(best_CAM[[i]]$Heading.accuracy)))))
  }
  
  # LW Ratings
  best_LW_ratings <- NULL
  best_LW <- list()
  for(i in 1:length(list1)) {
    best_LW[[i]] <- list1[[i]][order(list1[[i]]$LW, decreasing = TRUE), ]
    best_LW[[i]] <- best_LW[[i]][1:5, ]
    best_LW_ratings <- rbind(best_LW_ratings, c(mean(as.numeric(as.character(best_LW[[i]]$Acceleration))), mean(as.numeric(as.character(best_LW[[i]]$Dribbling))), 
                                                mean(as.numeric(as.character(best_LW[[i]]$Finishing))), mean(as.numeric(as.character(best_LW[[i]]$Heading.accuracy)))))
  }
  
  # RW Ratings
  best_RW_ratings <- NULL
  best_RW <- list()
  for(i in 1:length(list1)) {
    best_RW[[i]] <- list1[[i]][order(list1[[i]]$RW, decreasing = TRUE), ]
    best_RW[[i]] <- best_RW[[i]][1:5, ]
    best_RW_ratings <- rbind(best_RW_ratings, c(mean(as.numeric(as.character(best_RW[[i]]$Acceleration))), mean(as.numeric(as.character(best_RW[[i]]$Dribbling))), 
                                                mean(as.numeric(as.character(best_RW[[i]]$Finishing))), mean(as.numeric(as.character(best_RW[[i]]$Heading.accuracy)))))
  }
  
  overall_attack <- data.frame()
  for(i in 1:length(list1)) {
    overall_attack <- rbind(overall_attack, floor((best_CAM_ratings[i, ] + best_ST_ratings[i, ] +
                              best_LW_ratings[i, ] + best_RW_ratings[i, ])/4))
  }
  
  return(overall_attack)
}
attack_score <- attack_rating(team_best_players)
attack_score

midfield_rating <- function(list1) {
  # CM Ratings
  best_CM_ratings <- NULL
  best_CM <- list()
  for(i in 1:length(list1)) {
    best_CM[[i]] <- list1[[i]][order(list1[[i]]$CM, decreasing = TRUE), ]
    best_CM[[i]] <- best_CM[[i]][1:5, ]
    best_CM_ratings <- rbind(best_CM_ratings, c(mean(as.numeric(as.character(best_CM[[i]]$Interceptions))), mean(as.numeric(as.character(best_CM[[i]]$Long.shots))), 
                                                  mean(as.numeric(as.character(best_CM[[i]]$Vision)))))
  }
  
  overall_midfield <- data.frame()
  for(i in 1:length(list1)) {
    overall_midfield <- rbind(overall_midfield, floor((best_CM_ratings[i, ])))
  }
  
  return(overall_midfield)
}
midfield_score <- midfield_rating(team_best_players)
midfield_score


defense_rating <- function(list1) {
  # CB Ratings
  best_CB_ratings <- NULL
  best_CB <- list()
  for(i in 1:length(list1)) {
    best_CB[[i]] <- list1[[i]][order(list1[[i]]$CB, decreasing = TRUE), ]
    best_CB[[i]] <- best_CB[[i]][1:5, ]
    best_CB_ratings <- rbind(best_CB_ratings, c(mean(as.numeric(as.character(best_CB[[i]]$Interceptions))), mean(as.numeric(as.character(best_CB[[i]]$Sliding.tackle))), 
                                                mean(as.numeric(as.character(best_CB[[i]]$Standing.tackle)))))
  }
  
  # LB Ratings
  best_LB_ratings <- NULL
  best_LB <- list()
  for(i in 1:length(list1)) {
    best_LB[[i]] <- list1[[i]][order(list1[[i]]$LB, decreasing = TRUE), ]
    best_LB[[i]] <- best_LB[[i]][1:5, ]
    best_LB_ratings <- rbind(best_LB_ratings, c(mean(as.numeric(as.character(best_LB[[i]]$Interceptions))), mean(as.numeric(as.character(best_LB[[i]]$Sliding.tackle))), 
                                                mean(as.numeric(as.character(best_LB[[i]]$Standing.tackle)))))
  }
  
  # RB Ratings
  best_RB_ratings <- NULL
  best_RB <- list()
  for(i in 1:length(list1)) {
    best_RB[[i]] <- list1[[i]][order(list1[[i]]$RB, decreasing = TRUE), ]
    best_RB[[i]] <- best_RB[[i]][1:5, ]
    best_RB_ratings <- rbind(best_RB_ratings, c(mean(as.numeric(as.character(best_RB[[i]]$Interceptions))), mean(as.numeric(as.character(best_RB[[i]]$Sliding.tackle))), 
                                                mean(as.numeric(as.character(best_RB[[i]]$Standing.tackle)))))
  }
  
  overall_defense <- data.frame()
  for(i in 1:length(list1)) {
    overall_defense <- rbind(overall_defense, floor((best_CB_ratings[i, ] + best_LB_ratings[i, ] + best_RB_ratings[i, ])/3))
  }
  
  return(overall_defense)
}

defense_score <- defense_rating(team_best_players)
defense_score

GK_rating <- function(list1) {
  # GK Ratings
  best_GK_ratings <- NULL
  best_GK <- list()
  for(i in 1:length(list1)) {
    list1[[i]]$Preferred.Positions <- as.character(list1[[i]]$Preferred.Positions)
    best_GK[[i]] <- list1[[i]][list1[[i]]$Preferred.Positions == "GK ", ]
    best_GK_ratings <- rbind(best_GK_ratings, c(mean(as.numeric(as.character(best_GK[[i]]$Overall)))))
  }
  
  overall_GK <- data.frame()
  for(i in 1:length(list1)) {
    overall_GK <- rbind(overall_GK, floor((best_GK_ratings[i, ])))
  }
  
  return(overall_GK)
}
GK_score <- GK_rating(team_best_players)
GK_score

allposition_rating <- function(list1) {
  allratings <- NULL
  for(i in 1:length(list1)) {
    allratings <- rbind(allratings, c(mean(as.numeric(as.character(list1[[i]]$Overall))), mean(as.numeric(as.character(list1[[i]]$Ball.control))), 
                                      mean(as.numeric(as.character(list1[[i]]$Short.passing))), mean(as.numeric(as.character(list1[[i]]$Stamina))), 
                                      mean(as.numeric(as.character(list1[[i]]$Strength))), mean(as.numeric(as.character(list1[[i]]$Positioning)))))
  }
  
  overall_allpositions <- data.frame()
  for(i in 1:length(list1)) {
    overall_allpositions <- rbind(overall_allpositions, floor((allratings[i, ])))
  }
  
  return(overall_allpositions)
}



allposition_score <- allposition_rating(team_best_players)
allposition_score


team_rating <- function(list1) {
  attack_score <- attack_rating(list1)
  
  midfield_score <- midfield_rating(list1)
  
  defense_score <- defense_rating(list1)
  
  GK_score <- GK_rating(list1)
  
  allposition_score <- allposition_rating(list1)
  
  team_complete_rating <- cbind(allposition_score, attack_score, midfield_score, defense_score, GK_score)
  
  colnames(team_complete_rating) <- c("Overall", "Ball Control", "Short Passing", "Stamina", "Strength", "Positioning", 
                                      "Acceleration", "Dribbling", "Finishing", "Heading Accuracy", 
                                      "Interceptions Midfield", "Long Shots", "Vision", 
                                      "Interceptions Defense", "Sliding Tackle", "Standing Tackle", "GK")
  
  return(team_complete_rating)
}

world_cup_round16_ratings <- team_rating(team_best_players)
rownames(world_cup_round16_ratings) <- round16_team
world_cup_round16_ratings

write.csv(world_cup_round16_ratings, file = "World Cup Round16 Team Ratings.csv")





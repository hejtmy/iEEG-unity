get_trial_pointing <- function(dt_player, test, trialID){
  ls <- list()
  timewindow <- get_trial_timewindow(test, trialID)
  if (is.null(timewindow)) return(NULL);
  quest_log <- dt_player[Time > timewindow$start & Time < timewindow$finish, ]
  point_situation <- quest_log[Input == "Point", ]
  if(nrow(point_situation) < 1){
    smart_print(c("Warning", "get_trial_pointing", "no point event found"))
    ls$time <- NA
    ls$chosen <- NA
    ls$target <- NA
  } else { 
    point_situation = point_situation[1]
    player_pos <- c(point_situation$Position.x, point_situation$Position.z)
    target_pos <- get_goal_position(i_goal = get_goal_index(test, trialID), test = test, onlyXY = T)
    ls$time <- point_situation$Time
    ls$chosen <- point_situation$Rotation.X
    ls$target <- angle_from_positions(player_pos, target_pos)
  }
  return(ls)
}
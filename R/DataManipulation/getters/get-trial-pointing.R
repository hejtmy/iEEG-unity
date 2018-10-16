get_trial_pointing <- function(obj, trialId){
  ls <- list()
  trial_log <- get_trial_log(obj, trialId)
  point_situation <- trial_log[Input == "Point", ]
  if(nrow(point_situation) < 1){
    smart_print(c("Warning", "get_trial_pointing", "no point event found"))
    ls$time <- NA
    ls$chosen <- NA
    ls$target <- NA
  } else { 
    point_situation <- point_situation[1]
    player_pos <- c(point_situation$Position.x, point_situation$Position.z)
    target_pos <- get_goal_position(obj, i_goal = get_goal_index(obj, trialId), onlyXY = T)
    ls$time <- point_situation$Time
    ls$chosen <- point_situation$Rotation.X
    ls$target <- angle_from_positions(player_pos, target_pos)
  }
  return(ls)
}
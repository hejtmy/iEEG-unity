get_goal_position <- function(obj, i_goal, onlyXY = F){
  goalPosition <- obj$data$experiment_log$positions$GoalPositions[i_goal, ]
  if (onlyXY){
    return(c(goalPosition$Position.x, goalPosition$Position.z))
  } else return(goalPosition)
}
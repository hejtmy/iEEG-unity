get_goal_start_distance <- function(obj, trialId = NULL){
  goalIndex <- get_goal_index(obj, trialId)
  goalPosition <- get_goal_position(obj, goalIndex)
  startIndex <- get_start_index(obj, trialId)
  startPosition <- get_start_positsions(obj, startIndex)
  return(dist(rbind(startPosition, goalPosition))[[1]] - get_experiment_settings(obj)$GoalSize)
}
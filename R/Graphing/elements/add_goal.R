add_goal <- function(plot, obj, trialID){
  i_goal <- get_goal_index(obj, trialID) 
  goal_pos <- get_goal_position(obj, i_goal)
  goal_area <- make_circle(get_goal_position(obj, i_goal, onlyXY = T), get_experiment_settings(obj)$GoalSize, precision = 100)
  #draws goal
  plot <- plot +
    geom_point(data = goal_pos, aes(Position.x, Position.z), size = 3, color = "red") +
    geom_path(data = goal_area, aes(x, y), color = "red")
  return(plot)
}
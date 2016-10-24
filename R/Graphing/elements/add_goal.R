add_goal = function(plot, test, trialID){
  i_goal = get_goal_index(test, trialID) 
  goal_pos = get_goal_position(test, i_goal)
  goal_area = make_circle(GoalPosition(test, i_goal, onlyXY = T), test$experimentSettings$GoalSize, precision = 100)
  #draws goal
  plot = plot +
    geom_point(data = goal_pos, aes(Position.x, Position.z), size = 5, color = "red") +
    geom_path(data = goal_area, aes(x, y), color = "red")
}
add_goal = function(plot, test, trialID){
  i_goal = GetGoalIndex(test, trialID) 
  goal_pos = GoalPosition(test, i_goal)
  goal_area = MakeCircle(GoalPosition(test, i_goal, onlyXY = T), test$experimentSettings$GoalSize, precision = 100)
  #draws goal
  plot = plot +
    geom_point(data = goal_pos, aes(Position.x, Position.z), size = 5, color = "red") +
    geom_path(data = goal_area, aes(x, y), color = "red")
}
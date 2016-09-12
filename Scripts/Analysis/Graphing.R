make_trial_image = function (dt_position, test, trialID, special_paths = NULL, special_points = NULL){
  plot = ggplot() + theme_void()
  
  #draws round arena
  round_area = MakeCircle(c(0,0), test$experimentSettings$MarkRadius, precision = 100)
  plot = plot + geom_path(data = round_area, aes(x, y)) 
  
  plot = plot + geom_path(data = round_area, aes(x, y))
  
  #draws start point
  i_start = StartIndex(test, trialID)
  start_pos = StartPosition(test, i_start)
  plot = plot + geom_point(data = start_pos, aes(Position.x, Position.z), size = 10, color = "red")
  
  #draws mark 
  if(GetTrialType(test, trialID) == "Allo") {
    i_mark = MarkIndex(test, trialID)
    mark_pos = MarkPosition(test, i_mark)
    plot = plot + geom_point(data = mark_pos, aes(Position.x, Position.z), size = 10, color = "blue")
  }
  #finds goal
  i_goal = GetGoalIndex(test, trialID) 
  goal_pos = GoalPosition(test, i_goal)
  goal_area = MakeCircle(GoalPosition(test, i_goal, onlyXY = T), test$experimentSettings$GoalSize, precision = 100)
  #draws goal
  plot = plot +
    geom_point(data = goal_pos, aes(Position.x, Position.z), size = 5, color = "red") +
    geom_path(data = goal_area, aes(x, y), color = "red")
  
  #plots player
  trial_timewindow = GetTrialTimewindow(test,trialID)
  playerLog = SelectPlayerLog(dt_position, trial_timewindow)
  plot = plot + geom_path(data = playerLog, aes(Position.x, Position.z))
  return(plot)
}
make_trial_images = function(dt_position, test, columns = 5, indexes = c()){
  indexes = if (length(indexes)==0) TrialIndexes(test, "Finished") else indexes
  plots = list()
  for(i in indexes){
    plots[[i]] = make_trial_image(dt_position, test, i)
  }
  multiplot(plots, cols = columns)
}
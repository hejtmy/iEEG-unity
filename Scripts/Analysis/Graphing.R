MakeTrialImage = function (positionTable, test, trialID, special_paths = NULL, special_points = NULL){
  plot = ggplot() + theme_void()
  
  #draws round arena
  roundArena = MakeCircle(c(0,0),test$experimentSettings$MarkRadius,precision = 100)
  plot = plot + geom_path(data = roundArena, aes(x,y)) 
  
  plot = plot + geom_path(data = roundArena, aes(x,y))
  #draws start point
  startIndex = StartIndex(test, trialID)
  startPosition = StartPosition(test, startIndex)
  plot = plot + geom_point(aes(startPosition), size = 10, color = "red")
  #draws mark
  if(GetTrialType(test,trialID) == "Allo") {
    markIndex = MarkIndex(test,trialID)
    markPosition = MarkPosition(test,markIndex)
    plot = plot + geom_point(aes(markPosition), size = 10, color = "blue")
  }
  #finds goal
  goalIndex = GetGoalIndex(test, trialID) 
  goalPosition = GoalPosition(test, goalIndex)
  goalArea = MakeCircle(goalPosition,test$experimentSettings$GoalSize,precision = 100)
  #draws goal
  plot = plot +
    geom_point(data = goalPosition, aes(Position.x, Position.z), size = 5, color = "red") +
    geom_path(data = goalArea, aes(x, y), color = "red")
  
  #plots player
  trialTimewindow = GetTrialTimewindow(test,trialID)
  playerLog = SelectPlayerLog(positionTable,trialTimewindow)
  plot = plot + geom_path(data = playerLog, aes(Position.x, Position.z))
  return(plot)
}
MakeTrialImages = function(positionTable, test, columns = 5, indexes = c()){
  indexes = if (length(indexes)==0) TrialIndexes(test, "Finished") else indexes
  plots = list()
  for(i in indexes){
    plots[[i]] = MakeTrialImage(positionTable,test,i)
  }
  multiplot(plots ,cols = columns)
}
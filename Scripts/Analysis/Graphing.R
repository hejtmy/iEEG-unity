MakeTrialImage = function (positionTable, test, trialID, special_paths = NULL, special_points = NULL){
  plot = ggplot() + theme_void()
  
  #draws round arena
  roundArena = MakeCircle(c(0,0),test$experimentSettings$MarkRadius,precision = 100)
  plot = plot + geom_path(data = roundArena, aes(x,y)) 
  
  plot = plot + geom_path(data = roundArena, aes(x,y))
  #draws start point
  startIndex = test$experimentSettings$StartOrder[trialID] + 1
  startPosition = test$positionSettings$StartPositions[startIndex,]
  plot = plot + geom_point(data = startPosition, aes(Position.x, Position.z), size = 10, color = "red")
  #draws mark
  if(GetTrialType(test,trialID) == "Allo") {
    markIndex = test$experimentSettings$MarkOrder[trialID] + 1
    markPosition = test$positionSettings$MarkPositions[markIndex,]
    plot = plot + geom_point(data = markPosition, aes(Position.x, Position.z), size = 10, color = "blue")
  }
  #finds goal
  goalIndex = GetGoalIndex(test, trialID) 
  goalPosition = test$positionSettings$GoalPositions[goalIndex,]
  goalArea = MakeCircle(c(goalPosition$Position.x, goalPosition$Position.z),test$experimentSettings$GoalSize,precision = 100)
  #draws goal
  plot = plot +
    geom_point(data=goalPosition, aes(Position.x, Position.z), size = 10, color = "red") +
    geom_path(data = goalArea, aes(x, y), color = "red")
  
  #plots player
  trialTimewindow = GetTrialTimewindow(test,trialID)
  playerLog = SelectPlayerLog(positionTable,trialTimewindow)
  plot = plot + geom_path(data = playerLog, aes(Position.x, Position.z))
  return(plot)
}
MakeAllTrialImages = function(positionTable, test){
  indexes = TrialIndexes(test, "Finished")
  plots = list()
  for(i in indexes){
    plots[[i+1]] = MakeTrialImage(positionTable,test,i+1)
  }
  multiplot(plots ,cols = 4)
}
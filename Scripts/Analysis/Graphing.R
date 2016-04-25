MakeTrialImage <- function (positionTable, test, trialID, special_paths = NULL, special_points = NULL){
  
  roundArena = circleFunction(c(0,0),test$experimentSettings$MarkRadius,precision = 100)
  plot = ggplot(positionTable, aes(Position.x, Position.z)) +
    #draws round arena
    geom_path(data = roundArena, aes(x,y))
    #scale_x_continuous(limits = 1) +
    #scale_y_continuous(limits = 1)
  
  plot = ggplot() + geom_path(data = roundArena, aes(x,y))
  #draws start point
  startIndex = test$experimentSettings$StartOrder[trialID] + 1
  startPosition = test$positionSettings$StartPositions[startIndex,]
  plot = plot + geom_point(data = startPosition, aes(Position.x, Position.z), size = 10, color = "red")
  #draws mark
  if(trialType(test,trialID) == "Allo") {
    markIndex = test$experimentSettings$MarkOrder[trialID] + 1
    markPosition = test$positionSettings$MarkPositions[markIndex,]
    plot = plot + geom_point(data = markPosition, aes(Position.x, Position.z), size = 10, color = "blue")
  }
  #draws goal
  #finds goal
  goalIndex = GetGoalIndex(trialID, test) 
  goalPosition = test$positionSettings$GoalPositions[goalIndex,]
  goalArea = circleFunction(c(goalPosition$Position.x, goalPosition$Position.z),test$experimentSettings$GoalSize,precision = 100)
  plot = plot +
    geom_point(data=goalPosition, aes(Position.x, Position.z), size = 10, color = "red") +
    geom_path(data = goalArea, aes(x, y), color = "red")
  
  #plots player
  trialTimewindow = GetTrialTimewindow(test,trialID)
  playerLog = SelectPlayerLog(positionTable,trialTimewindow)
  plot = plot + geom_path(data = playerLog, aes(Position.x, Position.z))
  return(plot)
}
AddPointsToPlot = function(plot, ls){
  list_names = names(ls)
  data_table = data.frame(point.x=numeric(0),point.y=numeric(0), point.name=character(), stringsAsFactors = F)
  for (i in 1:length(ls)){
    data_table[i,1] = ls[[i]][1]
    data_table[i,2] = ls[[i]][2]
    data_table[i,3] = list_names[i]
  }
  plot = plot + geom_point(data = data_table, aes(point.x,point.y),size = 4, color = "blue") + geom_text(data = data_table, aes(point.x, point.y,label=point.name))
  return(plot)
}
AddSpecialPaths = function(position_table, ls){
  list_names = names(ls)
  position_table = position_table[, special:= "normal"]
  list_names = names(ls)
  for (i in 1:length(ls)){
    position_table = position_table[is_between(Time,ls[[i]]$start,ls[[i]]$finish), special:= list_names[i] ]
  }
  return(position_table)
}
SavePlot = function(inputPlot,name){
  mypath <- paste("../images/", name, sep = "")
  file = png(mypath, width = 1200, height = 800, units = "px")
  plot(inputPlot)
  dev.off()
}

circleFunction <- function(center = c(0,0), radius = 1, precision = 100){
  tt <- seq(0,2*pi,length.out = precision)
  xx <- center[1] + radius * cos(tt)
  yy <- center[2] + radius * sin(tt)
  return(data.frame(x = xx, y = yy))
}
GetGoalIndex = function(trialID, test){
  if(trialType(test, trialID)=="Allo"){
    uncorrectedIndex = test$experimentSettings$MarkOrder[trialID] + test$experimentSettings$AlloMarkRelation + 1 
  } else {
    uncorrectedIndex = test$experimentSettings$StartOrder[trialID] + test$experimentSettings$EgoMarkRelation + 1 
  }
  if(uncorrectedIndex>test$experimentSettings$NumberOfGoals) return(uncorrectedIndex-test$experimentSettings$NumberOfGoals) else return(uncorrectedIndex)
}
trialType = function(test,trialID){
  return(test$experimentSettings$RandomOrdering[trialID])
}

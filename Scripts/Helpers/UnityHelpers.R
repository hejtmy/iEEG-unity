SelectPlayerLog = function(playerLog, trialTimewindow){
  #checking for entirety
  log = playerLog[Time > trialTimewindow$start & Time < trialTimewindow$finish]
  #checking log
  return(log)
}
GetGoalIndex = function(test, trialID){
  if(get_trial_type(test, trialID)=="Allo"){
    uncorrectedIndex = test$experimentSettings$MarkOrder[trialID] + test$experimentSettings$AlloMarkRelation + 1 
  } else {
    uncorrectedIndex = test$experimentSettings$StartOrder[trialID] + test$experimentSettings$EgoMarkRelation + 1 
  }
  if(uncorrectedIndex>test$experimentSettings$NumberOfGoals) return(uncorrectedIndex-test$experimentSettings$NumberOfGoals) else return(uncorrectedIndex)
}
GoalPosition = function(test, goalIndex, onlyXY = F){
  goalPosition = test$positionSettings$GoalPositions[goalIndex, ]
  if (onlyXY){
    return(c(goalPosition$Position.x, goalPosition$Position.z))
  } else return(goalPosition)
}
StartIndex = function(test, trialID){
  return(test$experimentSettings$StartOrder[trialID] + 1)
}
StartPosition = function(test, startIndex, onlyXY = F){
  startPosition = test$positionSettings$StartPositions[startIndex,]
  if (onlyXY){
    return(c(startPosition$Position.x,startPosition$Position.z))
  } else return(startPosition)
}
MarkIndex = function(test, trialID){
  return(test$experimentSettings$MarkOrder[trialID] + 1)
}
MarkPosition = function(test, MarkIndex, onlyXY = F){
  markPosition = test$positionSettings$MarkPositions[MarkIndex,]
  if (onlyXY){
    return(c(markPosition$Position.x, markPosition$Position.z))
  } else return(markPosition)
}
WasForceFinished = function(test, trialID){
  return(nrow(filter(test$data, Sender == "Trial" & 
                       Index == (trialID - 1) & 
                       Event == "ForceFinished")) > 1)
}
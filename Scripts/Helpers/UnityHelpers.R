GetTrialTimewindow = function(test, trialID){
  #correction for c# indexing
  trialID = trialID - 1
  ls = list()
  ls$WaitingToStart = (filter(test$data, Index == trialID & Sender == "Trial" & Event == "WaitingToStart") %>% select(Time))[[1]]
  ls$start = (filter(test$data, Index == trialID & Sender == "Trial" & Event == "Runing") %>% select(Time))[[1]]
  #selects only hte first element - its because fome of hte old logs had potential two finished tiems 
  #if the experiment or trial was force finished before closed (finished effectively twice)
  ls$finish = (filter(test$data, Index == trialID & Sender == "Trial" & Event == "Finished") %>% select(Time))[[1]][1]
  return(ls)
}
GetTrialDistance = function(positionTable, timeWindow = NULL, test = NULL, trialID = NULL){
  ls = list()
  if(is.null(timeWindow)){
   timeWindow = GetTrialTimewindow(test,trialID)
  }
  if (!is.null(timeWindow)){
    positionTable = positionTable[Time > timeWindow$start & Time < timeWindow$finish,]
    start = head(positionTable,1)$cumulative_distance
    end = tail(positionTable,1)$cumulative_distance
    ls$walkedDistance = end - start
  }
  if(!(is.null(test) || is.null(trialID))){
    goalIndex = GetGoalIndex(test, trialID)
    goalPosition = GoalPosition(test, goalIndex)
    startIndex = StartIndex(test,trialID)
    startPosition = StartPosition(test, startIndex)
    ls$goalStart = dist(rbind(startPosition, goalPosition))[[1]]-test$experimentSettings$GoalSize
  }
  return(ls)
}
SelectPlayerLog = function(playerLog, trialTimewindow){
  #checking for entirety
  log = playerLog[Time > trialTimewindow$start & Time < trialTimewindow$finish]
  #checking log
  return(log)
}
GetGoalIndex = function(test, trialID){
  if(GetTrialType(test, trialID)=="Allo"){
    uncorrectedIndex = test$experimentSettings$MarkOrder[trialID] + test$experimentSettings$AlloMarkRelation + 1 
  } else {
    uncorrectedIndex = test$experimentSettings$StartOrder[trialID] + test$experimentSettings$EgoMarkRelation + 1 
  }
  if(uncorrectedIndex>test$experimentSettings$NumberOfGoals) return(uncorrectedIndex-test$experimentSettings$NumberOfGoals) else return(uncorrectedIndex)
}
GoalPosition = function(test,goalIndex,onlyXY = F){
  goalPosition = test$positionSettings$GoalPositions[goalIndex,]
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
MarkIndex = function(test,trialID){
  return(test$experimentSettings$MarkOrder[trialID] + 1)
}
MarkPosition = function(test,MarkIndex, onlyXY = F){
  markPosition = test$positionSettings$MarkPositions[MarkIndex,]
  if (onlyXY){
    return(c(markPosition$Position.x,markPosition$Position.z))
  } else return(markPosition)
}
GetTrialType = function(test,trialID){
  return(test$experimentSettings$RandomOrdering[trialID])
}
TrialIndexes = function(test, event){
  indexes = unique(filter(test$data, Sender == "Trial" & Event == event) %>% select(Index))[[1]]
  return(indexes+1)
}
WasForceFinished = function(test, trialID){
  return(nrow(filter(test$data, Sender == "Trial" & Index == (trialID-1) & Event == "ForceFinished")) >1)
}
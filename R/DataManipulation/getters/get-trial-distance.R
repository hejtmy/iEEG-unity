get_trial_distance = function(dt_position, timeWindow = NULL, test = NULL, trialID = NULL){
  ls = list()
  if(is.null(timeWindow)){
    timeWindow = get_trial_timewindow(test, trialID)
  }
  if (!is.null(timeWindow)){
    dt_position = dt_position[Time > timeWindow$start & Time < timeWindow$finish, ]
    if (dt_position[, .N] < 2) {
      ls$walkedDistance = as.numeric(NA)
    } else {
      start = head(dt_position,1)$cumulative_distance
      end = tail(dt_position,1)$cumulative_distance
      ls$walkedDistance = end - start
    }
  }
  if(!(is.null(test) || is.null(trialID))){
    goalIndex = GetGoalIndex(test, trialID)
    goalPosition = GoalPosition(test, goalIndex)
    startIndex = StartIndex(test,trialID)
    startPosition = StartPosition(test, startIndex)
    ls$goalStart = dist(rbind(startPosition, goalPosition))[[1]] - test$experimentSettings$GoalSize
  }
  return(ls)
}
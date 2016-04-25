GetTrialTimewindow = function(test, trialID){
  #correction for c# indexing
  trialID = trialID -1
  
  ls = list()
  ls$WaitingToStart = (filter(test$data, Index == trialID & Sender == "Trial" & Event == "WaitingToStart") %>% select(Time))[[1]]
  ls$start = (filter(test$data, Index == trialID & Sender == "Trial" & Event == "Runing") %>% select(Time))[[1]]
  ls$finish = (filter(test$data, Index == trialID & Sender == "Trial" & Event == "Finished") %>% select(Time))[[1]]
  return(ls)
}

SelectPlayerLog = function(playerLog, trialTimewindow){
  #checking for entirety
  log = playerLog[Time > trialTimewindow$start & Time < trialTimewindow$finish]
  #checking log
  return(log)
}
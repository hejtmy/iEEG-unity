get_trial_timewindow = function(test, trialID){
  #correction for c# indexing
  trialID = trialID - 1
  ls = list()
  ls$WaitingToStart = (filter(test$data, Index == trialID & Sender == "Trial" & Event == "WaitingToStart") %>% select(Time))[[1]]
  ls$start = (filter(test$data, Index == trialID & Sender == "Trial" & Event == "Runing") %>% select(Time))[[1]]
  #selects only hte first element - its because fome of hte old logs had potential two finished tiems 
  #if the experiment or trial was force finished before closed (finished effectively twice)
  ls$finish = (filter(test$data, Index == trialID & Sender == "Trial" & Event == "Finished") %>% select(Time))[[1]][1]
  
  #replaces missing values with NAs
  newValues = sapply(ls, function(x) if(length(x)== 0) {x = as.numeric(NA)} else {x = x})
  ls = as.list(newValues)
  return(ls)
}
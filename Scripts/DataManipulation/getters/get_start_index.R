get_start_index = function(test, trialID){
  return(test$experimentSettings$StartOrder[trialID] + 1)
}
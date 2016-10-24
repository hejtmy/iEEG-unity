get_mark_index = function(test, trialID){
  return(test$experimentSettings$MarkOrder[trialID] + 1)
}
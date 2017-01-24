get_goal_index = function(test, trialID){
  if(get_trial_type(test, trialID) == "Allo"){
    uncorrectedIndex = test$experimentSettings$MarkOrder[trialID] + test$experimentSettings$AlloMarkRelation + 1 
  } else {
    uncorrectedIndex = test$experimentSettings$StartOrder[trialID] + test$experimentSettings$EgoMarkRelation + 1 
  }
  if(uncorrectedIndex>test$experimentSettings$NumberOfGoals) return(uncorrectedIndex-test$experimentSettings$NumberOfGoals) else return(uncorrectedIndex)
}
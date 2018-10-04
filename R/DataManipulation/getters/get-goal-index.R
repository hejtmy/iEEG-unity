get_goal_index <- function(obj, trialID){
  exp_settings <- get_experiment_settings(obj)
  if(get_trial_type(obj, trialID) == "Allo"){
    uncorrectedIndex <- exp_settings$MarkOrder[trialID] + exp_settings$AlloMarkRelation + 1 
  } else {
    uncorrectedIndex <- exp_settings$StartOrder[trialID] + exp_settings$EgoMarkRelation + 1 
  }
  if(uncorrectedIndex > exp_settings$NumberOfGoals) return(uncorrectedIndex - exp_settings$NumberOfGoals) else return(uncorrectedIndex)
}
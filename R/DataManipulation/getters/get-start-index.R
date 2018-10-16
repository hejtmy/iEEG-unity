get_start_index <- function(obj, trialID){
  return(get_experiment_settings(obj)$StartOrder[trialID] + 1)
}
get_trial_type <- function(obj, trialId){
  return(get_experiment_settings(obj)$RandomOrdering[trialId])
}
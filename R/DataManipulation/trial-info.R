trial_info <- function(obj, trialId){
  ls <- list()
  ls$duration <- get_trial_duration(obj, trialId)
  ls$distances <- list()
  ls$distances$walkedDistance <- get_trial_distance(obj, trialId)
  ls$distances$goalStart <- get_goal_start_distance(obj, trialId)
  ls$point <- get_trial_pointing(obj, trialId)
  ls$type <- get_trial_type(obj, trialId)
  return(ls)
}
get_trial_info = function(test, trialID, dt_player){
  ls = list()
  times = get_trial_timewindow(test, trialID)
  ls$duration = times$finish - times$start
  ls$distances = get_trial_distance(dt_player, times, test = test, trialID = trialID)
  ls$type = get_trial_type(test, trialID)
  return(ls)
}
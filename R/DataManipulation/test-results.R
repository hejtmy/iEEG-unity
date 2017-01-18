test_results = function(test, dt_player){
  ls = list()
  i_finished_trials = get_trial_event_indices(test, "Finished")
  n_finished_trials = length(i_finished_trials)
  df = data.frame(duration = rep(NA, n_finished_trials), 
                  distances.walkedDistance = rep(NA, n_finished_trials), 
                  distances.goalStart = rep(NA, n_finished_trials), 
                  type = rep("", n_finished_trials),
                  index = rep(NA, n_finished_trials), 
                  stringsAsFactors=FALSE)    
  for (n in i_finished_trials){
    ls = trial_info(test, n, dt_player)
    ls$index = n
    df[n, ] = unlist(ls, recursive = F)
  }
  #transposes and converst the list - normally list unlists horizontaly, we need to transpose ti
  return(df)
}
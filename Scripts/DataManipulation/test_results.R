test_results = function(test, dt_player){
  ls = list()
  i_finished_trials = get_trial_event_indices(test, "Finished")
  for (n in i_finished_trials){
    ls[[n]] = get_trial_info(test, n, dt_player)
    ls[[n]]$index = n
  }
  #transposes and converst the list - normally list unlists horizontaly, we need to transpose ti
  results = as.data.frame(t(rbind(sapply(ls, unlist))))
  return(results)
}
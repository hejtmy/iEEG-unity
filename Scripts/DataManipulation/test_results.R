test_results = function(test, dt_player){
  ls = list()
  i_finished_trials = get_trial_event_indices(test, "Finished")
  for (n in i_finished_trials){
    ls[[i]][[n]] = get_trial_info(test, n, dt_player)
    ls[[i]][[n]]$index = n
  }
  #transposes and converst the list - normally list unlists horizontaly, we need to transpose ti
  testTable = as.data.frame(t(rbind(sapply(ls[[i]], unlist))))
}
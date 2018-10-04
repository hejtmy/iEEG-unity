test_results <- function(obj, dt_player){
  ls <- list()
  i_finished_trials <- get_finished_trials(obj) + 1
  n_finished_trials <- length(i_finished_trials)
  df <- data.frame(duration = rep(NA, n_finished_trials), 
                  distances.walkedDistance = rep(NA, n_finished_trials), 
                  distances.goalStart = rep(NA, n_finished_trials), 
                  point.time = rep(NA, n_finished_trials),
                  point.chosen = rep(NA, n_finished_trials),
                  point.target = rep(NA, n_finished_trials),
                  type = rep("", n_finished_trials),
                  index = rep(NA, n_finished_trials), 
                  stringsAsFactors = FALSE)    
  for (trialId in i_finished_trials){
    ls <- trial_info(obj, trialId)
    ls$index <- trialId
    df[trialId, ] <- unlist(ls, recursive = F)
  }
  #transposes and converst the list - normally list unlists horizontaly, we need to transpose ti
  return(df)
}
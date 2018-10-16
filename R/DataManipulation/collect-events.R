#'
#'
#' @param name: string with the name of the event, e.g. ArduinoPulseStop
#' @param path: where to save the file. Defaults ot hte workig path/exports
collect_events <- function(obj){
  iFinished <- get_finished_trials(obj)
  # remove force finished trials
  forceFinished <- c()
  for(i in iFinished){
    if(was_trial_force_finished(obj, i)) forceFinished <- c(forceFinished, i)
  }
  if(length(forceFinished) > 0) iFinished <- iFinished[-forceFinished]
  
  finishedTrials <- get_experiment_log(obj) %>% filter(Index %in% (iFinished))
  iFinished <- iFinished + 1
  
  synchropulse <- finishedTrials  %>% filter(Sender == "Trial") %>% filter(Event == "ArduinoPulseStart") %>% .$Time
  trialSetup <- finishedTrials %>% filter(Sender == "Trial") %>% filter(Event == "WaitingToStart") %>% .$Time
  trialStarted <- finishedTrials %>% filter(Sender == "Trial") %>% filter(Event == "Running") %>% .$Time
  #I had a mistake in the old logs with running spelled with only a single N
  if (length(trialStarted) == 0) trialStarted <- finishedTrials %>% filter(Sender == "Trial") %>% filter(Event == "Runing") %>% .$Time
  trialEnded <- finishedTrials %>% filter(Sender == "Trial") %>% filter(Event == "Finished") %>% .$Time
  pointingStarted <- trialStarted
  pointingEnded <- c()
  pointingError <- c()
  type <- c()
  for(iTrial in iFinished){
    pointing <- get_trial_pointing(obj, iTrial)
    pointingEnded <- c(pointingEnded, pointing$time)
    pointingError <- c(pointingError, angle_difference(pointing$target, pointing$chosen))
    type <- c(type, get_trial_type(obj, iTrial))
  }
  df <- data.frame(iFinished, trialSetup, trialStarted, trialEnded, pointingStarted, pointingEnded, pointingError, synchropulse, type)
  return(df)
}
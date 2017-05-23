#'
#'
#' @param name: string with the name of the event, e.g. ArduinoPulseStop
#' @param path: where to save the file. Defaults ot hte workig path/exports
collect_events <- function(test, dt_player){
  trialIDs <- get_trial_event_indices(test, "Finished")
  synchropulses <- test$data  %>% filter(Sender == "Trial") %>% filter(Event == "ArduinoPulseStart") %>% .$Time
  trialSetup <- test$data %>% filter(Sender == "Trial") %>% filter(Event == "WaitingToStart") %>% .$Time
  trialStarted <- test$data %>% filter(Sender == "Trial") %>% filter(Event == "ArduinoPulseStart") %>% .$Time
  trialEnded <- test$data %>% filter(Sender == "Trial") %>% filter(Event == "Finished") %>% .$Time
  pointingStarted <- trialStarted
  pointingEnded <- c()
  type <- c()
  for(trialID in trialIDs){
    pointing <- get_trial_pointing(dt_player, test, trialID)
    pointingEnded <- c(pointingEnded, pointing$time)
    type <- c(type, get_trial_type(test, trialID))
  }
  df = data.frame(trialIDs, trialSetup, trialStarted, trialEnded, pointingStarted, pointingEnded, type)
}
get_trial_event_indices = function(test, event){
  indexes = unique(filter(test$data, Sender == "Trial" & Event == event) %>% select(Index))[[1]]
  return(indexes + 1)
}
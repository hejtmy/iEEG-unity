add_player_path = function(plot, test, trialID, dt_position){
  trial_timewindow = GetTrialTimewindow(test,trialID)
  playerLog = SelectPlayerLog(dt_position, trial_timewindow)
  plot = plot + geom_path(data = playerLog, aes(Position.x, Position.z))
  return(plot)
}
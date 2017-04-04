get_trial_pointing <- function(dt_player, test, trialID){
  ls <- list()
  timewindow <- get_trial_timewindow(test, trialID)
  if (!is.null(timewindow)) return(NULL);
  quest_log <- dt_player[Time > timewindow$start & Time < timewindow$finish, ]
  point_situation <- quest_log[Input == "Point", ][1]
  if(!is.na(point_time)) return(NULL)
  ls$time <- point_situation$Time
  ls$chosen <- point_situation$Rotation.X
  ls$target <- NA
  return(ls)
}
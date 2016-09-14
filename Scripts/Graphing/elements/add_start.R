add_start = function(plot, test, trialID){
  i_start = StartIndex(test, trialID)
  start_pos = StartPosition(test, i_start)
  plot = plot + geom_point(data = start_pos, aes(Position.x, Position.z), size = 10, color = "red")
  return(plot)
}
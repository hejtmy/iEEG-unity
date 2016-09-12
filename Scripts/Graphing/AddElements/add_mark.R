add_mark = function(plot, test, trialID){
  i_mark = MarkIndex(test, trialID)
  mark_pos = MarkPosition(test, i_mark)
  plot = plot + geom_point(data = mark_pos, aes(Position.x, Position.z), size = 10, color = "blue")
  return(plot)
}
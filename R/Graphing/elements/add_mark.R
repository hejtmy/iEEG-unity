add_mark = function(plot, test, trialID){
  i_mark = get_mark_index(test, trialID)
  mark_pos = get_mark_position(test, i_mark)
  plot = plot + geom_point(data = mark_pos, aes(Position.x, Position.z), size = 10, color = "blue")
  return(plot)
}
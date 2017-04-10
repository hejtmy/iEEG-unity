svg_add_start = function(plot, test, trialID){
  i_start = get_start_index(test, trialID)
  start_pos = get_start_positsions(test, i_start)
  plot = plot + geom_point(data = start_pos, aes(Position.x, Position.z), size = 10, color = "red")
  return(plot)
}
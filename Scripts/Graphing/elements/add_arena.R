add_arena = function(plot, test){
  round_area = make_circle(c(0,0), test$experimentSettings$MarkRadius, precision = 100)
  plot = plot + geom_path(data = round_area, aes(x, y)) 
  return(plot)
}
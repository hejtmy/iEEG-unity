AddSpecialPaths = function(position_table, ls){
  list_names = names(ls)
  position_table = position_table[, special:= "normal"]
  list_names = names(ls)
  for (i in 1:length(ls)){
    position_table = position_table[is_between(Time,ls[[i]]$start,ls[[i]]$finish), special:= list_names[i] ]
  }
  return(position_table)
}

SavePlot = function(inputPlot,name){
  mypath <- paste("../images/", name, sep = "")
  file = png(mypath, width = 1200, height = 800, units = "px")
  plot(inputPlot)
  dev.off()
}

MakeCircle = function(center = c(0,0), radius = 1, precision = 100){
  tt <- seq(0, 2*pi, length.out = precision)
  xx <- center[1] + radius * cos(tt)
  yy <- center[2] + radius * sin(tt)
  return(data.frame(x = xx, y = yy))
}

AddPointsToPlot = function(plot, ls){
  list_names = names(ls)
  data_table = data.frame(point.x=numeric(0),point.y=numeric(0), point.name=character(), stringsAsFactors = F)
  for (i in 1:length(ls)){
    data_table[i,1] = ls[[i]][1]
    data_table[i,2] = ls[[i]][2]
    data_table[i,3] = list_names[i]
  }
  plot = plot + geom_point(data = data_table, aes(point.x,point.y),size = 4, color = "blue") + geom_text(data = data_table, aes(point.x, point.y,label=point.name))
  return(plot)
}


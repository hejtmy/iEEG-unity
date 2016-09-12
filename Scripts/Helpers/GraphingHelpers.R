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
theme_invisible = function(base_size = 12) {
  structure(list(
    axis.line =         theme_void,
    axis.text.x =       theme_text(colour = NA,size = base_size * 0.8 , lineheight = 0.9, vjust = 1),
    axis.text.y =       theme_text(colour = NA,size = base_size * 0.8, lineheight = 0.9, hjust = 1),
    axis.ticks =        theme_segment(colour = NA, size = 0.2),
    axis.title.x =      theme_text(colour = NA,size = base_size, vjust = 1),
    axis.title.y =      theme_text(colour = NA,size = base_size, angle = 90, vjust = 0.5),
    axis.ticks.length = unit(0.3, "lines"),
    axis.ticks.margin = unit(0.5, "lines"),
    
    legend.background = theme_rect(colour=NA), 
    legend.key =        theme_rect(colour = NA),
    legend.key.size =   unit(1.2, "lines"),
    legend.text =       theme_text(colour = NA,size = base_size * 0.8),
    legend.title =      theme_text(colour = NA,size = base_size * 0.8, face = "bold", hjust = 0),
    legend.position =   "right",
    
    panel.background =  theme_rect(fill = NA, colour = NA), 
    panel.border =      theme_rect(fill = NA, colour=NA), 
    panel.grid.major =  theme_line(colour = NA, size = 0.2),
    panel.grid.minor =  theme_line(colour = NA, size = 0.5),
    panel.margin =      unit(0.25, "lines"),
    
    strip.background =  theme_rect(fill = NA, colour = NA), 
    strip.text.x =      theme_text(colour = NA,size = base_size * 0.8),
    strip.text.y =      theme_text(colour = NA,size = base_size * 0.8, angle = -90),
    
    plot.background =   theme_rect(colour = NA),
    plot.title =        theme_text(colour = NA,size = base_size * 1.2),
    plot.margin =       unit(c(1, 1, 0.5, 0.5), "lines")
  ), class = "options")
}

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot = function(plotlist = NULL, file, cols=1, layout=NULL) {
  
  numPlots = length(plotlist)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plotlist[[1]])
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plotlist[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
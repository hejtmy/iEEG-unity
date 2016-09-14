get_start_positsions = function(test, i_start, onlyXY = F){
  start_pos = test$positionSettings$StartPositions[i_start, ]
  if (onlyXY){
    return(c(start_pos$Position.x,startPosition$Position.z))
  } else return(start_pos)
}
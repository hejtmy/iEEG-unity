get_mark_position = function(test, i_mark, onlyXY = F){
  mark_pos = test$positionSettings$MarkPositions[i_mark, ]
  if (onlyXY){
    return(c(mark_pos$Position.x, mark_pos$Position.z))
  } else return(mark_pos)
}
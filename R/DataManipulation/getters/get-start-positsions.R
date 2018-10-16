get_start_positsions <- function(obj, i_start, onlyXY = F){
  start_pos <- obj$data$experiment_log$positions$StartPositions[i_start, ]
  if (onlyXY){
    return(c(start_pos$Position.x, startPosition$Position.z))
  } else return(start_pos)
}
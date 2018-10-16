#'
#'
#' @param playerLog: data table log as preprocessed by the Analysis fuynction
#' @path path: path to the file. Defaults to workign directory
export_player_log <- function(obj, filename, path = getwd()){
  playerLog <- get_log(obj)
  playerLog$Position <- NULL
  filePath <- paste(path, "/", filename, "_player.log", sep = "")
  colnames(playerLog) <- c("Time", "RotationX", "RotationY", "FPS", "Input", "PositionX", 
                          "PositionY", "PositionZ", "distance", "cummulativeDistance", "angleDiffX", "angleDiffY")
  write.table(playerLog, filePath, sep = ";", quote = F, row.names = F)
}
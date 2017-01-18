save_preprocessed_player = function(directory, pos_tab){
  ptr = paste("_player_", sep = "", collapse = "")
  logs = list.files(directory, pattern = ptr, full.names = T)
  if(length(logs) != 1) stop("More player logs in the saving directory")
  log = logs[1]
  #writes preprocessed file
  preprocessed_filename = gsub(".txt","_preprocessed.txt",log)
  smart_print(c("Saving processed player log as", preprocessed_filename))
  write.table(pos_tab, preprocessed_filename, sep = ";", dec = ".", 
              quote = F, row.names = F)
}
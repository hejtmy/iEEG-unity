export_events <- function(obj, filename){
  df <- collect_events(obj)
  filePath <- paste(getwd(), "/", filename, ".events", sep = "")
  write.table(df, filePath, sep = ";", quote = F, row.names = F)
}

#'
#'
#' @param name: string with the name of the event, e.g. ArduinoPulseStop
#' @param path: where to save the file. Defaults ot hte workig path/exports
export_pulses = function(testData, event_name, id, path = getwd()){
  # VALIDATIONS
  
  pulses = testData %>% filter(Event == event_name) %>% select(Time)
  
  df = data.frame(eventName = rep(event_name, length(pulses)), times = pulses)
  
  filePath = paste(path, "/", id, ".pulses", sep = "")
  write.table(df, filePath, sep = ";", quote = F, row.names = F)
}
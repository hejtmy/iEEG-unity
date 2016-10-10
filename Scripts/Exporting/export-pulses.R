#'
#'
#' @param name: string with the name of the event, e.g. ArduinoPulseStop
#' @param path: where to save the file. Defaults ot hte workig path/exports
export_pulses = function(testData, name, path = getwd()){
  # VALIDATIONS
  
  pulses = testData %>% filter(Event == name) %>% select(Time)
  
  df = data.frame(eventName = rep(name, length(pulses)), times = pulses)
  
  filePath = paste(path, "pulses.events", sep = "/", collapse = "")
  write.table(df, filePath, sep = ";", quote = F, row.names = F)
}
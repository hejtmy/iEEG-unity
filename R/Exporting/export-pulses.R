#'
#'
#' @param name: string with the name of the event, e.g. ArduinoPulseStop
#' @param path: where to save the file. Defaults ot hte workig path/exports
export_pulses <- function(obj, event_names, filename, path = getwd()){
  # VALIDATIONS
  
  exp_data <- get_experiment_log(obj)
  pulses <- exp_data %>% filter(Event %in% event_names) %>% select(Event, Time)
  colnames(pulses) <- c("eventName", "times")
  filePath <- paste(path, "/", filename, ".pulses", sep = "")
  write.table(pulses, filePath, sep = ";", quote = F, row.names = F)
}
#give me folder
source("R/Loading.R")
library(brainvr.R)
data_dir <- "../Data/p142"

obj <- load_experiment(data_dir)
obj$data$player_log <- preprocess_player_log(obj$data$player_log)
save_preprocessed_player(data_dir, obj$data$player_log, obj$timestamp)



Analysis$TestResults()

Analysis$ExportSynchropulses()
Analysis$ExportPlayerLog()
Analysis$ExportEvents()
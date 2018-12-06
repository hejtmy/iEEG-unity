#give me folder
source("R/Loading.R")
library(brainvr.R)

PARTICIPANT_CODE <- "p181"
data_dir <- paste0("../Data/", PARTICIPANT_CODE, '')

obj <- load_experiment(data_dir, exp_timestamp = "19-06-41-04-06-2018")
obj$data$player_log <- preprocess_player_log(obj$data$player_log)
save_preprocessed_player(data_dir, obj$data$player_log, obj$timestamp)

trial_info(obj, 1)
test_results(obj)

export_pulses(obj, event_names = c("ArduinoPulseStart", "ArduinoPulseStop"), PARTICIPANT_CODE)
export_player_log(obj, PARTICIPANT_CODE)
export_events(obj, PARTICIPANT_CODE)

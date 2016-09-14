#give me folder
source("Scripts/Loading.R")

data_dir = "../Data"

Analysis = UnityAnalysis$new(data_dir, "P108")
Analysis$TestResults()

make_trial_images(Analysis$playerLog, Analysis$tests[[1]], indices = c(2:3))

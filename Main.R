#give me folder
source("Scripts/Loading.R")

dataDirectory = "../Data"

Analysis = UnityAnalysis$new(dataDirectory, "P108")
Analysis$TestResults()

make_trial_images(Analysis$playerLog, Analysis$tests[[1]], indices = c(2:3))

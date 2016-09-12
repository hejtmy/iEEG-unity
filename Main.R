#give me folder
source("Scripts/Loading.R")

dataDirectory = "../Data"

Analysis = UnityAnalysis$new(dataDirectory, "final")
Analysis$TestTable()


MakeTrialImages(Analysis$playerLog, Analysis$tests[[1]], indexes = c(2:3))
MakeAllTrialImages(Analysis$playerLog, Analysis$tests[[1]])


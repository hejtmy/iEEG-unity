#give me folder
source("Scripts/Loading.R")

dataDirectory = "../Data"

Analysis = UnityAnalysis$new(dataDirectory, "final")
Analysis$TestTable()

MakeAllTrialImages(Analysis$playerLog,Analysis$tests[[1]], 8)

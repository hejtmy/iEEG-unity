#give me folder
source("Scripts/Loading.R")

dataDirectory = "../Data"

Analysis = UnityAnalysis$new(participant, sessionId)

Analysis = UnityAnalysis$new(dataDirectory, "23", 1)

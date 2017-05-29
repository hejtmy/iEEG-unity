#give me folder
source("R/Loading.R")

data_dir = "../Data"

Analysis = UnityAnalysis$new(data_dir, "ek_0102")
Analysis$TestResults()

Analysis$ExportSynchropulses()
Analysis$ExportPlayerLog()
Analysis$ExportEvents()

#give me folder
source("Scripts/Loading.R")

dataDir = "../Data"

Analysis = UnityAnalysis$new(dataDir, "p108")
Analysis$TestResults()

make_trial_images(Analysis$playerLog, Analysis$tests[[1]], indices = c(2:3))

Analysis$playerLog$timeDiff = c(0, diff(Analysis$playerLog$Time))
ggplot(Analysis$playerLog, aes(x = Time, y = distance/timeDiff)) + geom_line()

hist(Analysis$playerLog$timeDiff)
summary(Analysis$playerLog$timeDiff)
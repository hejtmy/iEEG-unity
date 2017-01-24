#give me folder
source("R/Loading.R")

data_dir = "../Data"

Analysis = UnityAnalysis$new(data_dir, "ek0117")
Analysis$TestResults()

make_trial_images(Analysis$playerLog, Analysis$tests[[1]], indices = c(2:3))

Analysis$playerLog$timeDiff = c(0, diff(Analysis$playerLog$Time))
ggplot(Analysis$playerLog, aes(x = Time, y = distance/timeDiff)) + geom_line()

hist(Analysis$playerLog$timeDiff)
summary(Analysis$playerLog$timeDiff)

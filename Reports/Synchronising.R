source("Scripts/Loading.R")

dataDir = "../Data"

Analysis = UnityAnalysis$new(dataDir, "p108")

testData = Analysis$tests[[1]]$data
stopPulses = testData %>% filter(Event == "ArduinoPulseStop") %>% select(Time)
diff(stopPulses$Time)
startPulses = testData %>% filter(Event == "ArduinoPulseStart") %>% select(Time)

# imported from matlab pulses
matDiff = c(25.1560,19.6520,21.5080,38.8240,14.7720,38.6440,16.0640,61.8440,15.5880,17.1440,
            14.2200,11.2360,16.0480,21.5160,14.5800,13.0840,26.2280,21.1880,14.7520,15.0360,13.4880,16.1720,17.1280,
            15.3640,20.4920,18.0600,22.5800,16.1320,16.0440,12.5760,19.0920,12.4440,12.4320,14.8000,14.4520,14.8680,
            13.6120,13.3360,15.3680,27.8920,13.5240,20.8440,11.3480,16.3120,17.1040,15.6880,12.2000,14.9640)

diffs = data.frame(difference = (matDiff - diff(stopPulses$Time)) * 1000, index = 1:48)

diffPlot = ggplot(diffs, aes(index, difference)) + geom_point() + ylab("Difference in ms") + 
  xlab("Index of comparison")
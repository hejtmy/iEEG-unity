OpenExperimentLog = function(filepath){
  ls = list()
  #reads into a text file at first
  text = readLines(filepath,warn=F)
  ls$header = GetJsonBetween(text,"SESSION HEADER")
  ls$Experiment = GetJsonBetween(text,"EXPERIMENT INFO")
  return(ls)     
}
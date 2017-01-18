open_experiment_log = function(filepath){
  ls = list()
  #reads into a text file at first
  text = readLines(filepath, warn = F)
  ls$header = get_json_between(text,"SESSION HEADER")
  ls$Experiment = get_json_between(text,"EXPERIMENT INFO")
  return(ls)     
}
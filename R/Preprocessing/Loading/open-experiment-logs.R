open_experiment_logs = function(directory = ""){
  ls = list()
  logs = list.files(directory, pattern = "_ExperimentInfo_", full.names = T)
  if(length(logs) < 1){
    print("Could not find the file for experiment log")
    return(NULL)
  }
  for(i in 1:length(logs)){
    ls[[i]] = open_experiment_log(logs[i])
    ls[[i]]$filename = logs[i]
  }
  if (length(ls) == 1) ls = ls[[1]]
  return(ls)
}
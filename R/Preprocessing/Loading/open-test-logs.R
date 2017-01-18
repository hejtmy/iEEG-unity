open_test_logs = function(directory){
  ls = list()
  logs = list.files(directory, pattern = "_test_", full.names = T)
  if(length(logs) < 1){
    smart_print(c("Could not find any test logs in ", directory))
    next
  }
  for(i in 1: length(logs)){
    log = logs[i]
    ls[[i]] = open_test_log(log)
  }
  return(ls)
}
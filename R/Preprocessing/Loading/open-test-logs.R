OpenTestLogs = function(directory){
  ls = list()
  logs = list.files(directory, pattern = "_test_", full.names = T)
  if(length(logs)<1){
    SmartPrint(c("Could not find any test logs in ", directory))
    next
  }
  for(i in 1: length(logs)){
    log = logs[i]
    ls[[i]] = OpenTestLog(log)
  }
  return(ls)
}
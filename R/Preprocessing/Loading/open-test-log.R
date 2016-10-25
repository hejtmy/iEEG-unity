OpenTestLog = function(filepath){
  ls = list()
  #reads into a text file at first
  
  text = readLines(filepath,warn=F)
  #needs to be before resaving text
  bottomHeaderIndex = GetIndexesBetween(text, "TEST HEADER")$end
  
  text = GetTextBetween(text,"TEST HEADER")
  ls$experimentSettings = GetJsonBetween(text, "EXPERIMENT SETTINGS")
  ls$positionSettings = GetJsonBetween(text, "POSITIONS")
  
  ls$positionSettings = CovertPositionsToVectors(ls$positionSettings)
  
  ls$data  = read.table(filepath, header=T, sep=";",stringsAsFactors=F,skip = bottomHeaderIndex)
  ls$data[ncol(ls$data)] = NULL
  return(ls)
}
GetIndexesBetween = function(text, string){
  ls = list()
  ls$beginning = which(grepl(CreateSeparator(string)$beginning, text))
  ls$end = which(grepl(CreateSeparator(string)$end, text))
  return(ls)
}
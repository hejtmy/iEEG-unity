GetTextBetween = function(text, string){
  indexes = GetIndexesBetween(text, string)
  if (length(indexes$beginning) != 1 || length(indexes$end) !=1) return (NULL)
  text = text[(indexes$beginning+1):(indexes$end-1)]
  return(text)
}
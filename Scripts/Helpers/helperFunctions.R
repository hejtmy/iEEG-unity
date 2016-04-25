source_folder = function(path){
  sapply(list.files(pattern="[.]R$", path=path, full.names=TRUE), source);
}

is_between = function(numbers, between_low, between_high){
  return(sapply(numbers, function(x) (x > between_low && x < between_high)))
}

EuclidDistanceColumns = function(x_values,y_values){
  x = c(x_values[[1]][1],y_values[[1]][1])
  y = c(x_values[[1]][2],y_values[[1]][2])
  return(sqrt(sum((x-y)^2)))
}

ColumnPresent = function(names,name){
  return(name %in% names)
}

SmartPrint = function(characters){
  print(paste(characters, sep="", collapse = " "))
}

Present = function(){
  return(TRUE)
}
#turns vector columns in string "(x, y, z)" into three columns(Position.x, Position.y, Position.z) and returns the table
vector3ToColumns <- function(tab, column_name){
  xyz <- c("x","y","z")
  splitted <- strsplit(substring(tab[,get(column_name)],2,nchar(tab[,get(column_name)])-1),",")
  #turns the Vector3 into lists of 3 values
  i = 1
  for (letter in xyz){
    new_name <- paste(column_name,letter,sep=".")
    tab[,(new_name):=as.numeric(sapply(splitted,"[",i))]
    i<-i+1
  }
  return(tab)
}
textToVector3 = function(text){
  splitted = strsplit(substring(text,2,nchar(text)-1),",")
  if(length(splitted[[1]])>2) return(sapply(splitted[[1]], as.numeric, warning = F, USE.NAMES = F))
  return(NULL)
}
##Helper for escaping characters in quest names
escapeRegex <- function(string){
  return(gsub("([.|()\\^{}+$*?]|\\[|\\])", "\\\\\\1", string))
}
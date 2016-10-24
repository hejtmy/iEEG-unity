#pure helpers for my particular unity logging 
CreateSeparator = function(string){
  ls = list()
  ls$beginning = paste("\\*\\*\\*\\",string,"\\*\\*\\*", sep="")
  ls$end = paste("\\-\\-\\-",string,"\\-\\-\\-", sep="")
  return(ls)
}

GetIndexesBetween=function(text,string){
  ls=list()
  ls$beginning = which(grepl(CreateSeparator(string)$beginning,text))
  ls$end = which(grepl(CreateSeparator(string)$end,text))
  return(ls)
}

GetTextBetween=function(text, string){
  indexes = GetIndexesBetween(text, string)
  if (length(indexes$beginning) != 1 || length(indexes$end) !=1) return (NULL)
  text = text[(indexes$beginning+1):(indexes$end-1)]
  return(text)
}

GetJsonBetween = function(text, string){
  ls = TextToJSON(GetTextBetween(text,string))
  return(ls)
}

TextToJSON = function(text){
  #JSON checking
  ls = fromJSON(text)
  return(ls)
}

OpenExperimentLogs = function(directory = ""){
  ls = list()
  logs = list.files(directory, pattern = "_ExperimentInfo_",full.names = T)
  if(length(logs) < 1){
    print("Could not find the file for experiment log")
    return(NULL)
  }
  for(i in 1:length(logs)){
    ls[[i]] = OpenExperimentLog(logs[i])
    ls[[i]]$filename = logs[i]
  }
  if (length(ls) == 1) ls = ls[[1]]
  return(ls)
}
OpenExperimentLog = function(filepath){
  ls = list()
  #reads into a text file at first
  text = readLines(filepath,warn=F)
  ls$header = GetJsonBetween(text,"SESSION HEADER")
  ls$Experiment = GetJsonBetween(text,"EXPERIMENT INFO")
  return(ls)     
}
OpenPlayerLog = function(directory, override = F){
  ptr = "_player_"
  logs = list.files(directory, pattern = ptr, full.names = T)
  if(length(logs) < 1){
    SmartPrint(c("Could not find the file for player log in ", directory))
    return(NULL)
  }
  log_columns_types = c(Time="numeric", Position = "numeric", Rotation.X = "numeric", Rotation.Y="numeric", 
                        FPS = "numeric", Input = "character")
  preprocessed_log_column_types = c(log_columns_types, Position.x = "numeric", Position.y = "numeric", Position.z = "numeric", 
                                    distance = "numeric", cumulative_distance = "numeric", angle_diff = "numeric")
  if (length(logs)>1){
    #check if there is a preprocessed player file
    preprocessed_index = grep("*_preprocessed",logs)
    if(length(preprocessed_index) > 0){
      if(override){
        SmartPrint(c("Removing preprocessed log", ptr))
        file.remove(logs[preprocessed_index])
      } else {
        SmartPrint(c("Loading preprocessed player log", ptr))
        log = logs[preprocessed_index]
        return(fread(log, header=T, sep=";",dec=".", stringsAsFactors = F, colClasses = preprocessed_log_column_types))
      }
    } else{
      print("There is more player logs with appropriate timestamp in the same folder. Have you named and stored everything appropriately?")
      return(NULL)
    }
  } else {
    if(length(logs) > 1){
      SmartPrint(c("Multiple player logs in ", directory))
      return(NULL)
    } 
    log = logs[1]
  }
  SmartPrint(c("Loading unprocessed player log", ptr))
  #reads into a text file at first
  text = readLines(log, warn = F)
  
  bottomHeaderIndex = GetIndexesBetween(text, "SESSION HEADER")$end
  #reads the data without the header file
  pos_tab <- fread(log, header=T, sep=";", dec=".", skip=bottomHeaderIndex, stringsAsFactors=F, colClasses = log_columns_types)
  #deletes the last column - it's there for the easier logging from unity 
  # - its here because of how preprocessing works
  pos_tab[,ncol(pos_tab):=NULL]
  
  return(pos_tab)
}
SavePreprocessedPlayer = function(directory, pos_tab){
  ptr = paste("_player_", sep="", collapse="")
  logs = list.files(directory, pattern = ptr ,full.names = T)
  if(length(logs)!=1) stop("More player logs in the saving directory")
  log = logs[1]
  #writes preprocessed file
  preprocessed_filename = gsub(".txt","_preprocessed.txt",log)
  SmartPrint(c("Saving processed player log as", preprocessed_filename))
  write.table(pos_tab, preprocessed_filename, sep=";", dec=".", quote=F, row.names = F)
}
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
CovertPositionsToVectors = function(list){
  listNames = names(list)
  for(name in listNames){
    ls = list[[name]]
    numberOfItems = length(ls)
    df = data.frame(Position.x = numeric(numberOfItems),Position.y = numeric(numberOfItems),Position.z = numeric(numberOfItems))
    for (i in 1:length(ls)){
      stringVector = ls[i]
      df[i,] = textToVector3(stringVector)
    }
    list[[name]] = df
  }
  return(list)
}
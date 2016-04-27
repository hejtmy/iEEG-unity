UnityAnalysis <- R6Class("UnityAnalysis",
  inherit = BaseAnalysis,
 
  #define variables
  public = list(
    #basic definitions
    session = NULL,
    sessionDirectory = NULL,
    playerLog = NULL,
    initialize = function(dir, id, session=NULL){
      self$SetParticipant(id)
      private$setDataDirectory(dir)
      self$SetSession(session)
      #TODO - check the data
      if(nargs() >= 2) {
        self$ReadData()
      }
    },
    #define what is valid in the current context
    SetSession = function(session){
      self$session = if(is.null(session)) NULL else paste("Session",session,sep="")
      return(private$setSessionDirectory())
    },
    DrawTrialImage = function(trialID){
      plot = MakeTrialImage(self$playerLog, self$tests[[1]], trialID)
    },
    QuestTable = function(force = F){
      if (!is.null(private$questTable) & !force) return(private$questTable)
      for(i in 1:length(self$tests)){
        test = tests[[i]]
        finishedTrialIndexes = TrialIndexes(test, "Finished")
        for (n in finishedTrialIndexes){
          times = GetTrialTimewindow(test, trialID)
        }
      }
    }
  ),
  private = list(
    #fields
    questTable = NULL,
    isValid = function(){
      return(TRUE)
    },
    setSessionDirectory = function(){
      if(is.null(self$dataDirectory)) private$setDataDirectory()
      self$sessionDirectory = paste(self$dataDirectory,self$session,sep="/")
      return(self$sessionDirectory)
    },
    readData = function(override = F, save = T){
      #checks for path
      if (is.null(self$sessionDirectory)) stop("no session directory set")
      #open experiment_logs to see how many do we have
      experimentLog = OpenExperimentLogs(self$sessionDirectory)
      
      if(is.null(experimentLog)) stop("Experiment log not found")
      #if multiple logs, quit
      self$playerLog = OpenPlayerLog(self$sessionDirectory, override = override)
      
      if(is.null(self$playerLog)) stop("Player log not found")
      #preprocesses player log
      #checks if there is everything we need and if not, recomputes the stuff
      changed = private$preprocessPlayerLog()
      if (changed & save) SavePreprocessedPlayer(self$sessionDirectory,self$playerLog)
        
      testLogs = OpenTestLogs(self$sessionDirectory)
      for (i in length(testLogs)){
        self$tests[[i]] = testLogs[[i]]
      }
     
      private$isValid()
      #checks if multiple sessions
      #asks for session
      #loads experiment log
      #loads player log
      #logs all quest logs
    },
    preprocessPlayerLog = function(){
      #check_stuff
      #check columns
      changed = F
      if (!ColumnPresent(colnames(self$playerLog),"Position.x")){
        self$playerLog = vector3_to_columns(self$playerLog,"Position")
        changed = T
      }
      if (!ColumnPresent(colnames(self$playerLog),"cumulative_distance")){
        self$playerLog = AddDistanceWalked (self$playerLog)
        changed = T
      } 
      if (changed) print("Log modified") else print("Log ok")
      return(changed)
    }
  )
)

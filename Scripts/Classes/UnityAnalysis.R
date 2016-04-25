UnityAnalysis <- R6Class("UnityAnalysis",
  inherit = BaseAnalysis,
 
  #define variables
  public = list(
    #basic definitions
    session = NULL,
    sessionDirectory = NULL,
    initialize = function(dir, id, session=NULL){
      self$SetParticipant(id)
      private$setDataDirectory(dir)
      self$SetSession(session)
      #TODO - check the data
      if(nargs() >= 3) {
        self$ReadData()
      }
    },
    #define what is valid in the current context
    SetSession = function(number){
      self$session = paste("Session",number,sep="")
      return(private$setSessionDirectory())
    }
  ),
  private = list(
    setSessionDirectory = function(){
      if(is.null(self$dataDirectory)) private$setDataDirectory()
      self$sessionDirectory = paste(self$dataDirectory,self$session,sep="/")
      return(self$sessionDirectory)
    },
    readData = function(){
      #checks for path
      if (is.null(self$sessionDirectory)) stop("no session directory set")
      #open experiment_logs to see how many do we have
      experimentLog = OpenExperimentLogs(self$sessionDirectory)
      
      #if multiple logs, quit
      playerLog = OpenPlayerLog(experimentLog, override)
      
      if(is.null(playerLog)) stop("Player log not found")
      #preprocesses player log
      #checks if there is everything we need and if not, recomputes the stuff
      changed = PreprocessPlayerLog(playerLog)
      if (changed & save) SavePreprocessedPlayer(experimentLog, playerLog)
      
      questLogs = OpenQuestLogs()
      for (i in length(questLogs)){
        self$tasks[[i]] = questLogs[[i]]
      }
      self$questSet = MakeQuestTable(self$tasks)
     
      private$isValid()
      #checks if multiple sessions
      #asks for session
      #loads experiment log
      #loads player log
      #logs all quest logs
    }
  )
)

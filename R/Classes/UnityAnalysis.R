UnityAnalysis <- R6Class("UnityAnalysis",
  inherit = BaseAnalysis,
 
  #define variables
  public = list(
    #basic definitions
    session = NULL,
    sessionDirectory = NULL,
    playerLog = NULL,
    initialize = function(dir, id, session = NULL, override = F){
      self$SetParticipant(id)
      private$setDataDirectory(dir)
      self$SetSession(session)
      #TODO - check the data
      if(nargs() >= 2) {
        self$ReadData(override)
      }
    },
    #define what is valid in the current context
    SetSession = function(session){
      self$session = if(is.null(session)) NULL else paste("Session",session,sep="")
      return(private$setSessionDirectory())
    },
    DrawTrialImage = function(trialID){
      plot = MakeTrialImage(self$playerLog, self$tests[[1]], trialID)
      plot
      return(plot)
    },
    TrialInfo = function(trialID){
      ls = list()
      test = self$tests[[1]]
      ls = get_trial_info(test, trialID, self$playerLog)
      
      return(ls)
    },
    TestResults = function(force = F){
      if (!is.null(private$testTable) & !force) return(private$testTable)
      ls = list() 
      test = self$tests[[1]]
      df_test = test_results(test, self$playerLog)
      return(df_test)
    }
  ),
  private = list(
    #fields
    testTable = NULL,
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
      if (!ColumnPresent(self$playerLog, "Position.x")){
        self$playerLog = vector3_to_columns(self$playerLog, "Position")
        changed = T
      }
      if (!ColumnPresent(self$playerLog, "cumulative_distance")){
        self$playerLog = AddDistanceWalked (self$playerLog)
        changed = T
      }
      if (!ColumnPresent(self$playerLog, "angle_diff")){
        self$playerLog = AddAngleDifference(self$playerLog)
        changed = T
      }
      if (changed) print("Log modified") else print("Log ok")
      return(changed)
    }
  )
)

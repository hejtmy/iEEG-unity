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
     
     #checks if multiple sessions
     #asks for session
     #loads experiment log
     #loads player log
     #logs all quest logs
   }
 )
)

UnityAnalysis <- R6Class("UnityAnalysis",
 inherit = BaseAnalysis,
 #define variables
 public = list(
   #basic definitions
   session = NULL,
   initialize = function(dir, id, session=NULL){
     self$dir = dir
     self$SetParticipant(id)
     self$SetSession(session)
     #TODO - check the data
     if(nargs() >= 3) {
       self$ReadData()
     }
   },
   #define what is valid in the current context
   SetSession = function(number=1){
     self$session = paste("Session",number,sep="")
   }
 ),
 private = list(
   setDataDirectory = function(){
     self$data_directory <- paste(self$dir,self$id,"VR",self$session,sep="/")
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

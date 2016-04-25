BaseAnalysis <- R6Class("BaseAnalysis",
  #define variables
  public = list(
  #basic definitions
  participant = NULL,
  initialize = function(dir, id){
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
  },
  SetParticipant = function(string){
    self$participant = string
  },
  ReadData = function(){
    readData()
  }
  ),
  private = list(
    setDataDirectory = function(){
     self$data_directory <- paste(self$dir,self$id,"VR",self$session,sep="/")
    },
    readData = function(){
      
    }
  )
)

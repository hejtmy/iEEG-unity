library(svgR)
svg_make_trial_image = function (dt_position, test, trialID){
  svg_image = NULL
  SIZE = c(200, 200)
  transform = list(translate = c(25, 25), scale = c(1, 1))
  svgR(wh = SIZE,
       g(
         transform = list(translate = c(SIZE/2), scale = c(3, 3)),
         svg_add_arena(test),
         svg_add_goal(test, trialID),
         svg_add_mark(test, trialID),
         svg_add_player_path(test, trialID, dt_position)
       )
  )
  
  #draws start point
  plot = add_start(plot, test, trialID)
  
  #draws mark 
  if(get_trial_type(test, trialID) == "Allo") plot = add_mark(plot, test, trialID)
  
  #plot goal
  plot = add_goal(plot, test, trialID)
  
  #plots player
  plot = add_player_path(plot, test, trialID, dt_position)
  
  return(plot)
}
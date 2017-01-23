library(svgR)
svg_make_trial_image = function (dt_position, test, trialID){
  svg_image = NULL
  SIZE = c(180, 180)
  transform = list(translate = c(0, 10), scale = c(1, 1))
  svgR(wh = SIZE,
    svg(id = "elements",
      svg_add_arena(SIZE, plot, test, transform),
      svg_add_goal(SIZE, plot, test, trialID, transform)
      ),
    svg(use(xlink.href = paste0("#", "elements")))
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
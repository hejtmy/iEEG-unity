make_trial_image = function (dt_position, test, trialID, special_paths = NULL, special_points = NULL){
  plot = ggplot() + theme_void()
  
  #draws round arena
  plot = add_arena(plot, test)
  
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
add_angle_difference = function(player_log){
  
  player_log[, angle_diff:= c(0, diff(Rotation.X))]
  player_log[, angle_diff := convert_angle(angle_diff)]
  return(player_log)
  
}
convert_angle = function(difference){
  return(((difference + 180) %% 360) - 180)
} 
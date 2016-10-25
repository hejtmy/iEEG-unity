preprocess_player_log = function(player_log){
  changed = F
  if (!is_column_present(player_log, "Position.x")){
    playerLog = vector3_to_columns(player_log, "Position")
    changed = T
  }
  if (!is_column_present(player_log, "cumulative_distance")){
    playerLog = add_distance_moved (player_log)
    changed = T
  }
  if (!is_column_present(player_log, "angle_diff")){
    player_log = add_angle_difference(player_log)
    changed = T
  }
  if (changed) print("Log modified") else print("Log ok")
  return(changed) 
}
#calculates the distance walked between each two points of the position table and returns the table
AddDistanceWalked = function(position_table){
  distances = numeric(0)
  for (i in 2:nrow(position_table)){
    position_table[c(i - 1, i), distance := EuclidDistanceColumns(.(Position.x,Position.z)[1], .(Position.x,Position.z)[2])]
  }
  position_table[, cumulative_distance:=cumsum(distance)]
  return(position_table)
}
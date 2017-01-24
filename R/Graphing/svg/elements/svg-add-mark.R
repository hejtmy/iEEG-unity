svg_add_mark %<c-% function(test, trialID, ...){
  attrs = list(...)
  
  LENGTH_ANGLE = 15/180
  
  i_mark = get_mark_index(test, trialID) + 1
  #needs to rewrite because radians start at 0 degrees, whereas mark counting at 270 - need to shif it 9 degrees (test$experimentSettings$NumberOfGoals/4)
  # the -1 is there because get_mark_index returns R indexing (0 becomes 1, and we need to get rid of it)
  mark_angle = (2 * pi/test$experimentSettings$NumberOfGoals) * (i_mark - 1 + test$experimentSettings$NumberOfGoals/4) 
  point1 = angle_coordinate_circle(mark_angle - LENGTH_ANGLE, test$experimentSettings$StartRadius + 2)
  point2 = angle_coordinate_circle(mark_angle + LENGTH_ANGLE, test$experimentSettings$StartRadius + 2)
  g(
    id = "mark",
    attrs, 
    line(xy1 = round(point1, 2), xy2 = round(point2, 2), stroke = 'blue')
  )
}
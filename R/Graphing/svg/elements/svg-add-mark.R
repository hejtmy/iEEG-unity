svg_add_mark %<c-% function(test, trialID, ...){
  attrs = list(...)
  
  LENGTH_ANGLE = 15/180
  
  i_mark = get_mark_index(test, trialID) + 1
  mark_angle = (2 * pi/test$experimentSettings$NumberOfGoals) * i_mark
  mark_pos = get_mark_position(test, i_mark, onlyXY = T)
  point1 = angle_coordinate_circle(mark_angle - LENGTH_ANGLE, test$experimentSettings$StartRadius + 2)
  point2 = angle_coordinate_circle(mark_angle + LENGTH_ANGLE, test$experimentSettings$StartRadius + 2)
  g(
    id = "mark",
    attrs, 
    line(xy1 = round(point1, 2), xy2 = round(point2, 2), stroke = 'blue')
  )
}
svg_add_goal %<c-% function(SIZE, plot, test, trialID, ...){
  attrs = list(...)
  i_goal = get_goal_index(test, trialID)
  goal_pos = get_goal_position(test, i_goal, onlyXY = T)
  g(id = "goal",
    attrs,
    #precise dot
    circle(cxy = goal_pos, r = 5, fill = "red"),
    #round area
    circle(cxy = goal_pos, r = test$experimentSettings$GoalSize, stroke = "red")
    )
}
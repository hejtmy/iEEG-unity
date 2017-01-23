svg_add_arena %<c-% function(SIZE, plot, test, ...){
  center = (SIZE + test$experimentSettings$MarkRadius)/2
  attrs = list(...)
  g(
    attrs,
    id = "arena",
    circle(cxy = center, r = test$experimentSettings$MarkRadius, fill = 'none', stroke = "black")
  )
}
svg_add_arena %<c-% function(test, ...){
  attrs = list(...)
  print(attrs)
  g(
    id = "arena",
    attrs,
    circle(cxy = c(0,0), r = test$experimentSettings$MarkRadius, fill = 'none', stroke = "black")
  )
}
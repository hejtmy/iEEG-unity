make_trial_images = function(dt_position, test, columns = 5, indexes = c()){
  indexes = if (length(indexes)==0) TrialIndexes(test, "Finished") else indexes
  plots = list()
  for(i in indexes){
    plots[[i]] = make_trial_image(dt_position, test, i)
  }
  multiplot(plots, cols = columns)
}
svg_make_trial_images = function(dt_position, test, indices = c()){
  indices = if (length(indices) == 0) get_trial_event_indices(test, "Finished") else indices
  svgR(wh = c(500, 500),
     ls = list(),
     for (i in 1:length(indices)){
       transform = list(translate = c(10,10))
       ls[[i]] = g(class = "trial",
          svg_make_trial_image(dt_position, test, trialID, transform = transform)
       )
     }
     unlist(ls)
  )
}
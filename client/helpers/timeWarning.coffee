UI.registerHelper "timeWarning", (time, threshold) ->
  if moment?
    now = moment()
    if now.diff(time, 'minutes') > threshold
      "too-old"

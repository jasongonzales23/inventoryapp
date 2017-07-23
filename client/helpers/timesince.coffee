UI.registerHelper "timesince", (datetime) ->
  if moment? and datetime
    moment(datetime).fromNow()
  else
    return "NA"

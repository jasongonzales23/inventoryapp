UI.registerHelper "timesince", (datetime) ->
  if moment?
    moment(datetime).fromNow()

UI.registerHelper "timesince", (datetime) ->
  if moment?
    moment(datetime).fromNow()
   
UI.registerHelper "indicateLow", (units, orderWhen) ->
  if units < orderWhen
    "low"

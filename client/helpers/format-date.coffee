DateFormats = {
  short: "DD MMMM - YYYY",
  long: "MMM Do YYYY, h:mm a"
}

UI.registerHelper "formatDate", (datetime, format) ->
  if moment?
    f = DateFormats[format]
    moment(datetime).format(f)
  else
    datetime

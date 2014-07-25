UI.registerHelper "highlightNav", (href) ->
  pathName = Session.get 'locationPathname'
  if pathName == "/report#{href}"
    "active"

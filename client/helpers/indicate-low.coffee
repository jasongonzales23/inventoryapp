UI.registerHelper "indicateLow", (units, orderWhen) ->
  pUnits = parseFloat units
  pOrderWhen = parseFloat orderWhen
  if pUnits < pOrderWhen
    "low"

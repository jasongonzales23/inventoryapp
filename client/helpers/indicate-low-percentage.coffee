UI.registerHelper "indicateLowPercent", (percent, threshold) ->
  return percent < threshold && "low"

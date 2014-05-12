Template.latestOrders.orders = ->
  Orders.find({}, {sort: {timestamp: -1}})


Template.deliveredStatus.deliveredStatus = ->
  if @delivered then "true" else "false"

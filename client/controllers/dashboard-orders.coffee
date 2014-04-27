Template.dashboardOrders.undeliveredOrders = ->
  undeliveredOrders = Orders.find({'beverages.delivered': false}, {
    transform: (order) ->
      order.unfilledOrders = 0
      _.each order.beverages, (bev) ->
        if not bev.delivered
          order.unfilledOrders += 1
      order
  })

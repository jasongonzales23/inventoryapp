Template.dashboardOrders.undeliveredOrders = ->
  orders = Orders.find( {'beverages.delivered': false},
    sort:
      timestamp: 1
  )

  locations = {}
  orders.forEach (doc) ->
    unless locations[doc.location]?
      if not doc.vendor
        locations[doc.location] =
          unfilledOrders: []
          unfilledOrdersCount: 0
          location: doc.location
          locationName: doc.locationName
          locationNumber: doc.locationNumber
          oldestOrder: null

    if not doc.vendor
      locations[doc.location].unfilledOrders.push doc
      locations[doc.location].unfilledOrdersCount++

      if locations[doc.location].unfilledOrders.length > 0
        locations[doc.location].oldestOrder = _.min(locations[doc.location].unfilledOrders,
            (order) ->
              order.timestamp
          )

  return _.values(locations)


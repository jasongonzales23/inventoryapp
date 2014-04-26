Template.dashboardOrders.undeliveredOrders = ->
  Meteor.call('undeliveredOrders')
  ###
  locations = Orders.find({}, {fields: {location: 1}}).map(
    (location) -> location.location
  )

  oldestOrders = _.uniq(locations).map(
    (location) ->
      Orders.findOne({location:location}, {sort: {timestamp: 1}})
  )
  ###

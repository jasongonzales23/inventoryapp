Meteor.methods({
  undeliveredOrders: ->
    [
      {locationName: 'name'},
      {locationName: 'name'},
      {locationName: 'name'},
      {locationName: 'name'}
    ]
})
###
    Orders.find().group(
      key: { locationName, timestamp}
      #cond: { beverages.$.delivered: { $eq: false }}
      reduce: (curr, result) ->
        result.count ++
    )
###

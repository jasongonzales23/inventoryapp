Template.showTokenDeliveries.deliveries = ->
  TokenDeliveries.find({ 'location': @_id}, {sort: {timestamp: -1}})


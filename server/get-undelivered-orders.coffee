Meteor.methods({
  undeliveredOrders: ->
    orders = Orders.find()
    ###
    map = "function() {emit(this.beverages, this.timestamp);}"
    reduce = "function(bev, time) { return Array.count(bev.delivered); }"

    Orders.mapReduce map, reduce, {out: "undeliveredOrders", verbose: true}, (err, res) ->
      console.dir res.count
    ###
})
###
    Orders.find().group(
      key: { locationName, timestamp}
      #cond: { beverages.$.delivered: { $eq: false }}
      reduce: (curr, result) ->
        result.count ++
    )
###

###
# get all the bevs
# then loop through all the locations in order 
# then get all the orders that have the location and bev
###

Template.reportTotal.bevTable = ->
  beverages = Beverages.find({}, {sort: {name: 1}}).fetch()
  locations = Locations.find({vendor: false}, {sort: {number: 1}}).fetch()
  bevTable = []
  _.each beverages, (bev) ->
    bevObj = {}
    bevObj.name = bev.name
    bevObj.locationTotals = []
    totalsArr = []
    _.each locations, (location, i) =>
      orders = Orders.find({ 'beverages.name': bev.name , 'location': location._id }).fetch()
      if orders.length > 0
        _.each orders, (order) ->
          bevArr = order.beverages
          _.each bevArr, (b) ->
            if b.name == bev.name
              totalsArr.push b.units

          bevObj.locationTotals[i] = _.reduce totalsArr, (memo, num) ->
            memo + num
      else
        bevObj.locationTotals[i] = [0]
      totalsArr = []

    bevTable.push bevObj
  bevTable

Template.reportTotal.locations = ->
  Locations.find({vendor: false}, {sort: {number: 1}})

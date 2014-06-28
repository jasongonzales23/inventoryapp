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
      bevObj.locationTotals[i] = {}
      bevObj.locationTotals[i].location = location
      orders = Orders.find({ 'beverages.name': bev.name , 'location': location._id }).fetch()
      if orders.length > 0
        _.each orders, (order) ->
          bevArr = order.beverages
          _.each bevArr, (b) ->
            if b.name == bev.name
              totalsArr.push b.units

          bevObj.locationTotals[i].total = _.reduce totalsArr, (memo, num) ->
            memo + num
      else
        bevObj.locationTotals[i].total = 0
      totalsArr = []

    if bevObj.locationTotals.length > 0
      grandTotalObj = {}
      grandTotalObj.title = "grand total"
      tArr = _.pluck bevObj.locationTotals, "total"
      grandTotalObj.total = _.reduce tArr, (memo, num) ->
        memo + num
      bevObj.locationTotals.push grandTotalObj
      bevTable.push bevObj
  bevTable

Template.reportTotal.locations = ->
  Locations.find({vendor: false}, {sort: {number: 1}})

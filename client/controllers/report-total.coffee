getFestivalTotal = ->
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

Template.reportTotal.bevTable = ->
  getFestivalTotal()

Template.reportTotal.locations = ->
  Locations.find({vendor: false}, {sort: {number: 1}})

Template.reportTotal.events
  "click .download": (evt, templ) ->
    ###
    arr = [
      { "name": 'beer', "101": 1, "102": 2, "grand-total": 3}
      { "name": 'wine', "101": 3, "102": 4, "grand-total": 7 }
    ]
    ###
    arr = ->
      beverages = Beverages.find({}, {sort: {name: 1}}).fetch()
      locations = Locations.find({vendor: false}, {sort: {number: 1}}).fetch()
      bevTable = []
      _.each beverages, (bev) ->
        bevObj = {}
        bevObj.name = bev.name
        totalsArr = []
        _.each locations, (location, i) =>
          orders = Orders.find({ 'beverages.name': bev.name , 'location': location._id }).fetch()
          if orders.length > 0
            _.each orders, (order) ->
              bevArr = order.beverages
              _.each bevArr, (b) ->
                if b.name == bev.name
                  totalsArr.push b.units

              bevObj[location.number] = _.reduce totalsArr, (memo, num) ->
                memo + num
          else
            bevObj[location.number] = 0
          totalsArr = []

        noName = _.omit bevObj, "name"
        preTotal = _.values noName
        bevObj.total = _.reduce preTotal, (memo, num) ->
          memo + num
        bevTable.push bevObj
      bevTable

    csv = json2csv(arr(), true, true )
    evt.target.href = "data:text/csv;charset=utf-8," + escape(csv)
    evt.target.download = "festival_totals.csv"


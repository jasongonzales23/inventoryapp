getFestivalTotal = ->
  beverages = Beverages.find({}, {sort: {name: 1}}).fetch()
  locations = Locations.find({vendor: true}, {sort: {number: 1}}).fetch()
  bevTable = []
  _.each beverages, (bev) ->
    bevObj = {}
    bevObj.name = bev.name
    bevObj.locationTotals = []
    totalsArr = []
    _.each locations, (location, i) =>
      bevObj.locationTotals[i] = {}
      orders = Orders.find({ 'beverages.name': bev.name , 'location': location._id }).fetch()
      if orders.length > 0
        _.each orders, (order) ->
          bevArr = order.beverages
          _.each bevArr, (b) ->
            if b.name == bev.name
              totalsArr.push b.units

          bevObj.locationTotals[i].total = _.reduce totalsArr, (memo, num) ->
            parseInt(memo) + parseInt(num)
      else
        bevObj.locationTotals[i].total = 0
      totalsArr = []

    if bevObj.locationTotals.length > 0
      grandTotalObj = {}
      tArr = _.pluck bevObj.locationTotals, "total"
      grandTotalObj.total = _.reduce tArr, (memo, num) ->
        parseInt(memo) + parseInt(num)
      bevObj.locationTotals.push grandTotalObj
      bevTable.push bevObj

  grandTotalObj = {}
  grandTotalObj.name = "Grand Total"
  totalsArr = []
  grandTotalObj.locationTotals = []
  _.each locations, (location, i) ->
    grandTotalObj.locationTotals[i] = {}
    orders = Orders.find({ 'location': location._id }).fetch()
    _.each orders, (order) ->
      bevArr = order.beverages
      _.each bevArr, (b) ->
        totalsArr.push b.units
      grandTotalObj.locationTotals[i].total = _.reduce totalsArr, (memo, num) ->
        parseInt(memo) + parseInt(num)

    totalsArr = []
  if grandTotalObj.locationTotals.length > 0
    sumObj = {}
    tArr = _.pluck grandTotalObj.locationTotals, "total"
    sumObj.total = _.reduce tArr, (memo, num) ->
      parseInt(memo) + parseInt(num)
    grandTotalObj.locationTotals.push sumObj

  bevTable.push grandTotalObj
  bevTable

Template.vendorReport.bevTable = ->
  getFestivalTotal()

Template.vendorReport.locations = ->
  Locations.find({vendor: true}, {sort: {number: 1}})

Template.vendorReport.events
  "click .download": (evt, templ) ->
    arr = ->
      beverages = Beverages.find({}, {sort: {name: 1}}).fetch()
      locations = Locations.find({vendor: true}, {sort: {number: 1}}).fetch()
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
                parseInt(memo) + parseInt(num)
          else
            bevObj[location.number] = 0
          totalsArr = []

        noName = _.omit bevObj, "name"
        preTotal = _.values noName
        bevObj.Total = _.reduce preTotal, (memo, num) ->
          parseInt(memo) + parseInt(num)
        bevTable.push bevObj

      grandTotalObj = {}
      grandTotalObj.name = "Grand Total"
      rowTotalArr = []
      totalsArr = []
      _.each locations, (location, i) ->
        orders = Orders.find({ 'location': location._id }).fetch()
        _.each orders, (order) ->
          bevArr = order.beverages
          _.each bevArr, (b) ->
            totalsArr.push b.units
        grandTotalObj[location.number] = _.reduce totalsArr, (memo, num) ->
          parseInt(memo) + parseInt(num)
        rowTotalArr.push grandTotalObj[location.number]
        totalsArr = []

      grandTotalObj.Total = _.reduce rowTotalArr, (memo, num) -> parseInt(memo) + parseInt(num)
      bevTable.push grandTotalObj
      bevTable

    csv = json2csv(arr(), true, true )
    evt.target.href = "data:text/csv;charset=utf-8," + escape(csv)
    evt.target.download = "vendor_totals.csv"

Template.bevTable.helpers(
  bevTable: ->
    dailyParams = Session.get('dailyParams')
    year = parseInt dailyParams.year
    month = parseInt(dailyParams.month) - 1
    day = parseInt dailyParams.day
    start = new Date(year, month, day).valueOf()
    end = new Date(year, month, day + 1).valueOf()

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
        orders = Orders.find({ 'beverages.name': bev.name , 'location': location._id, 'timestamp': { '$gte': start, '$lt': end }}).fetch()
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
)

Template.Daily.helpers(
  locations: ->
    Locations.find({vendor: false}, {sort: {number: 1}})

  dateParams: ->
    dailyParams = Session.get('dailyParams')
    "#{dailyParams.month} #{dailyParams.day}, #{dailyParams.year}"
)

Template.reportNav.events
  "click .daily-report": (evt, templ) ->
    #Session.set('busy', true)

  "click .download": (evt, templ) ->
    dailyParams = Session.get('dailyParams')
    year = parseInt dailyParams.year
    month = parseInt(dailyParams.month) - 1
    day = parseInt dailyParams.day
    start = new Date(year, month, day).valueOf()
    end = new Date(year, month, day + 1).valueOf()

    arr = ->
      beverages = Beverages.find({}, {sort: {name: 1}}).fetch()
      locations = Locations.find({vendor: false}, {sort: {number: 1}}).fetch()
      bevTable = []
      _.each beverages, (bev) ->
        bevObj = {}
        bevObj.name = bev.name
        totalsArr = []
        _.each locations, (location, i) =>
          orders = Orders.find({ 'beverages.name': bev.name , 'location': location._id, 'timestamp': { '$gte': start, '$lt': end }}).fetch()
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
    evt.target.download = "daily_total.csv"


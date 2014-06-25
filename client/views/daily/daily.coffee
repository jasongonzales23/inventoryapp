Template.Daily.helpers({
  bevTable: ->
    dailyParams = Session.get('dailyParams')
    year = parseInt dailyParams.year
    month = parseInt dailyParams.month - 1
    day = parseInt(dailyParams.day)
    start = Date.UTC(year, month, day + 1)
    end = Date.UTC(year, month, day + 2)

    beverages = Beverages.find({}, {sort: {name: 1}}).fetch()
    locations = Locations.find({vendor: false}, {sort: {number: 1}}).fetch()
    bevTable = []
    _.each beverages, (bev) ->
      bevObj = {}
      bevObj.name = bev.name
      bevObj.locationTotals = []
      totalsArr = []
      _.each locations, (location, i) =>
        orders = Orders.find({ 'beverages.name': bev.name , 'location': location._id, 'timestamp': { '$gte': start, '$lt': end }}).fetch()
        if orders.length > 0
          _.each orders, (order) ->
            bevArr = order.beverages
            _.each bevArr, (b) ->
              if b.name == bev.name
                totalsArr.push b.units

            bevObj.locationTotals[i] = _.reduce totalsArr, (memo, num) ->
              memo + num
        else
          bevObj.locationTotals[i] = 0
        totalsArr = []

      if bevObj.locationTotals.length > 0
        total = _.reduce bevObj.locationTotals, (memo, num) ->
          memo + num
        bevObj.locationTotals.push total
        bevTable.push bevObj
    bevTable

  locations: ->
    Locations.find({vendor: false}, {sort: {number: 1}})

  dateParams: ->
    dailyParams = Session.get('dailyParams')
    "#{dailyParams.month} #{dailyParams.day}, #{dailyParams.year}"
})

###
# PDT 5/19/104
# 1400482800
#
# 1400569199
#
###

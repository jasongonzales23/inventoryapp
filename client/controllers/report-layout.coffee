Template.reportNav.days = ->
  orders = Orders.find({}, {sort: {timestamp: 1}}).fetch()
  if orders.length > 0
    timestamps = _.pluck(orders, 'timestamp')

    days = _.map timestamps, (timestamp, i) ->
      m = moment(timestamp)

    _.each days, (day, i) ->
      if day.isSame(days[i + 1], 'day')
        days.splice(i, 1)

   navDays = _.map days, (day) ->
     dayObj = {}
     dayWord = day.format("ddd")
     year = day.format("YYYY")
     month = day.format("MM")
     d = day.format("DD")
     dayObj.href = "/#{year}/#{month}/#{d}"
     dayObj.dayName = dayWord
     dayObj

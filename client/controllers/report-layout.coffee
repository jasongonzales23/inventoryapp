Template.reportNav.days = ->
  orders = Orders.find({}, {sort: {timestamp: 1}}).fetch()
  if orders.length > 0
    timestamps = _.pluck(orders, 'timestamp')
    days = []
    _.each timestamps, (timestamp,i) ->
      m = moment(timestamp)
      dayObj = {}
      day = m.format("ddd")
      inDays = _.where(days, {dayName: day})
      unless inDays.length > 0
        year = m.format("YYYY")
        month = m.format("MM")
        d = m.format("DD")
        dayObj.href = "/#{year}/#{month}/#{d}"
        dayObj.dayName = day
        days.push dayObj
    days

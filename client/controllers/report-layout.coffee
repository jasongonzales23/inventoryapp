Template.reportNav.days = ->
  orders = Orders.find({}, {sort: {timestamp: 1}}).fetch()
  if orders.length > 0
    timestamps = _.pluck(orders, 'timestamp')

    days = _.map timestamps, (timestamp, i) ->
      m = moment(timestamp).dayOfYear()

    uniqDays = _.uniq days

    navDays = _.map uniqDays, (day) ->
      dayObj = {}
      m = moment().dayOfYear(day)

      year = m.format("YYYY")
      month = m.format("MM")
      d = m.format("DD")

      dayObj.dayName = m.format("ddd")
      dayObj.href = "/#{year}/#{month}/#{d}"
      dayObj

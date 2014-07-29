TOKEN_VAL = 2

getCollectionDates = (collections) ->
  #what days are we working with here?
  timestamps = _.pluck(collections, 'timestamp')

  days = []
  years = []

  _.map timestamps, (timestamp, i) ->
    days.push moment(timestamp).dayOfYear()
    years.push moment(timestamp).year()

  uniqDays = _.uniq days
  uniqYears = _.uniq years

  {
    days: uniqDays
    years: uniqYears
  }

Template.tokenReconciliationReport.collectionDates = ->
  collections = TokenCollections.find({}, {sort: {timestamp: 1}}).fetch()
  collectionTimes = getCollectionDates(collections)

  collectionDays = []
  _.each collectionTimes.days, (day) ->
    dayObj = {}
    dayObj.date = moment().dayOfYear(day).format('dddd')
    collectionDays.push dayObj

  collectionDays


Template.tokenReconciliationReport.reportTable = ->
  reportTable = []
  locations = Locations.find({vendor: false}, {sort: {number: 1}}).fetch()
  collections = TokenCollections.find({}, {sort: {timestamp: 1}}).fetch()
  collectionTimes = getCollectionDates collections
  formattedTimes = _.map collectionTimes.days, (time) ->
    m = moment().set("dayOfYear", time)
    year = m.year()
    month = m.month()
    date = m.date()
    day = new Date(year, month, date).valueOf()

  #create a map of beverage token values
  bevMap = {}
  beverages = Beverages.find().fetch()
  if beverages.length > 0
    _.map beverages, (bev) ->
      bevMap[bev.name] = bev.value

  _.each locations, (location) -> 
    #get the name of each location in there
    reportObj = {}
    reportObj.name = location.name
    rowTotal = 0

    reportObj.locationTotals = []
    _.each formattedTimes, (time, i) ->
      start = time
      end = moment(start).add('days', 1).toDate().valueOf()
      locationCollections = TokenCollections.find({'location': location._id, 'timestamp':{'$gte': start, '$lt': end}}).fetch()
      tokensCollectedArr = _.pluck locationCollections, "tokens"

      reportObj.locationTotals[i] = {}

      if tokensCollectedArr.length > 0
        reportObj.locationTotals[i].total = _.reduce tokensCollectedArr, (memo, num) -> memo + num
      else
        reportObj.locationTotals[i].total = 0

    allTotals = _.pluck reportObj.locationTotals, "total"
    if allTotals.length > 0
      rowTotal = _.reduce allTotals, (memo, num) -> memo + num
      reportObj.locationTotals.push {total: rowTotal}

    #get Inventory Delivered value
    orders = Orders.find({ 'location': location._id }).fetch()
    if orders.length > 0
      bigArr = []
      _.each orders, (order) ->
        bevArr = order.beverages
        _.each bevArr, (bev) ->
          bevObj = {}
          bevObj.name = bev.name
          bevObj.units = parseInt bev.units
          bigArr.push bevObj

      preTotal = _.map bigArr, (orderBev) ->
        orderBev.units * bevMap[orderBev.name]
      invTotal = _.reduce preTotal, (memo, num) ->
        memo + num
      invTotal = Math.round10((invTotal * TOKEN_VAL), -2)
      reportObj.locationTotals.push {total: "$#{invTotal}"}

      #get Token Delta
      tokensCollected = rowTotal * TOKEN_VAL
      preDelta = 1 - ((invTotal - tokensCollected) / invTotal)
      tokenDelta = Math.round10((100 * preDelta), -2)
      reportObj.locationTotals.push {total: "#{tokenDelta}%"}

    reportTable.push reportObj

  grandTotalObj = {}
  grandTotalObj.name = "Grand Total"
  grandTotalObj.locationTotals = []
  _.each formattedTimes, (time, i) ->
    start = time
    end = moment(start).add('days', 1).toDate().valueOf()
    locationCollections = TokenCollections.find({'timestamp':{'$gte': start, '$lt': end}}).fetch()
    tokensCollectedArr = _.pluck locationCollections, "tokens"
    grandTotalObj.locationTotals[i] = {}

    if tokensCollectedArr.length > 0
      grandTotalObj.locationTotals[i].total = _.reduce tokensCollectedArr, (memo, num) -> memo + num
    else
      grandTotalObj.locationTotals[i].total = 0

  allTotals = _.pluck grandTotalObj.locationTotals, "total"
  if allTotals.length > 0
    grandTotal = _.reduce allTotals, (memo, num) -> memo + num
    grandTotalObj.locationTotals.push {total: grandTotal}

  #get Inventory Delivered value
  orders = Orders.find().fetch()
  if orders.length > 0
    bigArr = []
    _.each orders, (order) ->
      bevArr = order.beverages
      _.each bevArr, (bev) ->
        bevObj = {}
        bevObj.name = bev.name
        bevObj.units = parseInt bev.units
        bigArr.push bevObj

    preTotal = _.map bigArr, (orderBev) ->
      orderBev.units * bevMap[orderBev.name]
    invTotal = _.reduce preTotal, (memo, num) ->
      memo + num
    invTotal = Math.round10((invTotal * TOKEN_VAL), -2)
    grandTotalObj.locationTotals.push {total: "$#{invTotal}"}

    #get Token Delta
    tokensCollected = grandTotal * TOKEN_VAL
    preDelta = 1 - ((invTotal - tokensCollected) / invTotal)
    tokenDelta = Math.round10((100 * preDelta), -2)
    grandTotalObj.locationTotals.push {total: "#{tokenDelta}%"}

  reportTable.push grandTotalObj
  reportTable

Template.tokenReconciliationReport.events
  "click .download": (evt, templ) ->
    arr = ->
      reportTable = []
      locations = Locations.find({vendor: false}, {sort: {number: 1}}).fetch()
      collections = TokenCollections.find({}, {sort: {timestamp: 1}}).fetch()
      collectionTimes = getCollectionDates collections
      formattedTimes = _.map collectionTimes.days, (time) ->
        m = moment().set("dayOfYear", time)
        year = m.year()
        month = m.month()
        date = m.date()
        day = new Date(year, month, date).valueOf()

      #create a map of beverage token values
      bevMap = {}
      beverages = Beverages.find().fetch()
      if beverages.length > 0
        _.map beverages, (bev) ->
          bevMap[bev.name] = bev.value

      _.each locations, (location) ->
        reportObj = {}
        reportObj.Beverage_Station = location.name

        rowTotalArr = []
        _.each formattedTimes, (time, i) ->
          start = time
          end = moment(start).add('days', 1).toDate().valueOf()
          locationCollections = TokenCollections.find({'location': location._id, 'timestamp':{'$gte': start, '$lt': end}}).fetch()
          tokensCollectedArr = _.pluck locationCollections, "tokens"

          timeName = moment(start).format('dddd')

          if tokensCollectedArr.length > 0
            reportObj[timeName] = _.reduce tokensCollectedArr, (memo, num) -> memo + num
          else
            reportObj[timeName] = 0
          rowTotalArr.push reportObj[timeName]

        allTotals = _.reduce rowTotalArr, (memo, num) -> memo + num
        reportObj.Token_Total = allTotals

        #get Inventory Delivered value
        orders = Orders.find({ 'location': location._id }).fetch()
        if orders.length > 0
          bigArr = []
          _.each orders, (order) ->
            bevArr = order.beverages
            _.each bevArr, (bev) ->
              bevObj = {}
              bevObj.name = bev.name
              bevObj.units = parseInt bev.units
              bigArr.push bevObj

          preTotal = _.map bigArr, (orderBev) ->
            orderBev.units * bevMap[orderBev.name]
          invTotal = _.reduce preTotal, (memo, num) ->
            memo + num
          invTotal = Math.round10((invTotal * TOKEN_VAL), -2)
          reportObj.Inventory_Delivered = "$#{invTotal}"

          #get Token Delta
          tokensCollected = allTotals * TOKEN_VAL
          preDelta = 1 - ((invTotal - tokensCollected) / invTotal)
          tokenDelta = Math.round10 100 * preDelta, -2
          reportObj.Token_Delta = "#{tokenDelta}%"

        reportTable.push reportObj

      grandTotalObj = {}
      grandTotalObj.Beverage_Station = "Grand Total"
      rowTotalArr = []
      _.each formattedTimes, (time, i) ->
        start = time
        end = moment(start).add('days', 1).toDate().valueOf()
        locationCollections = TokenCollections.find({'timestamp':{'$gte': start, '$lt': end}}).fetch()
        tokensCollectedArr = _.pluck locationCollections, "tokens"
        timeName = moment(start).format('dddd')

        if tokensCollectedArr.length > 0
          grandTotalObj[timeName] = _.reduce tokensCollectedArr, (memo, num) -> memo + num
        else
          grandTotalObj[timeName] = 0
        rowTotalArr.push grandTotalObj[timeName]

      allTotals = _.reduce rowTotalArr, (memo, num) -> memo + num
      grandTotalObj.Token_Total = allTotals

      #get Inventory Delivered value
      orders = Orders.find().fetch()
      if orders.length > 0
        bigArr = []
        _.each orders, (order) ->
          bevArr = order.beverages
          _.each bevArr, (bev) ->
            bevObj = {}
            bevObj.name = bev.name
            bevObj.units = parseInt bev.units
            bigArr.push bevObj

        preTotal = _.map bigArr, (orderBev) ->
          orderBev.units * bevMap[orderBev.name]
        invTotal = _.reduce preTotal, (memo, num) ->
          memo + num
        invTotal = Math.round10((invTotal * TOKEN_VAL), -2)
        grandTotalObj.Inventory_Delivered = "$#{invTotal}"

        #get Token Delta
        tokensCollected = allTotals * TOKEN_VAL
        preDelta = 1 - ((invTotal - tokensCollected) / invTotal)
        tokenDelta = Math.round10((100 * preDelta), -2)
        grandTotalObj.Token_Delta = "#{tokenDelta}%"

      reportTable.push grandTotalObj

      reportTable

    csv = json2csv(arr(), true, true )
    evt.target.href = "data:text/csv;charset=utf-8," + escape(csv)
    evt.target.download = "reconciliation_report.csv"

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

Template.tokenCollectionReport.collectionDates = ->
  collections = TokenCollections.find({}, {sort: {timestamp: 1}}).fetch()
  collectionTimes = getCollectionDates(collections)

  collectionDays = []
  _.each collectionTimes.days, (day) ->
    dayObj = {}
    dayObj.date = moment().dayOfYear(day).format('dddd')
    collectionDays.push dayObj

  collectionDays


Template.tokenCollectionReport.reportTable = ->
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


  _.each locations, (location) -> 
    #get the name of each location in there
    reportObj = {}
    reportObj.name = location.name
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
      grandTotal = _.reduce allTotals, (memo, num) -> memo + num
      reportObj.locationTotals.push {total: grandTotal}
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

  reportTable.push grandTotalObj
  reportTable

[
  {
    name: 'Grand Total'
    locationTotals: [
      {
        total: 165
      }
    ]
  }
]

Template.tokenCollectionReport.events
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

      _.each locations, (location) ->
        #get the name of each location in there
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
        reportObj.Total = allTotals
        reportTable.push reportObj

      reportTable

    csv = json2csv(arr(), true, true )
    evt.target.href = "data:text/csv;charset=utf-8," + escape(csv)
    evt.target.download = "token_collection_report.csv"

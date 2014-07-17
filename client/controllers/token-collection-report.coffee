thing =

  [
    {
      name: 'foo'
      locationTotals: [ {total: 22}, {total: 23}, {total: 24} ]
    }
    {
      name: 'foo'
      locationTotals: [ {total: 22}, {total: 23}, {total: 24} ]
    }
    {
      name: 'foo'
      locationTotals: [ {total: 22}, {total: 23}, {total: 24} ]
    }
  ]

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

  reportTable

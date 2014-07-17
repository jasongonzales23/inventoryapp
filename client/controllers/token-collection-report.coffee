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

###
  navDays = _.map uniqDays, (day) ->
    dayObj = {}
    m = moment().dayOfYear(day)

    year = m.format("YYYY")
    month = m.format("MM")
    d = m.format("DD")

    dayObj.dayName = m.format("ddd")
    dayObj.href = "/#{year}/#{month}/#{d}"
    dayObj

  _.each locations, (location) ->
    reportObj = {}
    reportObj.name = location.name
    reportObj.locationTotals = []
  ###

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

    _.each formattedTimes, (time, i) ->
      start = time
      end = formattedTimes[i + 1]
      locationCollections = TokenCollections.find({'location': location._id, 'timestamp':{'$gte': start, '$lt': end}}).fetch()

    reportTable.push reportObj

  reportTable

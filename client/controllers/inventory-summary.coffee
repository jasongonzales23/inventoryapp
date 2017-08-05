getLastInventoryForBev = (bevObj, inventories, locations) ->
  return _.reduce(locations, (accum, location) ->
    hasBev = (inv) ->
      _.find(inv.beverages, (bev) ->
        bev.name == bevObj.name
      )

    inv = _.find(inventories, (inv) ->
      inv.location == location._id and hasBev(inv)
    )

    if inv
      bev = _.find(inv.beverages, (bev) ->
        bev.name == bevObj.name
      )

    bevUnits = if bev then bev.units else 0
    return accum + bevUnits
  , 0)

getTotalOrdersForBev = (bevObj, orders) ->
  return _.reduce(orders, (accum, order) ->
    bev = _.find(order.beverages, (bev) ->
      bev.name == bevObj.name && bev.units
    )

    bevUnits = if bev then bev.units else 0
    return accum + bevUnits
  , 0)

Template.inventorySummaryAll.summaryRow = () ->
  beverages = Beverages.find({}, {sort: {name: 1}}).fetch()
  inventories = Inventories.find({}, {sort: {timestamp: -1}}).fetch()
  orders = Orders.find().fetch()
  locations = Locations.find({vendor: false}, {sort: {number: 1}}).fetch()

  summaryRows = []
  _.each beverages, (bev) ->
    summaryRow = {}
    summaryRow.name = bev.name
    summaryRow.startingInventory = bev.startingInventory
    summaryRow.lastFieldInventory = getLastInventoryForBev(bev, inventories, locations)
    summaryRow.totalOrders = getTotalOrdersForBev(bev, orders)
    summaryRow.remainingInventory = summaryRow.startingInventory - summaryRow.totalOrders + summaryRow.lastFieldInventory
    summaryRow.percentRemainingInventory = Math.round(summaryRow.remainingInventory / summaryRow.startingInventory * 100)
    summaryRows.push(summaryRow)
  return summaryRows

getLocationInventories = (bevObj, inventories, locations) ->
  return _.map(locations, (location) ->
    hasBev = (inv) ->
      _.find(inv.beverages, (bev) ->
        bev.name == bevObj.name
      )

    inv = _.find(inventories, (inv) ->
      inv.location == location._id and hasBev(inv)
    )

    if inv
      bev = _.find(inv.beverages, (bev) ->
        bev.name == bevObj.name && bev.units
      )

    bevUnits = if bev then bev.units else 0
    return {lastInv: bevUnits}
  )

getInventoriesTotal = (inventories) ->
  return _.reduce(inventories, (accum, inv) ->
    return accum + inv.lastInv
  , 0)

Template.inventorySummaryLocations.summaryRow = () ->
  beverages = Beverages.find({}, {sort: {name: 1}}).fetch()
  inventories = Inventories.find({}, {sort: {timestamp: -1}}).fetch()
  orders = Orders.find().fetch()
  locations = Locations.find({vendor: false}, {sort: {number: 1}}).fetch()

  summaryRows = []
  _.each beverages, (bev) ->
    summaryRow = {}
    summaryRow.name = bev.name

    summaryRow.locationInventories = getLocationInventories(bev, inventories, locations)
    summaryRow.startingInventory = bev.startingInventory
    summaryRow.lastFieldInventory = getInventoriesTotal(summaryRow.locationInventories)
    summaryRow.totalOrders = getTotalOrdersForBev(bev, orders)
    summaryRow.remainingInventory = summaryRow.startingInventory - summaryRow.totalOrders + summaryRow.lastFieldInventory
    summaryRow.percentRemainingInventory = Math.round(summaryRow.remainingInventory / summaryRow.startingInventory * 100)

    summaryRows.push(summaryRow)
  return summaryRows

Template.inventorySummaryLocations.locations = () ->
  locations = Locations.find({vendor: false}, {sort: {number: 1}}).fetch()

getLatestInv = (locations, inventories) ->
  return _.map(locations, (location) ->
    inv = _.find(inventories, (inv) ->
      inv.location == location._id
    )
    lastInvTime = if inv then inv.timestamp else null
    return {lastInvTime: lastInvTime}
  )

Template.inventorySummaryLocations.locationInventoriesTimes = () ->
  locations = Locations.find({vendor: false}, {sort: {number: 1}}).fetch()
  inventories = Inventories.find({}, {sort: {timestamp: -1}}).fetch()
  return getLatestInv(locations, inventories)

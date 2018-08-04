Template.location.inventory = ->
  location = Locations.findOne(this._id)
  inventory = Inventories.find({"location": this._id}, { sort: {timestamp: -1}, limit: 1 }).fetch()
  unless not location? or not inventory.length > 0
    locationbeverages = location.beverages
    inventorybeverages = inventory[0].beverages

    findLocationBev = (bevName) ->
      _.filter(locationbeverages, (b) -> b.name == bevName)[0]

    i = 0
    while i < inventorybeverages.length
      locBev = findLocationBev(inventorybeverages[i].name)
      inventorybeverages[i].fillTo = locBev.fillTo
      inventorybeverages[i].orderWhen = locBev.orderWhen
      i++
  inventory

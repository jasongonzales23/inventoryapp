Template.location.inventory = ->
  location = Locations.findOne(this._id)
  inventory = Inventories.find({"location": this._id}, { sort: {timestamp: -1}, limit: 1 }).fetch()
  unless not location? or not inventory.length > 0
    locationbeverages = location.beverages
    #probably don't need this anymore
    #_.sortBy( locationbeverages , (beverage) -> beverage.name )
    inventorybeverages = inventory[0].beverages
    i = 0
    while i < inventorybeverages.length
      inventorybeverages[i].fillTo = locationbeverages[i].fillTo
      inventorybeverages[i].orderWhen = locationbeverages[i].orderWhen
      i++
  inventory

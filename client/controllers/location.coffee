Template.locations.locations = ->
  Locations.find({}, {sort: {number: 1}})

Template.location.inventory = ->
  Inventories.find({"location": this._id}, { sort: {timestamp: -1} , limit: 1 })

Template.location.beverageStandards = ->
  location = Locations.findOne(this._id)

  unless not location?
    beverages = location.beverages
    _.sortBy( beverages , (beverage) -> beverage.name )


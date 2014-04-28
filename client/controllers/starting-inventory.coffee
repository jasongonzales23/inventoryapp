Template.startingInventory.inventory = ->
  Locations.findOne( this._id )

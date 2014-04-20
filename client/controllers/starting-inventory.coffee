Template.startingInventory.inventories = ->
  Inventories.find({"location": this._id}, {sort: {timestamp: 1}, limit: 1})

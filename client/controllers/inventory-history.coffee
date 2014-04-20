Template.inventoryHistory.inventories = ->
  Inventories.find({"location": this._id}, {sort: {timestamp: -1}})

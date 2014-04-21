Template.locations.locations = ->
  Locations.find({}, {sort: {number: 1}})

Template.location.inventories = ->
  Inventories.find({"location": this._id}, {sort: {timestamp: -1}, limit: 1})

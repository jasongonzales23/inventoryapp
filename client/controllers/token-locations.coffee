Template.tokenLocations.locations = ->
  Locations.find({}, {sort: {number: 1}})

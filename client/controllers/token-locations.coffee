Template.tokenLocations.locations = ->
  Locations.find({'vendor': false}, {sort: {number: 1}})

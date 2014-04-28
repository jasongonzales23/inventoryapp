Template.locations.locations = ->
  Locations.find({}, {sort: {number: 1}})



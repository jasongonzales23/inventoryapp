Template.boothLocations.locations = ->
  TokenBooths.find({}, {sort: {number: 1}})


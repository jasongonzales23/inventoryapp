Template.dashboardVendors.vendors = ->
  Locations.find({'vendor': true}, {sort: {name: 1}})

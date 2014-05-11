Template.dashboardVendors.vendors = ->
  Locations.find({'vendor': true})

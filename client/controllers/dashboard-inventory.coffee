Template.dashboardInventory.helpers(
  latestInventories: ->
    locations = Inventories.find({}, {fields: {location: 1}}).map(
      (location) -> location.location
    )

    latestInventories = _.uniq( locations ).map(
      (location) ->
        Inventories.findOne({location: location}, {sort: {timestamp: -1}})
    )
  )

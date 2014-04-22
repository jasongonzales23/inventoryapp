Template.updateInventory.events
  "click #update-inventory": (evt, templ) ->
    beverages = []
    $beverages = $('.beverage')
    $.each( $beverages, (i,v) ->
      name = $(this).find('.name').text()
      number = $(this).find('.number input').val()
      bev = {}
      bev.name = name
      bev.units = number
      beverages.push(bev)
    )

    location = this._id
    locationName = this.name
    user = Meteor.user()._id
    timestamp = new Date().valueOf()

    Inventories.insert
      timestamp: timestamp
      location: location
      locationName: locationName
      user_id: user
      beverages: beverages
    Router.go('/locations')

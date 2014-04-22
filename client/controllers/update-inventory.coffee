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
    debugger
    locationNumber = this.number
    user = Meteor.user()._id
    username = Meteor.user().emails[0].address
    timestamp = new Date().valueOf()

    Inventories.insert
      timestamp: timestamp
      location: location
      locationName: locationName
      locationNumber: locationNumber
      user_id: user
      username: username
      beverages: beverages
    Router.go('/locations')

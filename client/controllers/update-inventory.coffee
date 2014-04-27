Template.updateInventory.beverages = ->
  location = Session.get('location')

  unless not location?
    beverages = location.beverages
    _.sortBy( beverages , (beverage) -> beverage.name )

Template.updateInventory.location = ->
  Session.get('location')

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

    location = Session.get('location')
    user = Meteor.user()._id
    username = Meteor.user().emails[0].address
    timestamp = new Date().valueOf()

    Inventories.insert
      timestamp: timestamp
      location: location._id
      locationName: location.name
      locationNumber: location.number
      user_id: user
      username: username
      beverages: beverages
    Router.go('/locations')

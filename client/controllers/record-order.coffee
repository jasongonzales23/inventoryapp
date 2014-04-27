Template.recordOrder.beverages = ->
  location = Session.get('location')

  unless not location?
    console.log location.beverages
    beverages = location.beverages
    _.sortBy( beverages , (beverage) -> beverage.name )

Template.recordOrder.location = ->
  Session.get('location')

Template.recordOrder.events
  "click #record-order": (evt, templ) ->
    beverages = []
    $beverages = $('.beverage')
    $.each( $beverages, (i,v) ->
      name = $(this).find('.name').text()
      number = $(this).find('.number input').val()
      bev = {}
      bev._id = new Meteor.Collection.ObjectID()._str
      bev.name = name
      bev.units = number
      bev.delivered = false
      beverages.push(bev)
    )

    location = Session.get('location')
    user = Meteor.user()._id
    username = Meteor.user().emails[0].address
    timestamp = new Date().valueOf()

    Orders.insert
      timestamp: timestamp
      location: location._id
      locationName: location.name
      locationNumber: location.number
      user_id: user
      username: username
      beverages: beverages
    Router.go('/locations')


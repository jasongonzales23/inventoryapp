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

    location = this._id
    locationName = this.name
    locationNumber = this.number
    user = Meteor.user()._id
    username = Meteor.user().emails[0].address
    timestamp = new Date().valueOf()

    Orders.insert
      timestamp: timestamp
      location: location
      locationName: locationName
      locationNumber: locationNumber
      user_id: user
      username: username
      beverages: beverages
    Router.go('/locations')


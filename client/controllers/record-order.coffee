Template.recordOrder.beverages = ->
  location = Session.get('location')

Template.recordOrder.location = ->
  Session.get('location')

Template.recordOrder.events
  "click .incr": (evt, templ) ->
    $button = $(evt.target)
    $input = $button.parent().find('input')
    oldValue = $input.val()
    btnData = $button.data()
    if btnData.incr == 'up'
      newVal = if oldValue == '' then 1 else parseFloat(oldValue) + 1
    else
      if oldValue > 0
        newVal = parseFloat(oldValue) - 1
      else
        newVal = 0
    $input.val(newVal)

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


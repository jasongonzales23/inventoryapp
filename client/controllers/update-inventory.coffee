showModal = ->
  $('#confirmation').modal()

Template.updateInventory.beverages = ->
  location = Session.get('location')

  ###
  unless not location?
    beverages = location.beverages
    _.sortBy( beverages , (beverage) -> beverage.name )
  ###

Template.updateInventory.location = ->
  Session.get('location')

Template.updateInventory.events
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

  "click #update-inventory": (evt, templ) ->
    showModal()

Template.modal.events
  "click #confirm": (evt, templ) ->
    beverages = []
    $beverages = $('.beverage')
    $.each( $beverages, (i,v) ->
      name = $(this).find('.name').text()
      number = $(this).find('.number input').val()
      bev = {}
      bev.name = name
      bev.units = parseInt(number)
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

    $('#confirmation').modal('hide')
    $('#confirmation').on 'hidden.bs.modal', (e) ->
      Router.go('/locations')

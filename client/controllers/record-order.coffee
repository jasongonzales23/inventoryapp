showModal = ->
  $('#confirmation').modal()
  Session.set('modal_type', 'recordOrder')

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
    showModal()

Template.modal.events
  "click #confirm": (evt, templ) ->
    modalType = Session.get('modal_type')
    if modalType is 'recordOrder'
      beverages = []
      $beverages = $('.beverage')
      $.each( $beverages, (i,v) ->
        bev = {}
        number = $(this).find('.number input').val()
        bev.units = parseInt(number)

        if bev.units > 0
          name = $(this).find('.name').text()
          bev._id = new Meteor.Collection.ObjectID()._str
          bev.name = name
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

      $('#confirmation').modal('hide')
      $('#confirmation').on 'hidden.bs.modal', (e) ->
        Router.go('/locations')



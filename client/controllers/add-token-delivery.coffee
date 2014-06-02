showModal = ->
  $('#confirmation').modal()
  Session.set('modal_type', 'addTokenDelivery')

Template.addTokenDelivery.events
  "click #add-tokens": (evt, templ) ->
    showModal()

Template.modal.events
  "click #confirm": (evt, templ) ->
    modalType = Session.get('modal_type')
    if modalType is 'addTokenDelivery'
      location = @
      user = Meteor.user()._id
      username = Meteor.user().username
      timestamp = new Date().valueOf()
      tokens = parseInt $('#tokens-delivered').val()

      TokenDeliveries.insert
        timestamp: timestamp
        location: location._id
        locationName: location.name
        locationNumber: location.number
        vendor: location.vendor
        user_id: user
        username: username
        tokens: tokens

      $('#confirmation').modal('hide')
      $('#confirmation').on 'hidden.bs.modal', (e) ->
        Router.go("/booth-locations/#{location._id}/tokens/deliveries/show")

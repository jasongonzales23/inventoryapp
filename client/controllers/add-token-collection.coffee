showModal = ->
  $('#confirmation').modal()
  Session.set('modal_type', 'addTokenCollection')

Template.addTokenCollection.events
  "click #add-tokens": (evt, templ) ->
    showModal()

Template.modal.events
  "click #confirm": (evt, templ) ->
    modalType = Session.get('modal_type')
    if modalType is 'addTokenCollection'
      location = @
      user = Meteor.user()._id
      username = Meteor.user().username
      timestamp = new Date().valueOf()
      tokens = parseInt $('#tokens').val()

      TokenCollections.insert
        timestamp: Meteor.myFunctions.assignFiscalDay timestamp
        location: location._id
        locationName: location.name
        locationNumber: location.number
        vendor: location.vendor
        user_id: user
        username: username
        tokens: tokens

      $('#confirmation').modal('hide')
      $('#confirmation').on 'hidden.bs.modal', (e) ->
        Router.go("/locations/#{location._id}/tokens/collections/show")


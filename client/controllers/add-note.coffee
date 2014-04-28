Template.addNote.events =
  "click #add-note": (evt, templ) ->
    noteInput = templ.find("#note")
    note = noteInput.value

    user = Meteor.user()._id
    username = Meteor.user().emails[0].address
    location = this._id
    timestamp = new Date().valueOf()
    
    Notes.insert
      timestamp: timestamp
      location: location
      user_id: user
      username: username
      note: note

    Router.go('/locations')
      


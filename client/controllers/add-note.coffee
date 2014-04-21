Template.addNote.events =
  "click #add-note": (evt, templ) ->
    noteInput = templ.find("#note")
    note = noteInput.value

    user = Meteor.user()._id
    location = this._id
    timestamp = new Date().valueOf()
    
    Notes.insert
      timestamp: timestamp
      location: location
      user_id: user
      note: note

    Router.go('/locations')
      


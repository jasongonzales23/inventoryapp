Template.addNote.events =
  "click #add-note": (evt, templ) ->
    noteInput = templ.find("#note")
    note = noteInput.value

    user = Meteor.user()._id
    username = Meteor.user().username
    location = this._id
    locationName = this.name
    locationNumber = this.number
    timestamp = new Date().valueOf()

    Notes.insert
      timestamp: timestamp
      location: location
      locationName: locationName
      locationNumber: locationNumber
      user_id: user
      username: username
      note: note

    Router.go('/locations')

Template.addNote.events =
  "click #add-note": (evt, templ) ->
    noteInput = templ.find("#note")
    note = noteInput.value

    user = Meteor.user()._id
    username = Meteor.user().username
    location = this._id
    locationName = this.name
    locationNumber = this.number
    color = this.color
    timestamp = new Date().valueOf()

    Notes.insert
      timestamp: timestamp
      location: location
      color: color
      locationName: locationName
      locationNumber: locationNumber
      user_id: user
      username: username
      note: note

    Router.go("/locations/#{location}")

Template.showNotes.notes = ->
  Notes.find({"location": this._id}, {sort: {timestamp: -1}})



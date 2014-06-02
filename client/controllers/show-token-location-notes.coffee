Template.showTokenLocationNotes.notes = ->
  TokenLocationNotes.find({"location": this._id}, {sort: {timestamp: -1}})


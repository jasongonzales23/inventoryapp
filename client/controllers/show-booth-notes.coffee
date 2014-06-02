Template.showBoothNotes.notes = ->
  TokenBoothNotes.find({"location": this._id}, {sort: {timestamp: -1}})



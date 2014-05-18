Template.dashboardNotes.locations = ->
  notes = Notes.find({},
    sort:
      timestamp: -1
  )

  locations = {}
  notes.forEach (doc) ->
    unless locations[doc.location]?
      locations[doc.location] =
        locationName: doc.locationName
        locationNumber: doc.locationNumber
        notes: []
        notesCount: 0
        newestNote: null

    locations[doc.location].notes.push doc
    locations[doc.location].notesCount++
    if locations[doc.location].notes.length > 0
      locations[doc.location].newestNote = _.max(locations[doc.location].notes,
          (note) ->
            note.timestamp
        )
  return _.values(locations)

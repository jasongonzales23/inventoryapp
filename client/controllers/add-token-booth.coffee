Template.tokenBoothAdd.events
  "click #tokenBoothAdd": (evt, templ) ->
    numInput = templ.find("#locationNum")
    nameInput = templ.find("#locationName")
    name = nameInput.value
    num = numInput.value
    nameInput.value = ""
    numInput.value = ""
    TokenBooths.insert
      number: num
      name: name

  "click .destroy": ->
    TokenBooths.remove(this._id)

Template.tokenBoothAdd.booths = ->
  TokenBooths.find({}, {sort: {number: 1}})



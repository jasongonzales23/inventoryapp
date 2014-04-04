#TODO use enter key to submit
Template.locationAdd.events "click #locationAdd": (evt, templ) ->
  nameInput = templ.find("#locationName")
  numInput = templ.find("#locationNum")
  name = nameInput.value
  num = numInput.value
  nameInput.value = ""
  numInput.value = ""
  Locations.insert
    number: num
    name: name


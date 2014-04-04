Template.bevlist.beverages = ->
  Beverages.find()

#TODO use enter key to submit
Template.bevAdd.events "click #beverageAdd": (evt, templ) ->
  input = templ.find("#beverageText")
  name = input.value
  input.value = ""
  Beverages.insert name: name

Template.locations.locations = ->
  Locations.find()


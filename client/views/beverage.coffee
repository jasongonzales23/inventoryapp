Template.bevlist.beverages = ->
  Beverages.find()

#TODO use enter key to submit
Template.bevlist.events 
  "click #beverageAdd": (evt, templ) ->
    nameInput = templ.find("#beverage-text")
    valueInput = templ.find("#beverage-value")
    name = nameInput.value
    value = valueInput.value
    nameInput.value = ""
    valueInput.value = ""
    Beverages.insert
      name: name
      value: value

  "click .destroy": (evt, templ) ->
    Beverages.remove(this._id)

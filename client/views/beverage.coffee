Template.addBeverages.beverages = ->
  Beverages.find({}, {sort: {name: 1}})

#TODO use enter key to submit
Template.addBeverages.events 
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

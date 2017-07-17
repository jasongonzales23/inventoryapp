Template.addBeverages.beverages = ->
  Beverages.find({}, {sort: {name: 1}})

#TODO use enter key to submit
Template.addBeverages.events
  "click #beverageAdd": (evt, templ) ->
    nameInput = templ.find("#beverage-text")
    valueInput = templ.find("#beverage-value")
    startingInventoryInput = templ.find('#beverage-startingInventory')
    name = nameInput.value
    value = valueInput.value
    startingInventory = startingInventoryInput.value
    nameInput.value = ""
    valueInput.value = ""
    startingInventoryInput.value = ""
    Beverages.insert
      name: name
      value: value
      startingInventory: startingInventory

  "click .destroy": (evt, templ) ->
    Beverages.remove(this._id)

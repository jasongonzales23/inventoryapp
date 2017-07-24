Session.setDefault('editing_beverage', null)

Template.addBeverages.beverages = ->
  Beverages.find({}, {sort: {name: 1}})

Template.addBeverages.isBeingEdited = () ->
  bevId = Session.get 'editing_beverage'
  if this._id == bevId
    return true
  else
    return false

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

  "click .edit-bev": (evt) ->
    Session.set('editing_beverage', this._id)
    Deps.flush()

  "click .save-bev": (evt, templ) ->
    nameInput = templ.find("#editBevName")
    startUnitsInput = templ.find("#editStartUnits")
    tokenValueInput = templ.find("#editTokenValue")

    name = nameInput.value
    startUnits = startUnitsInput.value
    tokenValue = tokenValueInput.value

    beverage = Session.get('editing_beverage')
    beverageData = {
        name: name
        startingInventory: startUnits
        value: tokenValue
    }
    console.log(beverageData)

    Beverages.update beverage, {
      $set: beverageData
    }

    Session.set('editing_beverage', null)
    Deps.flush()

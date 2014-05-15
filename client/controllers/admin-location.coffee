Session.setDefault('editing_location_beverage', null)

activateInput = (input) ->
  input.focus()
  input.select()

okCancelEvents = (selector, callbacks) ->
  ok = callbacks.ok or ->
  cancel = callbacks.cancel or ->
  events = {}
  events["keyup " + selector + ", keydown " + selector + ", focusout " + selector] = (evt) ->
    if evt.type is "keydown" and evt.which is 27
      escape = cancel
      cancel.call this, evt
    else if evt.type is "keyup" and evt.which is 13 or evt.type is "focusout"
      # blur/return/enter = ok/submit if non-empty
      value = String(evt.target.value or "")
      if value
        ok.call this, value, evt
      else
        cancel.call this, evt
    return
  events

Template.adminLocation.events
  "click #beverageAdd": (evt, templ) ->
    nameInput = templ.find("#bevName")
    startUnitsInput = templ.find("#startUnits")
    fillToInput = templ.find("#fillTo")
    orderWhenInput = templ.find("#orderWhen")

    name = nameInput.value
    startUnits = startUnitsInput.value
    fillTo = fillToInput.value
    orderWhen = orderWhenInput.value

    nameInput.value = ""
    startUnitsInput.value = ""
    fillToInput.value = ""
    orderWhenInput.value = ""

    alreadyThere = Locations.find( { "_id": this._id, "beverages.name": name})
    if not alreadyThere.fetch().length
      location = Locations.findOne(this._id)
      beverage = {
          name: name
          startUnits: startUnits
          fillTo: fillTo
          orderWhen: orderWhen
          _id: new Meteor.Collection.ObjectID()._str
      }

      beverages = location.beverages || []
      beverages.push(beverage)
      if beverages.length > 1
        beverages = _.sortBy location.beverages, (bev) -> bev.name

      Locations.update this._id, {
        $unset: { beverages: '' }
      }
      Locations.update this._id, {
        $set: { beverages: beverages }
      }
    else
      alert "That Beverage Already Exists for This Location"

  "click .destroy": (evt, templ) ->
    location = Locations.findOne({ "beverages._id": this._id})
    Locations.update( {_id: location._id}, {$pull: { "beverages": { _id: this._id }}})

  "dblclick .editable": (evt, templ) ->
    Session.set('editing_location_beverage', this._id)
    Deps.flush() # update DOM before focus
    activateInput(templ.find("#edit-bev"))

Template.adminLocation.editing = ->
  Session.equals('editing_location_beverage', this._id)

Template.adminLocation.events(okCancelEvents(
  '#edit-bev',
    ok: (value, evt) ->
      currentLocation = Locations.findOne('beverages._id': @_id)
      bevId = @_id
      beverages = currentLocation.beverages
      match = _.find beverages, (bev) -> bev._id == bevId
      if match
        target = evt.target.dataset.target
        match[target] = value
      Locations.update(currentLocation._id, {$set: {beverages: beverages}})
      Session.set('editing_location_beverage', null)

    cancel: () ->
      Session.set('editing_location_beverage', null)
  ))

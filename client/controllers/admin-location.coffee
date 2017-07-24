Session.setDefault('editing_location_beverage', null)
Session.setDefault('editing_location', null)

Template.adminLocation.isBeingEdited = () ->
  bevId = Session.get 'editing_location_beverage'
  if this._id == bevId
    return true
  else
    return false

Template.adminLocation.editingLocation = () ->
  Session.get('editing_location')

Template.adminLocation.locationColor = () ->
  if this.color and this.color != "none"
    return "<span class='color #{this.color}'></span>"
  else
    return "<span>#{this.color}</span>"

Template.adminLocation.colorChecked = (color) ->
  if this.color
    return this.color == color
  else
    return false

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
  "click .edit-bev": (evt) ->
    Session.set('editing_location_beverage', this._id)
    Deps.flush()

  "click .save-bev": (evt, templ) ->
    nameInput = templ.find("#editBevName")
    startUnitsInput = templ.find("#editStartUnits")
    fillToInput = templ.find("#editFillTo")
    orderWhenInput = templ.find("#editOrderWhen")

    name = nameInput.value
    startUnits = startUnitsInput.value
    fillTo = fillToInput.value
    orderWhen = orderWhenInput.value

    beverage = {
        name: name
        startUnits: startUnits
        fillTo: fillTo
        orderWhen: orderWhen
        _id: this._id
    }

    location = Locations.findOne({ "beverages._id": this._id})
    beverages = location.beverages

    newBeverages = _.map(beverages, (bev) =>
      if bev._id == beverage._id
        return beverage
      else
        return bev
    )

    Locations.update location._id, {
      $unset: { beverages: '' }
    }
    Locations.update location._id, {
      $set: { beverages: newBeverages }
    }

    Session.set('editing_location_beverage', null)
    Deps.flush()

  "click .edit-location": (evt) ->
    Session.set('editing_location', this._id)
    Deps.flush()

  "click .save-edit-location": (evt, templ) ->
    numberInput = templ.find("#number")
    nameInput = templ.find("#name")
    organizationInput = templ.find("#organization")
    vendorInput = templ.find("#locationVendor")
    colorInput = templ.find("input:radio[name=locationColor]:checked")
    orderInput = templ.find("#viewableByOrder")
    inventoryInput = templ.find("#viewableByInventory")

    number = numberInput.value
    name = nameInput.value
    organization = organizationInput.value
    color = colorInput && colorInput.value or "none"
    vendor = vendorInput.checked
    orderPermission = orderInput.checked
    inventoryPermission = inventoryInput.checked

    if not color then color = 'none'

    location = Session.get('editing_location')
    locationData =
      name: name
      number: number
      organization: organization
      vendor: vendor
      color: color
      orderPermission: orderPermission
      inventoryPermission: inventoryPermission

    Locations.update location, {
      $set: locationData
    }

    Session.set('editing_location', null)
    Deps.flush()

Template.addLocations.events
  "click #locationAdd": (evt, templ) ->
    numInput = templ.find("#locationNum")
    nameInput = templ.find("#locationName")
    orgInput = templ.find("#locationOrg")
    vendorInput = templ.find("#locationVendor")
    colorInput = templ.find("input:radio[name=locationColor]:checked")
    defaultColor = templ.find("#defaultColor")
    orderInput = templ.find("#viewableByOrder")
    inventoryInput = templ.find("#viewableByInventory")

    name = nameInput.value
    num = numInput.value
    org = orgInput.value
    vendor = vendorInput.checked
    color = colorInput && colorInput.value or "none"
    orderPermission = orderInput.checked
    inventoryPermission = inventoryInput.checked

    nameInput.value = ""
    numInput.value = ""
    orgInput.value = ""
    vendorInput.checked = false
    defaultColor.checked = true
    orderInput.checked = false
    inventoryInput.checked = false

    Locations.insert
      number: num
      name: name
      organization: org
      vendor: vendor
      color: color
      orderPermission: orderPermission
      inventoryPermission: inventoryPermission

  "click .destroy": ->
    Locations.remove(this._id)

Template.addLocations.locations = ->
  Locations.find({}, {sort: {number: 1}})


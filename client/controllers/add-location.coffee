Template.addLocations.events
  "click #locationAdd": (evt, templ) ->
    numInput = templ.find("#locationNum")
    nameInput = templ.find("#locationName")
    orgInput = templ.find("#locationOrg")
    vendorInput = templ.find("#locationVendor")
    colorInput = templ.find("input:radio[name=locationColor]:checked")
    defaultColor = templ.find("#defaultColor")

    name = nameInput.value
    num = numInput.value
    org = orgInput.value
    vendor = vendorInput.checked
    color = colorInput && colorInput.value or "none"

    nameInput.value = ""
    numInput.value = ""
    orgInput.value = ""
    vendorInput.checked = false
    defaultColor.checked = true

    Locations.insert
      number: num
      name: name
      organization: org
      vendor: vendor
      color: color

  "click .destroy": ->
    Locations.remove(this._id)

Template.addLocations.locations = ->
  Locations.find({}, {sort: {number: 1}})


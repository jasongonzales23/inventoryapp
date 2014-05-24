Template.addLocations.events
  "click #locationAdd": (evt, templ) ->
    numInput = templ.find("#locationNum")
    nameInput = templ.find("#locationName")
    orgInput = templ.find("#locationOrg")
    vendorInput = templ.find("#locationVendor")
    name = nameInput.value
    num = numInput.value
    org = orgInput.value
    vendor = vendorInput.checked
    nameInput.value = ""
    numInput.value = ""
    orgInput.value = ""
    vendorInput.checked = false
    Locations.insert
      number: num
      name: name
      organization: org
      vendor: vendor

  "click .destroy": ->
    Locations.remove(this._id)

Template.addLocations.locations = ->
  Locations.find({}, {sort: {number: 1}})


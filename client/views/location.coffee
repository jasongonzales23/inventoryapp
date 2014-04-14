#TODO use enter key to submit?

#TODO Use this when you create subs & pubs (use Deps.autorun for this too?)
#Locations = new Meteor.Collection("locations");

Template.locationAdd.events
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

Template.locationAdd.locations = ->
  Locations.find()

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

    alreadyThere = Locations.find( {_id: this.adminLocation._id, "beverages.name": name})
    if not alreadyThere.fetch().length
      Locations.update this.location._id, {$addToSet:
        beverages:
          name: name
          startUnits: startUnits
          fillTo: fillTo
          orderWhen: orderWhen
          _id: new Meteor.Collection.ObjectID()._str
      }
    else
      alert "That Beverage Already Exists for This Location"

  "click .destroy": (evt, templ) ->
    location = Locations.findOne({ "beverages._id": this._id})
    Locations.update( {_id: location._id}, {$pull: { "beverages": { _id: this._id }}})


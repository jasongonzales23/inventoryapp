#TODO maybe I just query the location data and transform it to include the most recent inventory
#data: ()-> Locations.findOne(this.params._id)
Template.locations.locations = ->
  Locations.find({}, {sort: {number: 1}})


Template.location.inventories = ->
  Inventories.find({"location": this._id}, {
    sort:
      timestamp: -1
     'beverage.name': -1
      , limit: 1
    ###
    transform: (inv) ->
      _.each inv.beverages, (bev) ->
        #console.log bev.name
        bev.fillTo = "33"
        bev.orderWhen = "99"
      inv
      ###
  })

Template.location.standards = ->
  Locations.find({"_id": this._id}, {sort: {number: 1}})


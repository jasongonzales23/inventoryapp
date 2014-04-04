@.Beverages = new Meteor.Collection("Beverages")
@.Inventories = new Meteor.Collection("Inventories")
@.Locations = new Meteor.Collection("Locations")


if Meteor.isServer
  Meteor.startup ->
    # code to run on server at startup

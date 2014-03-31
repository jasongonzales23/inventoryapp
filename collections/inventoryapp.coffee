@.Beverages = new Meteor.Collection("Beverages")
@.Inventories = new Meteor.Collection("Inventories")

if Meteor.isServer
  Meteor.startup ->
    # code to run on server at startup

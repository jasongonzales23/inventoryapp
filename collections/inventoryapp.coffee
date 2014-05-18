@.Beverages = new Meteor.Collection("Beverages")
@.Inventories = new Meteor.Collection("Inventories")
@.Locations = new Meteor.Collection("Locations")
@.Orders = new Meteor.Collection("Orders")
@.Notes = new Meteor.Collection("Notes")


if Meteor.isServer
  Meteor.startup ->
    # code to run on server at startup
  Meteor.publish "beverages", () ->
    Beverages.find()
  Meteor.publish "inventories", () ->
    Inventories.find()
  Meteor.publish "locations", () ->
    Locations.find()
  Meteor.publish "orders", () ->
    Orders.find()
  Meteor.publish "notes", () ->
    Notes.find()

if Meteor.isClient
  Meteor.subscribe("beverages")
  Meteor.subscribe("inventories")
  Meteor.subscribe("locations")
  Meteor.subscribe("orders")
  Meteor.subscribe("notes")

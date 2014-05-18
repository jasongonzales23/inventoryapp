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
  Meteor.publish "users", () ->
    Meteor.users.find()

  Beverages.allow
    insert: (user, bev) ->
      true
  Inventories.allow
    insert: (user, inventory) ->
      true
  Locations.allow
    insert: (user, location) ->
      true
  Orders.allow
    insert: (user, order) ->
      true
  Notes.allow
    insert: (user, note) ->
      true

if Meteor.isClient
  Meteor.subscribe("beverages")
  Meteor.subscribe("inventories")
  Meteor.subscribe("locations")
  Meteor.subscribe("orders")
  Meteor.subscribe("notes")
  Meteor.subscribe("users")

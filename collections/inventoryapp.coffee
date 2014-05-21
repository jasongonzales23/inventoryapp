@.Beverages = new Meteor.Collection("Beverages")
@.Inventories = new Meteor.Collection("Inventories")
@.Locations = new Meteor.Collection("Locations")
@.Orders = new Meteor.Collection("Orders")
@.Notes = new Meteor.Collection("Notes")
@.TokenCollections = new Meteor.Collection("TokenCollections")


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
  Meteor.publish "tokencollections", () ->
    TokenCollections.find()

  Beverages.allow
    insert: (user, bev) ->
      true
    update: (user, bev, fieldNames, modifier) ->
      true
    remove: (user, bev) ->
      true
  Inventories.allow
    insert: (user, inventory) ->
      true
    update: (user, inventory, fieldNames, modifier) ->
      true
    remove: (user, inventory) ->
      true
  Locations.allow
    insert: (user, location) ->
      true
    update: (user, location, fieldNames, modifier) ->
      true
    remove: (user, location) ->
      true
  Orders.allow
    insert: (user, order) ->
      true
    update: (user, order, fieldNames, modifier) ->
      true
    remove: (user, order) ->
      true
  Notes.allow
    insert: (user, note) ->
      true
    update: (user, note, fieldNames, modifier) ->
      true
    remove: (user, note) ->
      true
  TokenCollections.allow
    insert: (user, tokencollection) ->
      true
    update: (user, tokencollection, fieldNames, modifier) ->
      true
    remove: (user, tokencollection) ->
      true

if Meteor.isClient
  Meteor.subscribe("beverages")
  Meteor.subscribe("inventories")
  Meteor.subscribe("locations")
  Meteor.subscribe("orders")
  Meteor.subscribe("notes")
  Meteor.subscribe("users")
  Meteor.subscribe("tokencollections")

@.Beverages = new Meteor.Collection("Beverages")
@.Inventories = new Meteor.Collection("Inventories")
@.Locations = new Meteor.Collection("Locations")
@.Orders = new Meteor.Collection("Orders")
@.Notes = new Meteor.Collection("Notes")
@.TokenCollections = new Meteor.Collection("TokenCollections")
@.TokenDeliveries = new Meteor.Collection("TokenDeliveries")
@.TokenBooths = new Meteor.Collection("TokenBooths")
@.TokenLocationNotes = new Meteor.Collection("TokenLocationNotes")


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
  Meteor.publish "tokendeliveries", () ->
    TokenDeliveries.find()
  Meteor.publish "tokenbooths", () ->
    TokenBooths.find()
  Meteor.publish "tokenlocationnotes", () ->
    TokenLocationNotes.find()

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
  TokenDeliveries.allow
    insert: (user, tokendelivery) ->
      true
    update: (user, tokendelivery, fieldNames, modifier) ->
      true
    remove: (user, tokendelivery) ->
      true
  TokenBooths.allow
    insert: (user, tokenbooth) ->
      true
    update: (user, tokenbooth, fieldNames, modifier) ->
      true
    remove: (user, tokenbooth) ->
      true
  TokenLocationNotes.allow
    insert: (user, tokenlocationnote) ->
      true
    update: (user, tokenlocationnote, fieldNames, modifier) ->
      true
    remove: (user, tokenlocationnote) ->
      true

if Meteor.isClient
  Meteor.subscribe("beverages")
  Meteor.subscribe("inventories")
  Meteor.subscribe("locations")
  Meteor.subscribe("orders")
  Meteor.subscribe("notes")
  Meteor.subscribe("users")
  Meteor.subscribe("tokencollections")
  Meteor.subscribe("tokendeliveries")
  Meteor.subscribe("tokenbooths")
  Meteor.subscribe("tokenlocationnotes")

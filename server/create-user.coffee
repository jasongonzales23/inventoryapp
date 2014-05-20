#TODO add error and success callbacks
Meteor.methods({
  create_user: (username, password) ->
    Accounts.createUser({username: username, password: password, profile: {name: username} })
})

Meteor.methods
  removeOrders: ->
    Orders.remove({})


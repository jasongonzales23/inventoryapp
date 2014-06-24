if Meteor.isServer
  Meteor.startup ->
    Meteor.methods removeAllOrders: ->
      Orders.remove {}

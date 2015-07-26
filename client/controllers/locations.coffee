Template.locations.locations = ->
  Locations.find({}, {sort: {number: 1}})

Template.locations.viewableByRole = ->
  allowedRoles = ['admin', 'token']
  if this.orderPermission
    allowedRoles.push 'order'
  if this.inventoryPermission
    allowedRoles.push 'inventory'

  user = Meteor.user()
  return orderPerms = Roles.userIsInRole(user, allowedRoles)

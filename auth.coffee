if Meteor.isServer
  Meteor.startup ->
    if Meteor.users.findOne "X4q93mBxAQgLeFbcn"
      Roles.addUsersToRoles "X4q93mBxAQgLeFbcn", ["admin"]

if Meteor.isClient
  Template.adminTemplate.helpers
    isAdminUser: ->
      Roles.userIsInRole Meteor.user(), ['admin']

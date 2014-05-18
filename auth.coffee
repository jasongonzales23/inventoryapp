Accounts.config
  forbidClientAccountCreation: true

if Meteor.isServer
  Meteor.startup ->
    debugger
    if Meteor.users.findOne "XByGMdGpCcZhxfask"
      Roles.addUsersToRoles "XByGMdGpCcZhxfask", ["admin"]

if Meteor.isClient
  Template.adminTemplate.helpers
    isAdminUser: ->
      Roles.userIsInRole Meteor.user(), ['admin']

  Accounts.ui.config
    passwordSignupFields: 'USERNAME_ONLY'

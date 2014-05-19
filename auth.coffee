Accounts.config
  forbidClientAccountCreation: true

if Meteor.isServer
  Meteor.startup ->
    if Meteor.users.findOne "XByGMdGpCcZhxfask"
      Roles.addUsersToRoles "XByGMdGpCcZhxfask", ["admin"]
    if Meteor.users.findOne "koCBNkXkuKT8oScX6"
      Roles.addUsersToRoles "koCBNkXkuKT8oScX6", ["admin"]

if Meteor.isClient
  Template.adminTemplate.helpers
    isAdminUser: ->
      Roles.userIsInRole Meteor.user(), ['admin']

  Accounts.ui.config
    passwordSignupFields: 'USERNAME_ONLY'

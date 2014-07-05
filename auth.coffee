Accounts.config
  forbidClientAccountCreation: true

if Meteor.isServer
  Meteor.startup ->
    if Meteor.users.findOne "XByGMdGpCcZhxfask"
      Roles.addUsersToRoles "XByGMdGpCcZhxfask", ["admin"]
    if Meteor.users.findOne "8u54qnNyk9GotXGEj"
      Roles.addUsersToRoles "8u54qnNyk9GotXGEj", ["admin"]
    if Meteor.users.findOne "wpx9kEjXDX98J7khE"
      Roles.addUsersToRoles "wpx9kEjXDX98J7khE", ["admin"]

if Meteor.isClient
  Template.adminTemplate.helpers
    isAdminUser: ->
      Roles.userIsInRole Meteor.user(), ['admin']

  Accounts.ui.config
    passwordSignupFields: 'USERNAME_ONLY'

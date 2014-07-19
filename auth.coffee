Accounts.config
  forbidClientAccountCreation: false

if Meteor.isServer
  Meteor.startup ->
    if Meteor.users.findOne "XByGMdGpCcZhxfask"
      Roles.addUsersToRoles "XByGMdGpCcZhxfask", ["admin"]
    if Meteor.users.findOne "8u54qnNyk9GotXGEj"
      Roles.addUsersToRoles "8u54qnNyk9GotXGEj", ["admin"]
    if Meteor.users.findOne "wpx9kEjXDX98J7khE"
      Roles.addUsersToRoles "wpx9kEjXDX98J7khE", ["admin"]
    if Meteor.users.findOne "7sYEg2Fc3yzGm2cMe"
      Roles.addUsersToRoles "7sYEg2Fc3yzGm2cMe", ["admin"]

if Meteor.isClient
  Template.adminTemplate.helpers
    isAdminUser: ->
      Roles.userIsInRole Meteor.user(), ['admin']

  Accounts.ui.config
    passwordSignupFields: 'USERNAME_ONLY'

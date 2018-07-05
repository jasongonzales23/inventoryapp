Accounts.config
  forbidClientAccountCreation: false

if Meteor.isServer
  Meteor.startup ->
    #
    # XXX do this when you blow away admin
    # run meteor then in another term
    # meteor mongo
    # then db.users.remove({})
    # db.roles.remove({})
    #
    # uncomment code below and start meteor
    # recomment the code below so it doesnt try to make more admins
    # everytime you restart
    #
    #id = Accounts.createUser({
    #  username: 'admin'
    #  password: 'admin'
    #  profile: { name: 'admin' }
    #})
    #Roles.addUsersToRoles(id, ['admin'])

if Meteor.isClient
  Template.adminTemplate.helpers
    isAdminUser: ->
      Roles.userIsInRole Meteor.user(), ['admin']

  Accounts.ui.config
    passwordSignupFields: 'USERNAME_ONLY'

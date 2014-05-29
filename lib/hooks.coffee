if Meteor.isClient
  Meteor.startup ->
    Hooks.init()
  Hooks.onLoggedIn = ->
    Router.go '/'
  Hooks.onLoggedOut = ->
    Router.go '/'

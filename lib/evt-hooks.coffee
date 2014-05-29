if Meteor.isClient
  Meteor.startup ->
    Hooks.init()

if Meteor.isClient
  Hooks.onLoggedIn = ->
    Router.go '/'
  Hooks.onLoggedOut = ->
    Router.go '/'

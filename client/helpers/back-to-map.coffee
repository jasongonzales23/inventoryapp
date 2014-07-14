UI.registerHelper "backToMap", ->
  network = Meteor.status()
  if network.connected
    backToMap =
      class: ""
  else
    backToMap =
      class: "hidden"

UI.registerHelper "backMenu", ->
  if Session.get 'backMenu'
    backMenu =
      available: true
  else
    backMenu =
      available: false

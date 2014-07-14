UI.registerHelper "backToMap", ->
  network = Meteor.status()
  if network.connected
    backToMap =
      class: ""
  else
    backToMap =
      class: "hidden"

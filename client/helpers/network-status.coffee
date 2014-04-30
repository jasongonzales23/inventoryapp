UI.registerHelper "networkStatus", ->
  network = Meteor.status()
  if network.connected
    networkStatus =
      class: "label-success"
      text: "Connected"
  else
    networkStatus =
      class: "label-danger"
      text: "Offline"

   


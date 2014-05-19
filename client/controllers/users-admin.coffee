Template.usersAdmin.events
  "click .add-user": (evt, templ) ->
    username = templ.find('#username').value
    password = templ.find('#password').value

    Meteor.call('create_user', username, password)

Template.usersAdmin.users = ->
  Meteor.users.find()

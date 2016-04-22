install meteorite
`npm install -g meteorite`

`mrt install`

Create a user

`Meteor.call('create_user', 'admin', 'password')`

then get the id of that user
`Meteor.users.find().fetch()`

Copy that id into one of the examples in auth.coffee, restart meteor. You've an admin and should be able to get started.

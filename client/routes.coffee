Router.configure(
  layoutTemplate: 'layout'
)

Router.map(->
  @.route 'home',
    path: '/'
    template: 'home'

  @.route 'beverages',
    path: '/beverages'
    template: 'bevlist'

  @.route 'beveragesAdd',
    path: '/beverages/add'
    template: 'bevAdd'

  @.route 'inventory',
    path: '/inventory'
    template: 'inventory'

  @.route 'location',
    path: '/location/:_id',
    template: 'location',
    data: ()->
      _id = @.params._id
      templateData = {
        _id: _id
        inventory: Inventories.find({ location: _id })
      }
)

Template.bevlist.beverages = ->
  Beverages.find()

#TODO use enter key to submit
Template.bevAdd.events "click #beverageAdd": (evt, templ) ->
  input = templ.find("#beverageText")
  name = input.value
  input.value = ""
  Beverages.insert name: name

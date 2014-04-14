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
    template: 'addBeverages'

  @.route 'inventory',
    path: '/inventory'
    template: 'inventory'

  @.route 'locationAdd',
    path: '/admin/locations/add'
    template: 'locationAdd'

  @.route 'locations',
    path: '/locations'
    template: 'locations'

  @.route 'location',
    path: '/locations/:_id',
    template: 'location',
    data: ()->
      id = @.params._id
      templateData = {
        location: Locations.findOne(id)
      }
)


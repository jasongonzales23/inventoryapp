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

  @.route 'inventory',
    path: '/inventory'
    template: 'inventory'

  @.route 'beveragesAdd',
    path: '/_admin/beverages/add'
    template: 'addBeverages'

  @.route 'locationAdd',
    path: '/_admin/locations/add'
    template: 'locationAdd'

  @.route 'locations',
    path: '/locations'
    template: 'locations'

  @.route 'adminLocation',
    path: '/_admin/locations/:_id',
    template: 'adminLocation',
    data: ()->
      templateData = {
        location: Locations.findOne(this.params._id)
      }
)


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

  @.route 'locationAdd',
    path: '/location/add'
    template: 'locationAdd'

  @.route 'locations',
    path: '/locations'
    template: 'locations'

  @.route 'location',
    path: '/location/:number',
    template: 'location',
    data: ()->
      number = @.params.number
      templateData = {
        location: Locations.findOne({ number: number })
        inventory: Inventories.find({ location: number })
      }
)


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

  @.route 'adminLocation',
    path: '/_admin/locations/:_id',
    template: 'adminLocation',
    data: ()-> Locations.findOne(this.params._id)

  @.route 'locations',
    path: '/locations'
    template: 'locations'
    layoutTemplate: 'otherlayout'

  @.route 'location',
    path: '/locations/:_id'
    template: 'location'
    layoutTemplate: 'otherlayout'
    data: ()-> Locations.findOne(this.params._id)

  @.route 'updateInventory',
    path: '/locations/:_id/update-inventory'
    template: 'updateInventory'
    layoutTemplate: 'otherlayout'
    data: ()-> Locations.findOne(this.params._id)

)

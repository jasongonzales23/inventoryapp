Router.configure(
  layoutTemplate: 'home'
)

Router.map(->
  @.route 'home',
    path: '/'
    template: 'locations'

  @.route 'beverages',
    path: '/beverages'
    template: 'bevlist'

  @.route 'inventory',
    path: '/inventory'
    template: 'inventory'

  @.route 'admin',
    path: '/_admin'
    template: '_adminHome'
    layoutTemplate: '_admin'

  @.route 'beveragesAdd',
    path: '/_admin/beverages/add'
    template: 'addBeverages'
    layoutTemplate: '_admin'

  @.route 'locationAdd',
    path: '/_admin/locations/add'
    template: 'addLocations'
    layoutTemplate: '_admin'

  @.route 'adminLocation',
    path: '/_admin/locations/:_id',
    template: 'adminLocation',
    layoutTemplate: '_admin'
    data: ()-> Locations.findOne(this.params._id)

  @.route 'locations',
    path: '/locations'
    template: 'locations'
    layoutTemplate: 'home'

  @.route 'location',
    path: '/locations/:_id'
    template: 'location'
    layoutTemplate: 'locationLayout'
    data: ()-> Locations.findOne(this.params._id)

  @.route 'updateInventory',
    path: '/locations/:_id/update-inventory'
    template: 'updateInventory'
    layoutTemplate: 'locationLayout'
    data: ()-> Locations.findOne(this.params._id)

  @.route 'inventoryHistory',
    path: '/locations/:_id/inventory-history'
    template: 'inventoryHistory'
    layoutTemplate: 'locationLayout'
    data: ()-> Locations.findOne(this.params._id)

  @.route 'startingInventory',
    path: '/locations/:_id/starting-inventory'
    template: 'startingInventory'
    layoutTemplate: 'locationLayout'
    data: ()-> Locations.findOne(this.params._id)

  @.route 'recordOrder',
    path: '/locations/:_id/record-order'
    template: 'recordOrder'
    layoutTemplate: 'locationLayout'
    data: ()-> Locations.findOne(this.params._id)

  @.route 'orderHistory',
    path: '/locations/:_id/order-history'
    template: 'orderHistory'
    layoutTemplate: 'locationLayout'
    data: ()-> Locations.findOne(this.params._id)

  @.route 'addNote',
    path: '/locations/:_id/add-note'
    template: 'addNote'
    layoutTemplate: 'locationLayout'
    data: ()-> Locations.findOne(this.params._id)

  @.route 'showNotes',
    path: '/locations/:_id/notes'
    template: 'showNotes'
    layoutTemplate: 'locationLayout'
    data: ()-> Locations.findOne(this.params._id)

  @.route 'dashboardInventory',
    path: '/dashboard/inventory'
    template: 'dashboardInventory'
    layoutTemplate: 'dashboardLayout'

  @.route 'dashboardOrders',
    path: '/dashboard/orders'
    template: 'dashboardOrders'
    layoutTemplate: 'dashboardLayout'

  @.route 'dashboardNotes',
    path: '/dashboard/notes'
    template: 'dashboard'
    layoutTemplate: 'dashboardLayout'
   
  @.route 'dashboardVendors',
    path: '/dashboard'
    template: 'dashboard'
    layoutTemplate: 'dashboardLayout'
)

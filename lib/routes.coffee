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
    data: -> Locations.findOne(this.params._id)

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
    data: -> Locations.findOne(this.params._id)

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

  @.route 'dashboard',
    action: ->
      @.redirect 'dashboardInventory'

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
    template: 'dashboardNotes'
    layoutTemplate: 'dashboardLayout'

  @.route 'dashboardVendors',
    path: '/dashboard/vendors'
    template: 'dashboardVendors'
    layoutTemplate: 'dashboardLayout'

  @.route 'latestInventories',
    path: '/reports/latest-inventories'
    template: 'latestInventories'
    layoutTemplate: 'reportsLayout'

  @.route 'latestOrders',
    path: '/reports/latest-orders'
    template: 'latestOrders'
    layoutTemplate: 'reportsLayout'

  @.route 'unfilledOrders',
    path: '/reports/unfilled-orders'
    template: 'unfilledOrders'
    layoutTemplate: 'reportsLayout'

  @.route 'admin',
    path: '/admin'
    template: '_adminHome'
    layoutTemplate: 'admin'
    onBeforeAction: ->
      if Meteor.loggingIn()
        this.render this.loadingTemplate
      else if not Roles.userIsInRole Meteor.user(), ['admin']
        console.log 'redirecting'
        this.redirect '/'

  @.route 'beveragesAdd',
    path: '/admin/beverages/add'
    template: 'addBeverages'
    layoutTemplate: 'admin'
    onBeforeAction: ->
      if Meteor.loggingIn()
        this.render this.loadingTemplate
      else if not Roles.userIsInRole Meteor.user(), ['admin']
        console.log 'redirecting'
        this.redirect '/'

  @.route 'locationAdd',
    path: '/admin/locations/add'
    template: 'addLocations'
    layoutTemplate: 'admin'
    onBeforeAction: ->
      if Meteor.loggingIn()
        this.render this.loadingTemplate
      else if not Roles.userIsInRole Meteor.user(), ['admin']
        console.log 'redirecting'
        this.redirect '/'

  @.route 'adminLocation',
    path: '/admin/locations/:_id'
    template: 'adminLocation'
    layoutTemplate: 'admin'
    data: ()-> Locations.findOne(this.params._id)
    onBeforeAction: ->
      if Meteor.loggingIn()
        this.render this.loadingTemplate
      else if not Roles.userIsInRole Meteor.user(), ['admin']
        console.log 'redirecting'
        this.redirect '/'

  @.route 'adminUsersCreate',
    path: '/admin/users/create'
    template: 'usersAdmin'
    layoutTemplate: 'admin'
    onBeforeAction: ->
      if Meteor.loggingIn()
        this.render this.loadingTemplate
      else if not Roles.userIsInRole Meteor.user(), ['admin']
        console.log 'redirecting'
        this.redirect '/'

  @.route 'adminUsersManage',
    path: '/admin/users/manage'
    template: 'accountsAdmin'
    layoutTemplate: 'admin'
    onBeforeAction: ->
      if Meteor.loggingIn()
        this.render this.loadingTemplate
      else if not Roles.userIsInRole Meteor.user(), ['admin']
        console.log 'redirecting'
        this.redirect '/'
)

Router.configure(
  layoutTemplate: 'homeLayout'
  templateNameConverter: 'upperCamelCase'
  routeControllerNameConverter: 'upperCamelCase'
  loadingTemplate: 'loading'
  #notFoundTemplate: 'notFound'
)

Router.onBeforeAction('loading')

Router.map(->
  @.route 'home',
    path: '/'
    template: 'home'
    layoutTemplate: 'homeLayout'

  @.route 'allLocations',
    path: '/locations'
    template: 'locations'
    layoutTemplate: 'homeLayout'

  @.route 'location',
    path: '/locations/:_id'
    template: 'location'
    layoutTemplate: 'locationLayout'
    data: ()-> 
      Session.set 'backMenu', true
      Locations.findOne(this.params._id)

  @.route 'updateInventory',
    path: '/locations/:_id/update-inventory'
    template: 'updateInventory'
    layoutTemplate: 'locationLayout'
    data: -> 
      Session.set 'backMenu', false
      Locations.findOne(this.params._id)

  @.route 'inventoryHistory',
    path: '/locations/:_id/inventory-history'
    template: 'inventoryHistory'
    layoutTemplate: 'locationLayout'
    data: ()-> 
      Session.set 'backMenu', true
      Locations.findOne(this.params._id)

  @.route 'startingInventory',
    path: '/locations/:_id/starting-inventory'
    template: 'startingInventory'
    layoutTemplate: 'locationLayout'
    data: ()-> 
      Session.set 'backMenu', true
      Locations.findOne(this.params._id)

  @.route 'recordOrder',
    path: '/locations/:_id/record-order'
    template: 'recordOrder'
    layoutTemplate: 'locationLayout'
    data: -> 
      Session.set 'backMenu', false
      Locations.findOne(this.params._id)

  @.route 'orderHistory',
    path: '/locations/:_id/order-history'
    template: 'orderHistory'
    layoutTemplate: 'locationLayout'
    data: ()-> 
      Session.set 'backMenu', true
      Locations.findOne(this.params._id)

  @.route 'addNote',
    path: '/locations/:_id/add-note'
    template: 'addNote'
    layoutTemplate: 'locationLayout'
    data: ()-> 
      Session.set 'backMenu', false
      Locations.findOne(this.params._id)

  @.route 'showNotes',
    path: '/locations/:_id/notes'
    template: 'showNotes'
    layoutTemplate: 'locationLayout'
    data: ()-> 
      Session.set 'backMenu', true
      Locations.findOne(this.params._id)

  @.route 'tokenLocations',
    path: '/token-locations'
    template: 'tokenLocations'
    layoutTemplate: 'homeLayout'

  @.route 'showTokenCollections',
    path: '/locations/:_id/tokens/collections/show'
    template: 'showTokenCollections'
    layoutTemplate: 'tokenLocationLayout'
    data: ()->
      Session.set 'backMenu', true
      Locations.findOne(this.params._id)

  @.route 'addTokenCollection',
    path: '/locations/:_id/tokens/collections/add'
    template: 'addTokenCollection'
    layoutTemplate: 'tokenLocationLayout'
    data: ()->
      Session.set 'backMenu', false
      Locations.findOne(this.params._id)

  @.route 'showTokenLocationNotes',
    path: '/locations/:_id/tokens/notes/show'
    template: 'showTokenLocationNotes'
    layoutTemplate: 'tokenLocationLayout'
    data: ()->
      Session.set 'backMenu', true
      Locations.findOne(this.params._id)

  @.route 'addTokenLocationNote',
    path: '/locations/:_id/tokens/notes/add'
    template: 'addTokenLocationNote'
    layoutTemplate: 'tokenLocationLayout'
    data: ()->
      Session.set 'backMenu', false
      Locations.findOne(this.params._id)

  @.route 'boothLocations',
    path: '/booth-locations'
    template: 'boothLocations'
    layoutTemplate: 'homeLayout'

  @.route 'showTokenDeliveries',
    path: '/booth-locations/:_id/tokens/deliveries/show'
    template: 'showTokenDeliveries'
    layoutTemplate: 'tokenBoothLayout'
    data: ()-> 
      Session.set 'backMenu', true
      TokenBooths.findOne(this.params._id)

  @.route 'addTokenDelivery',
    path: '/booth-locations/:_id/tokens/deliveries/add'
    template: 'addTokenDelivery'
    layoutTemplate: 'tokenBoothLayout'
    data: ()-> 
      Session.set 'backMenu', false
      TokenBooths.findOne(this.params._id)

  @.route 'showBoothNotes',
    path: '/booth-locations/:_id/tokens/notes/show'
    template: 'showBoothNotes'
    layoutTemplate: 'tokenLocationLayout'
    data: ()-> 
      Session.set 'backMenu', true
      TokenBooths.findOne(this.params._id)

  @.route 'addBoothNote',
    path: '/booth-locations/:_id/tokens/notes/add'
    template: 'addBoothNote'
    layoutTemplate: 'tokenLocationLayout'
    data: ()->
      Session.set 'backMenu', false
      TokenBooths.findOne(this.params._id)

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
    template: 'adminHome'
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

  @.route 'tokenBoothAdd',
    path: '/admin/token-booths/add'
    template: 'tokenBoothAdd'
    layoutTemplate: 'admin'
    onBeforeAction: ->
      if Meteor.loggingIn()
        this.render this.loadingTemplate
      else if not Roles.userIsInRole Meteor.user(), ['admin']
        console.log 'redirecting'
        this.redirect '/'

  @.route 'daily',
    path: '/report/:year/:month/:day'
    waitOn: ->
      Meteor.subscribe 'orders'
    template: 'Daily'
    layoutTemplate: 'report'
    data: ->
      Session.set 'locationPathname', window.location.pathname
      dailyParams = {}
      dailyParams.year = this.params.year
      dailyParams.month = this.params.month
      dailyParams.day = this.params.day
      Session.set 'dailyParams', dailyParams
    onStop: ->
      Session.set 'locationPathname', ''

  @.route 'reportTotal',
    path: '/report/total'
    waitOn: ->
      Meteor.subscribe 'orders'
    template: 'reportTotal'
    layoutTemplate: 'report'

  @.route 'tokenCollectionReport',
    path: '/report/token/collection'
    template: 'tokenCollectionReport'
    layoutTemplate: 'tokenReport'

  @.route 'tokenDeliveryReport',
    path: '/report/token/delivery'
    template: 'tokenDeliveryReport'
    layoutTemplate: 'tokenReport'

  @.route 'tokenReconciliationReport',
    path: '/report/token/reconcilation'
    template: 'tokenReconciliationReport'
    layoutTemplate: 'tokenReport'

  @.route 'vendorReport',
    path: '/report/vendors'
    template: 'vendorReport'
    layoutTemplate: 'report'

  @.route 'inventorySummaryAll',
    path: '/report/inventory-summary/all'
    template: 'inventorySummaryAll'
    layoutTemplate: 'inventorySummary'

  @.route 'inventorySummaryLocations',
    path: '/report/inventory-summary/locations'
    template: 'inventorySummaryLocations'
    layoutTemplate: 'inventorySummary'

  @.route 'tokenMap',
    path: '/tokenMap'
    template: 'tokenMap'

  @.route 'rotaryMap',
    path: '/rotaryMap'
    template: 'rotaryMap'
)
Template.orderHistory.orders = ->
  Orders.find({"location": this._id}, {sort: {timestamp: -1}})

Template.orderHistory.events
  "click .order-sent": (evt, templ) ->
    delivered = !this.delivered
    Meteor.call('update_delivered_status', this._id, delivered)

Template.deliveredButton.sent = ->
  if this.delivered then "true" else "false"


Template.orderHistory.orders = ->
  Orders.find({"location": this._id}, {sort: {timestamp: -1}})

Template.orderHistory.events
  "click .order-sent": (evt, templ) ->
    target = evt.target
    @delivered = !@delivered
    target.textContent = (if @delivered then "true" else "false")

    Meteor.call('update_delivered_status', @_id, @delivered)

Template.deliveredButton.sent = ->
  if @delivered then "true" else "false"

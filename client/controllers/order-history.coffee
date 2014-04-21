Template.orderHistory.orders = ->
  Orders.find({"location": this._id}, {sort: {timestamp: -1}})


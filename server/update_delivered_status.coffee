Meteor.methods({
  update_delivered_status: (bev_id, delivered) ->
    parentOrder = Orders.findOne({'beverages._id': bev_id }, {'beverages.$': 1})
    Orders.update(
      { _id: parentOrder._id, 'beverages._id': bev_id }
      {$set: {'beverages.$.delivered': delivered}}
    )
  })

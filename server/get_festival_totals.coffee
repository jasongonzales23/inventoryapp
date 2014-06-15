Meteor.publish 'get_festival_totals', ()->
  #totals = [{ name: 'thing' }, {name: 'thing2'}]
  Beverages.find({}, {sort: {name: 1}}).fetch()

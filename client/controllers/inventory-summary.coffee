Template.inventorySummaryAll.summaryRow = ->
  beverages = Beverages.find({}, {sort: {name: 1}}).fetch()
  console.log(beverages)
  return beverages


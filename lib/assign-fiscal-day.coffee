Meteor.myFunctions = {
  assignFiscalDay: (time) ->
    debugger
    t = moment(time)
    if t.hour() <= 3
      t.subtract("day", 1).valueOf()
    else
      time
}

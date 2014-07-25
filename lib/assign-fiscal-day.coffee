Meteor.myFunctions = {
  assignFiscalDay: (time) ->
    t = moment(time)
    if t.hour() <= 3
      t.substract("day", 1).valueOf()
    else
      time
}

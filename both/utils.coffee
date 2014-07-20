(->
  ###
  Decimal adjustment of a number.

  @param  {String}  type  The type of adjustment.
  @param  {Number}  value The number.
  @param  {Integer} exp   The exponent (the 10 logarithm of the adjustment base).
  @returns  {Number}      The adjusted value.
  ###
  decimalAdjust = (type, value, exp) ->

    # If the exp is undefined or zero...
    return Math[type](value)  if typeof exp is "undefined" or +exp is 0
    value = +value
    exp = +exp
    
    # If the value is not a number or the exp is not an integer...
    return NaN  if isNaN(value) or not (typeof exp is "number" and exp % 1 is 0)
    
    # Shift
    value = value.toString().split("e")
    value = Math[type](+(value[0] + "e" + ((if value[1] then (+value[1] - exp) else -exp))))
    
    # Shift back
    value = value.toString().split("e")
    +(value[0] + "e" + ((if value[1] then (+value[1] + exp) else exp)))
  
  # Decimal round
  unless Math.round10
    Math.round10 = (value, exp) ->
      decimalAdjust "round", value, exp
  
  # Decimal floor
  unless Math.floor10
    Math.floor10 = (value, exp) ->
      decimalAdjust "floor", value, exp
  
  # Decimal ceil
  unless Math.ceil10
    Math.ceil10 = (value, exp) ->
      decimalAdjust "ceil", value, exp
  return
)()

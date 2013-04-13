app.filter 'startFrom', ->
  (input, start) ->
    if input? and start? and typeof start is 'number'
      start = +start
      input.slice(start)


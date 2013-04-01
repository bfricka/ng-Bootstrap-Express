# This is really just an interaction wrapper for amplify
# I prefer this syntax for interacting with storage.

class Stor
  # Constructor sets defaults for amplify
  # and optionally for expiration and key
  constructor: (key, exp) ->
    @key = if key? then key else undefined
    @exp = if exp? then exp else null
    @amp = amplify.store
  get: (key = @key) ->
    @amp(key)
  set: (val, key = @key, exp = @exp) ->
    @amp(key, val, { expiration: exp })
  remove: (key = @key) ->
    @amp(key, null)
  empty: ->
    self = @
    storage = self.amp()
    _.each storage, (itm, key) ->
      self.amp(key, null)
__ = require 'lodash'

setOptions = (opts) ->
  defaults =
    title: "My App"
    ctrl: "MainAppCtrl"
    app: "app"

  __.extend defaults, opts

exports.four_oh_four = (req, res) ->
  res.status 404

  title = '404 Not Found'

  if req.accepts('html')
    res.render '404', setOptions { title: title, app: null, ctrl: null }
  else if req.accepts('json')
    res.send { error: title }
  else
    res.type('txt').send title

  return

exports.home = (req, res) ->
  opts = setOptions()
  res.render 'home', opts
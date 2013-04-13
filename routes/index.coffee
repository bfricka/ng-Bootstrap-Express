__ = require 'lodash'
p = require '../express/page-info'

setOptions = (opts) ->
  defaults = p.defaults

  __.extend defaults, opts

exports.four_oh_four = (req, res) ->
  res.status 404

  opts = setOptions p.info['four_oh_four']

  if req.accepts('html')
    res.render '404', opts
  else if req.accepts('json')
    res.send { error: opts.title }
  else
    res.type('txt').send opts.title

  return

exports.home = (req, res) ->
  opts = setOptions p.info.home
  res.render 'home', opts
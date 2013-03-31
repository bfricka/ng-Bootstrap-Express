express = require 'express'
routes  = require './routes'
http    = require 'http'
less    = require 'less-middleware'
app     = express()

app.locals.env = app.get('env')

###
Begin config
###
app.configure ->
  app.set 'port', 3000
  app.set 'views', "#{__dirname}/views"
  app.set 'view engine', 'jade'

  # Enable Gzip
  app.use express.compress()
  # Enable utility middleware
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router

  app.use less
    src: "#{__dirname}/public"
    compress: true

  # Use static cache for now until I find something better
  app.use express.static("#{__dirname}/public")

  # Fall-through 404
  app.use routes.four_oh_four

  return

###
Begin Routes
###

app.get '/', routes.home

###
Init
###
http
.createServer(app)
.listen app.get('port'), ->
  console.log "Server started on port #{app.get('port')}."
express = require 'express'
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
  app.use (req, res) ->
    res.status(404)

    title = '404 Not Found'

    if req.accepts('html')
      res.render "404", { title: title, app: '' }
    else if req.accepts('json')
      res.send { error: title }
    else
      res.type('txt').send title

  return

###
Begin Routes
###

app.get '/', (req, res) ->
  opts =
    title: 'Project'
    ctrl: 'MainAppCtrl'
    app: 'app'

  res.render 'home', opts

###
Init
###
http
.createServer(app)
.listen app.get('port'), ->
  console.log "Server started on port #{app.get('port')}."
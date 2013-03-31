(function() {
  var app, express, http, less, routes;

  express = require('express');

  routes = require('./routes');

  http = require('http');

  less = require('less-middleware');

  app = express();

  app.locals.env = app.get('env');

  /*
  Begin config
  */


  app.configure(function() {
    app.set('port', 3000);
    app.set('views', "" + __dirname + "/views");
    app.set('view engine', 'jade');
    app.use(express.compress());
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
    app.use(less({
      src: "" + __dirname + "/public",
      compress: true
    }));
    app.use(express["static"]("" + __dirname + "/public"));
    app.use(routes.four_oh_four);
  });

  /*
  Begin Routes
  */


  app.get('/', routes.home);

  /*
  Init
  */


  http.createServer(app).listen(app.get('port'), function() {
    return console.log("Server started on port " + (app.get('port')) + ".");
  });

}).call(this);

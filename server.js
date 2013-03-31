(function() {
  var app, express, http, less, setOptions, __;

  express = require('express');

  http = require('http');

  less = require('less-middleware');

  __ = require('lodash');

  app = express();

  app.locals.env = app.get('env');

  setOptions = function(opts) {
    var defaults;

    defaults = {
      title: "My App",
      ctrl: "MainAppCtrl",
      app: "app"
    };
    return __.extend(defaults, opts);
  };

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
    app.use(function(req, res) {
      var title;

      res.status(404);
      title = '404 Not Found';
      if (req.accepts('html')) {
        return res.render("404", setOptions({
          title: title,
          app: null,
          ctrl: null
        }));
      } else if (req.accepts('json')) {
        return res.send({
          error: title
        });
      } else {
        return res.type('txt').send(title);
      }
    });
  });

  /*
  Begin Routes
  */


  app.get('/', function(req, res) {
    var opts;

    opts = setOptions();
    return res.render('home', opts);
  });

  /*
  Init
  */


  http.createServer(app).listen(app.get('port'), function() {
    return console.log("Server started on port " + (app.get('port')) + ".");
  });

}).call(this);

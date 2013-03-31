(function() {
  var setOptions, __;

  __ = require('lodash');

  setOptions = function(opts) {
    var defaults;

    defaults = {
      title: "My App",
      ctrl: "MainAppCtrl",
      app: "app"
    };
    return __.extend(defaults, opts);
  };

  exports.four_oh_four = function(req, res) {
    var title;

    res.status(404);
    title = '404 Not Found';
    if (req.accepts('html')) {
      res.render('404', setOptions({
        title: title,
        app: null,
        ctrl: null
      }));
    } else if (req.accepts('json')) {
      res.send({
        error: title
      });
    } else {
      res.type('txt').send(title);
    }
  };

  exports.home = function(req, res) {
    var opts;

    opts = setOptions();
    return res.render('home', opts);
  };

}).call(this);

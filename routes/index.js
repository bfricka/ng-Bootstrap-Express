(function() {
  var p, setOptions, __;

  __ = require('lodash');

  p = require('../express/page-info');

  setOptions = function(opts) {
    var defaults;

    defaults = p.defaults;
    return __.extend(defaults, opts);
  };

  exports.four_oh_four = function(req, res) {
    var opts;

    res.status(404);
    opts = setOptions(p.info['four_oh_four']);
    if (req.accepts('html')) {
      res.render('404', opts);
    } else if (req.accepts('json')) {
      res.send({
        error: opts.title
      });
    } else {
      res.type('txt').send(opts.title);
    }
  };

  exports.home = function(req, res) {
    var opts;

    opts = setOptions(p.info.home);
    return res.render('home', opts);
  };

}).call(this);

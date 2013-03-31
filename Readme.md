## ng-Bootstrap-Express

### Overview

This is just my boilerplate amalgamation for creating responsive single page apps.  It's a beautiful way to start things out right!

### What's Inside?

* Server backend: [express](http://expressjs.com/)
* Base template: [Twitter Bootstrap](http://twitter.github.com/bootstrap/) with [LESS](http://lesscss.org/)
* MVC / Horsepower: [AngularJS](http://angularjs.org/)
* Some common useful AngularJS directives, and a [wrapper for Amplify.store](https://github.com/brian-frichette/ng-Bootstrap-Express/blob/master/public/coffeescripts/Stor.coffee) for an easy client-side persistence layer.
* Library Support:
    * [jQuery](http://jquery.com/)
    * [Lodash](http://lodash.com/)
    * [Amplify.store](http://amplifyjs.com)
* Feature detects: A stripped down version of [Modernizr](http://modernizr.com/download/#-fontface-backgroundsize-borderradius-boxshadow-opacity-rgba-textshadow-cssanimations-generatedcontent-cssgradients-csstransforms-csstransforms3d-csstransitions-hashchange-history-input-inputtypes-localstorage-sessionstorage-shiv-mq-cssclasses-teststyles-testprop-testallprops-hasevent-prefixes-domprefixes-css_backgroundsizecover-css_boxsizing-css_lastchild-json-load)
* Angular App structure for [CoffeeScript](http://coffeescript.org/)
* Task runner: [Grunt](http://gruntjs.com/) For building coffeescript, concatenating project files, linting, and minifying, etc.

### Installation

1. Make sure you have [Node](http://nodejs.org/) installed and in the command line go to the project directory: `$ npm install`
2. Run Grunt to get things compiled `$ grunt`
3. Start the server: `$ npm start`
4. Open a new CLI and start the Grunt watch task to automatically build and run tests when files change: `$ grunt watch`
5. Write awesome apps!

See the links to the tools above for documentation if you run into problems.

### Current Versions

* Bootstrap 2.3.1
* AngularJS 1.0.5
* jQuery 1.9.1
* Lodash 1.1.1
* Amplify.store 1.1.0
* Modernizr 2.6.2 w/ Respond 1.1.0
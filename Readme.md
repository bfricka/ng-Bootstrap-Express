# ng-Bootstrap-Express

## Overview

This is just my boilerplate amalgamation for creating responsive single page apps.  It's a beautiful way to start things out right!

## What's Inside?

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

## Installation

1. Make sure you have [Node](http://nodejs.org/) installed and in the command line go to the project directory: `$ npm install`
2. Run Grunt to get things compiled `$ grunt`
3. Start the server: `$ npm start`
4. Open a new CLI and start the Grunt watch task to automatically build and run tests when files change: `$ grunt watch`
5. Write awesome apps!

See the links to the tools above for documentation if you run into problems.

## Built-ins

There are a few built-in directives and components as mentioned above. This will give a brief overview.

### Stor - A wrapper for `amplify.store`

Stor is a very simple coffeescript `class` that wraps the amplify API.  I chose it because I like using storage instances with the get/set.

**Usage:**

*Setup an optional expiration*
```coffee
day = 8640000000
expiration = day * 10
```
*Create an instance of `Stor`. No args are required, if you'd like to use a single instance to manage multiple keys.*
```coffee
myStorage = new Stor 'storageKey', expiration
```
*Create some value...*
```coffee
myValue =
  "name": "David Foster Wallace"
  "occupation": "author"
```
*Cache the value. This will use the instance key `storageKey` and expiration we set.*
```coffee
myStorage.set myValue
```
*Get the value. **Note:** No need to pass params, since we're using instance variables.*
```coffee
myStorage.get()
# => {
#   "name": "David Foster Wallace",
#   "occupation": "author"
# }
```
*However, we can specify them if we want to use a single instance for all storage:*
```coffee
myStorage.set 'newKey', {"newObj": "newObjValue"}, 860000000

# No params, still gets the instance default
myStorage.get()
# => {
#   "name": "David Foster Wallace",
#   "occupation": "author"
# }

# Or specify the key
myStorage.get 'newKey'
# => {
#   "newObj": "newObjValue'"
# }
```
*Other methods:*
```coffee
# Remove an object from storage
myStorage.remove 'newKey'

# Empty storage completely
myStorage.empty()
```
***Note:*** *`amplify` will automatically stringify objects when using `Stor.set` and will parse them when using `Stor.get`*

### Directives
This project has a few simple directives that make AngularJS a bit friendlier.

***ngFocus & ngBlur*** - *Adds focus and blur events:*
```xml
<input type="text" ng-model="blurTest" ng-blur="blurFn()">
```
```coffee
$scope.blurFn = ->
  console.log $scope.blurTest

# Outputs value of input to console on blur
```
***ngFadeShow*** - *Works exactly as `ngShow` but uses jQuery's fade in/out instead. You could just as easily write an alias on this for `ngFadeHide` using negation, but I haven't added it:*

*Show the article by default*
```coffee
$scope.articleHidden = false
```
*Hides the article on click*
```xml
<article ng-fade-show="articleHidden" ng-click="articleHidden = !articleHidden">Hide Me</article>
```
### Filters

***startFrom*** - Slice models for easy pagination:

*Sample Controller:*
```coffee
$scope.items = [
  {name: John}
  # more data items...
]
# Set default start page
$scope.currentPage = 0

# Set number of items per page
$scope.perPage = 6

# Create fn to calculate
```
*Sample Markup:*
```xml
<ul>
  <li ng-repeat="item in items" ng-filter="startFrom: currentPage | limitTo: perPage"></li>
</ul>
<footer class="pagination">
  <button class="btn" ng-click="prev()" ng-disabled="currentPage == 0">&laquo;</button>
  <span class="pages">{{currentPage}} of {{items.length - 1}}</span>
  <button class="btn" ng-click="next()" ng-disabled="currentPage == items.length - 1">&raquo;</button>
</footer>
```

## Current Versions

* Bootstrap 2.3.1
* AngularJS 1.0.5
* jQuery 1.9.1
* Lodash 1.1.1
* Amplify.store 1.1.0
* Modernizr 2.6.2 w/ Respond 1.1.0
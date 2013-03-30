/*  - v0.0.0 - 
* Copyright (c) 2013 Brian Frichette. All rights reserved.
* Licensed MIT - http://opensource.org/licenses/MIT */
(function() {
  var app;

  app = angular.module('app', []);

  app.controller('MainAppCtrl', [
    '$scope', function($scope) {
      return $scope.title = "ng-Bootstrap";
    }
  ]);

}).call(this);

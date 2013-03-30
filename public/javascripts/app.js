(function() {
  var app;

  app = angular.module('app', []);

  app.controller('MainAppCtrl', [
    '$scope', function($scope) {
      return $scope.title = "ng-Bootstrap";
    }
  ]);

}).call(this);

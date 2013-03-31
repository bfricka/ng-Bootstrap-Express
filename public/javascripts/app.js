(function() {
  var app;

  app = angular.module('app', []);

  app.controller('MainAppCtrl', [
    '$scope', function($scope) {
      return $scope.title = "ng-Bootstrap";
    }
  ]);

  app.directive('fadeShow', function() {
    return function(scope, elem, attrs) {
      var $elem, duration, exp, fadeElem;

      $elem = $(elem);
      exp = attrs.fadeShow;
      duration = 400;
      fadeElem = function(toShow, init) {
        if (init == null) {
          init = false;
        }
        if (toShow) {
          $elem.fadeIn(duration);
        } else {
          if (init) {
            $elem.hide();
          } else {
            $elem.fadeOut(duration);
          }
        }
      };
      fadeElem(scope.$eval(exp), true);
      return scope.$watch(function() {
        return scope.$eval(exp);
      }, function(toShow) {
        return fadeElem(toShow);
      });
    };
  });

  app.directive('ngBlur', function() {
    return function(scope, elem, attrs) {
      return elem.on("blur", function() {
        scope.$apply(attrs.ngBlur);
      });
    };
  });

  app.directive('ngFocus', function() {
    return function(scope, elem, attrs) {
      return elem.on("focus", function() {
        scope.$apply(attrs.ngFocus);
      });
    };
  });

}).call(this);

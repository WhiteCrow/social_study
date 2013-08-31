'use strict';

/* App Module */

var myApp = angular.module('myApp', ['ngSanitize'], function($compileProvider) {
  $compileProvider.directive('compile', function($compile) {
    return function(scope, element, attrs) {
      scope.$watch(
        function(scope) {
        return scope.$eval(attrs.compile);
      },
      function(value) {
        element.html(value);
        $compile(element.contents())(scope);
      });
    };
  })
});
/*
myApp.config(['$routeProvider', function($routeProvider) {
  $routeProvider.
    when('./test', {templateUrl: Assets["entry_content"],   controller: EntryParser});
}]);*/



'use strict';

angular.module('thnkoutApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'thnkoutFilters'
])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .when('/output', {
        templateUrl: 'views/output.html',
        controller: 'OutputCtrl'
      })
      .when('/view', {
        templateUrl: 'views/view.html',
        controller: 'ViewCtrl'
      })
      .when('/mece', {
        templateUrl: 'views/mece.html',
        controller: 'MeceCtrl'
      })
      //.otherwise({
      //  redirectTo: '/'
      //});
  });

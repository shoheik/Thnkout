'use strict';

angular.module('thnkoutApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
  //'thnkoutFilters'
])
  .config(['$routeProvider', function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/top.html',
        controller: 'TopCtrl'
      })
      .when('/main/:themeID', {
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
      .when('/theme/:themeID', {
        templateUrl: 'views/theme.html',
        controller: 'ThemeCtrl'
      })
      .when('/information-collection/:themeID', {
        templateUrl: 'views/information-collection.html',
        controller: 'InformationCollectionCtrl'
      })
      //.otherwise({
      //  redirectTo: '/'
      //});
  }]);

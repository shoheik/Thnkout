'use strict';

angular.module('thnkoutApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'thnkoutFilters'
])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
        //controller: 'LoginCtrl',
        //resolve: {
        //    info: function(LoginCheck){
        //        console.log('here in resolve function');
        //        return LoginCheck.getLoginInfo();
        //    }
        //}
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
  });

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
      .when('/topic/:topicID', {
        templateUrl: 'views/topic.html',
        controller: 'TopicCtrl'
      })
      .when('/information-collection/:topicID', {
        templateUrl: 'views/information-collection.html',
        controller: 'InformationCollectionCtrl'
      })
      //.otherwise({
      //  redirectTo: '/'
      //});
  });

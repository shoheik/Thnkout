'use strict';

angular.module('thnkoutApp')
  .controller('MainCtrl', function ($scope, TopicGenerator) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];

    $scope.topics = TopicGenerator.getTopics();

  });

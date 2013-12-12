'use strict';

angular.module('thnkoutApp')
  .controller('MainCtrl', function ($scope, TopicGenerator) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
    $scope.topics = TopicGenerator.getTopics();
  })
  .controller('OutputCtrl', function ($scope) {
  })
  .controller('MeceCtrl', function ($scope) {

    // This is the dataset from server
    $scope.data = {
      topic :{
        name: "Become financial engineer",
        tag: [
          "finance",
          "engineering"
        ],
        strategies: {
          "SWOT": {
            description: "Strength, Weakness, Opportunity anad Threat",
            approaches: {
              Strength: [
                {
                  user: "kamesho",
                  thoughts: "relatively good salary",
                  last_update: "201312071100"
                },
                {
                  user: "user1",
                  thoughts: "experience of managing a large system",
                  last_update: "201312050800"
                }
              ],
              Weakness: [
                {
                  user: "kamesho",
                  thoughts: "worry about the layoff during recession",
                  last_update: "201312071100"
                }
              ],
              Opportunity:[
                {
                  user: "kamesho",
                  thoughts: "a few but it can be if you wish",
                  last_update: "201312071100"
                }
              ],
              Threat:[
                {
                  user: "kamesho",
                  thoughts: "totally depending on the economy",
                  last_update: "201312071100"
                }
              ]
            }
          },
          "5W1H":{
            description: "what, why,,,",
            approaches: {
              What: [],
              When: [],
              How: []
            }
          }
        }
      }
    }

    $scope.strategies = ["SWOT", "5W1H", "5W2H"];

    $scope.approaches = {
      "SWOT": ["Strength", "Weakness" , "Opportunity", "Threat"],
      "5W1H": ["What", "Where", "When", "Who", "How"],
      "5W2H": ["What", "Where", "When", "Who", "How", "How much"]
    };

    $scope.selectStrategy = function() {
      //alert($scope.strategy_name);
      //$scope.angles = group[$scope.strategy_name];
    };

    $scope.issues = ["issue1", "issue2"];
    $scope.output = {
      "Strenth": []
    };

    // need who and where
    $scope.send = function (output, strategy, approach){
      console.log(output);
      console.log(strategy);
      console.log(approach);
      var idea ={};
      idea.user = "kamesho";
      var d = new Date();
      idea.last_update = d.toString();
      idea.thoughts = output;

      if (typeof $scope.data.topic.strategies[strategy] === "undefined"){
        var apprch = {};
        apprch[approach] = [];
        $scope.data.topic.strategies[strategy] = { approaches : apprch };
      }else if (typeof $scope.data.topic.strategies[strategy].approaches[approach] === "undefined"){
        $scope.data.topic.strategies[strategy].approaches[approach] = [];
      }
      //console.log($scope.data.topic);
      console.log($scope.data.topic.strategies[strategy].approaches[approach]);
      $scope.data.topic.strategies[strategy].approaches[approach].unshift(idea);


    }

  })
  .controller('ViewCtrl', function ($scope, TopicGenerator) {
    $scope.topics = TopicGenerator.getTopics();
  });

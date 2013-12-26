'use strict';

angular.module('thnkoutApp')
  .controller('MainCtrl', function ($scope, ThemeGenerator, $location, $http) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];

    $scope.themes = ThemeGenerator.getThemes();

    $scope.createTheme = function(theme){
      console.log(theme);
      $http.post('/api/v1/theme', { theme: theme }).
      //$http({method: 'POST', url: '/api/v1/theme', data: JSON.stringify({theme_name: theme})})
      success(function(data,status,headers,config){
        console.log(data);
        $location.path("/theme/" + data.id);
      });
      //$location.path( "/theme" );
    };

  })
  .controller('OutputCtrl', function ($scope) {
  })
  // controler to colletion information for the thinking
  .controller('InformationCollectionCtrl', function ($scope, $resource, $routeParams) {

    $scope.collection = {};
    console.log($routeParams.themeID);
    var themeURL = '/api/v1/theme/' + $routeParams.themeID;
    var collectionURL = '/api/v1/information-collection/' + $routeParams.themeID;
    // here we get my info collection from server..
    var Collection = $resource(themeURL);
    Collection.get({}, function(res){
      $scope.name = res.name;
      if( typeof res.information_collection != "undefined"){
        $scope.collection = res.information_collection;
      }
    });

    // -------------------------------
    // add the point to the collection
    // -------------------------------
    $scope.addPointToCollection = function(sourceInput, pointInput){

      // sources doesn't exit (also, no points)
      if( typeof $scope.collection.sources === "undefined") {
        $scope.collection.sources = [
          {
            sourceName: sourceInput,
            points: [ pointInput]
          }
        ];
      // sources exists
      }else{
        var flag = 0;
        for(var i=0; i < $scope.collection.sources.length; i++){
          // sourceInput's name exists in collecton
          if ( sourceInput === $scope.collection.sources[i].sourceName){
            flag =1
            if ( typeof $scope.collection.sources[i].points === "undefined"){
              $scope.collection.sources[i].points = [ pointInput ];
            }else{
              $scope.collection.sources[i].points.push(pointInput);
            }
          }
        }
        if (flag === 0 ){
          $scope.collection.sources.push({
            sourceName: sourceInput,
            points: [ pointInput]
          })
        }
      }
    };

    // -------------------
    // Delete the points
    // -------------------
    $scope.deletePoint = function(sourceName, point){
      // implement the deletion here
      console.log(sourceName + ": " + point);
      for(var i=0; i< $scope.collection.sources.length; i++){
        if ($scope.collection.sources[i].sourceName === sourceName){
          for (var j=0; j<$scope.collection.sources[i].points.length; j++){
            if ($scope.collection.sources[i].points[j] === point){
              $scope.collection.sources[i].points.splice(j,1);
            }
          }
          if($scope.collection.sources[i].points.length === 0 ){
            $scope.collection.sources.splice(i,1);
          }
        }
      }
    }

    // -----
    //  Save
    // -----
    $scope.saveCollection = function(){
      // POST collection if new
      var infoCollection = $resource(collectionURL);
      infoCollection.save($scope.collection, function(res){
        console.log(res);
      });
    }

/*
    $scope.collection = {
      name: "abc",
      sources: [
        {
          sourceName: "source_title",
          points: [
            "point1",
            "point2"
          ]
        },
        {
          sourceName: "source_title2",
            points : [
              "point1",
              "point2"
            ]
        }
      ]
    };
*/

  })
  .controller('ThemeCtrl', function ($scope, $routeParams, $http) {

    // Get parameter on URL
    $scope.themeID = $routeParams.themeID
    var themeURL =  '/api/v1/theme/' + $routeParams.themeID;

    // GET /api/v1/theme/:themeID
    $http({method: 'GET', url: themeURL }).
    success(function(data, status, headers, config) {
      console.log(data);
      $scope.data.theme = data;
      // this callback will be called asynchronously
      // when the response is available
    }).
    error(function(data, status, headers, config) {
      // called asynchronously if an error occurs
      // or server returns response with an error status.
    });


    $scope.data = {
      theme :{
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

      if (typeof $scope.data.theme.strategies[strategy] === "undefined"){
        var apprch = {};
        apprch[approach] = [];
        $scope.data.theme.strategies[strategy] = { approaches : apprch };
      }else if (typeof $scope.data.theme.strategies[strategy].approaches[approach] === "undefined"){
        $scope.data.theme.strategies[strategy].approaches[approach] = [];
      }
      //console.log($scope.data.theme);
      console.log($scope.data.theme.strategies[strategy].approaches[approach]);
      $scope.data.theme.strategies[strategy].approaches[approach].unshift(idea);
    }

  })
  .controller('ViewCtrl', function ($scope, ThemeGenerator) {
    $scope.themes = ThemeGenerator.getThemes();
  });

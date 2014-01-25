'use strict';

angular.module('thnkoutApp')
.factory('Login', ['$http', '$rootScope', function ($http, $rootScope) {
    return {
        getInfo: function($scope){
            console.log('here in LoginCheck');
            $http({ method: 'GET', url: 'api/v1/login-info'}).
                success(function(data, status, headers, config) {
                    console.log(data);
                    if (data.status === "logged_in"){
                        $scope.loggedIn = true;
                        $rootScope.id = data.id;
                        $scope.screen_name = data.screen_name;
                        $scope.image_url = data.image_url;
                    }else{
                        $scope.loggedIn = false;
                        $rootScope.id = "anonymous";
                    }
                }).
                error(function(data, status, headers, config) {
                    $scope.loggedIn = false;
                    $rootScope.id = "anonymous";
                });
        }
    }
}]);

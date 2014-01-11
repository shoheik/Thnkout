'use strict';

angular.module('thnkoutApp')
.factory('ThemeHandler', function ($location, $http){
    return {
        create: function(theme){
            $http.post('/api/v1/theme', { theme: theme }).
            success(function(data,status,headers,config){
                console.log(data);
                $location.path("/main/");
            }).
            error(function(data,status,headers,config){
                alert("ERROR1: Applogies. Please try later");
                $location.path('/');
            });
        },

        getThemes: function(userID){
        },
    
        // GET /api/v1/theme/:themeID
        getTheme: function(themeID, scope){
            var themeURL =  '/api/v1/theme/' + themeID;
            $http({method: 'GET', url: themeURL }).
            success(function(data, status, headers, config) {
                scope.data = data;
            }).
            error(function(data, status, headers, config) {
                alert("ERROR2: Applogies. Please try later");
            });
        }

    }
});

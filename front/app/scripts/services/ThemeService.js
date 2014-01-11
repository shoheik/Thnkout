'use strict';

angular.module('thnkoutApp')
.factory('ThemeHandler', function ($location, $http){
    return {
        create: function(theme){
            $http.post('/api/v1/theme', { theme: theme }).
            success(function(data,status,headers,config){
                console.log(data);
                var url = "/main/" + data.id;
                $location.path(url);
            }).
            error(function(data,status,headers,config){
                alert("ERROR1: Applogies. Please try later");
                $location.path('/');
            });
        },

        // GET /api/v1/themes/userID - themes for the user 
        getThemes: function(userID, scope){
            var themesURL = '/api/v1/themes/' + userID;
            $http({method: 'GET', url: themesURL }).
            success(function(data, status, headers, config) {
                scope.themes = data;
            }).
            error(function(data, status, headers, config) {
                alert("ERROR3: Applogies. Please try later");
                $location.path('/');
            });
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

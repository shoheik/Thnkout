angular.module('thnkoutFilters', [])
    .filter('strategyFilter', function() {
        return function(input, strategy) {
            //console.log(strategy);
            //console.log(input);
            var filtered = [];
            for(var key in input){
                if (key === strategy){
                    filtered.push(input[key]);
                }
            }
            return filtered;
            //angular.forEach(input, function() {
            //    console.log(key);
            //    if (key == strategy){
            //        filtered.push(value);
            //    }
            //});
        };
    })
    //.filter('approachFilter',function(){
    //    return function(input, approach){
    //        var
    //    }
    //})
;

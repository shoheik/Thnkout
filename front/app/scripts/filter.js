angular.module('thnkoutFilters', [])
    .filter('strategyFilter', function() {
        return function(input, strategy) {
            //console.log(strategy);
            //console.log(input);
            var filtered = [];
            angular.forEach(input, function(item) {
                if (item.name == strategy){
                    filtered.push(item);
                }
                //console.log(item.name)
            });
            return filtered;
        };
    })
    //.filter('approachFilter',function(){
    //    return function(input, approach){
    //        var
    //    }
    //})
;

var app = angular.module('jobapp', ['ngRoute'])

.config(function ($routeProvider,$locationProvider,$httpProvider) {
  $routeProvider
    .when('/', {
      controller: 'rootController',
      templateUrl: '/templates/all.html'
    })
    .when('/county/:countyname', {
      controller: 'countyController',
      templateUrl: '/templates/counties.html'
    })
})


app.service('Opportunity', function($http, $q) {
  var opportunities = ['pa-philadelphia', 'pa-montgomery', 'pa-bucks', 'pa-chester', 'pa-delaware', 'nj-camden'];  
  function fetch(memo, name) { 
    var url = 'https://raw.githubusercontent.com/mcelaney/opportunities/master/' + name + '.json';
    memo[name] = $http.get(url).then(function(resp) { return resp.data; }); 
    return memo;
  }  
  var promise = null;  
  return  {
    knock: function() {
      return promise || (promise = $q.all(opportunities.reduce(fetch, {})));
    }
  };
});

app.controller("rootController", function($scope, Opportunity) {
  Opportunity.knock().then(function(all) {
    $scope.opportunities = all;
    console.log($scope.opportunities)
  });
});

app.controller("countyController",function
  ($scope,$http,$routeParams){
    $scope.countyName=$routeParams.countyname;

  var urls={
    "philly": 'https://raw.githubusercontent.com/mcelaney/opportunities/master/pa-philadelphia.json',
    "montco": 'https://raw.githubusercontent.com/mcelaney/opportunities/master/pa-montgomery.json',
    "bucks": 'https://raw.githubusercontent.com/mcelaney/opportunities/master/pa-bucks.json',
    "chester": 'https://raw.githubusercontent.com/mcelaney/opportunities/master/pa-chester.json',
    "delaware": 'https://raw.githubusercontent.com/mcelaney/opportunities/master/pa-delaware.json',
    "camden": 'https://raw.githubusercontent.com/mcelaney/opportunities/master/nj-camden.json'
  }
  var url=urls[$scope.countyName]
    $http.get(url).success(function(data) {
      $scope.data = data;
      console.log($scope.data)
  });

})



angular.module('opportunitiesApp', [])
.controller('appController', function($scope, $http) {
  var all_listings = [];
  var states = ['All'];
  var counties = {};

  $http.get('json/all-companies.json').success(function(data) {
    all_listings = data;
    $scope.listings = all_listings;
    $scope.nav_active_state = 'all';
    $scope.nav_active_county = '';
    all_listings.forEach(function(item) {
      if(!states.includes(item.state)) {
        states.push(item.state);
        counties[item.state] = [];
      }
      if(!counties[item.state].includes(item.county)) {
        counties[item.state].push(item.county)
      }
    });
    Object.keys(counties).forEach(function(k) {
      counties[k].sort();
      counties[k].unshift("All");
    })
    $scope.states = states;
    $scope.counties = counties;
  });
  $scope.navClick = function(state) {
    var county = 'All';
    if(arguments[1]) {
      county = arguments[1];
    }
    $scope.nav_active_state = state;
    $scope.nav_active_county = county;
    // Now update the listings
    var listings = [];
    if(state == 'All') {
      $scope.listings = all_listings;
    } else {
      all_listings.forEach(function(item) {
        if(item.state == state && (county == 'All' || item.county == county)) {
          listings.push(item);
        }
      });
      $scope.listings = listings;
    }
  };

});

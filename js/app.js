angular.module('opportunitiesApp', [])
.controller('appController', function($scope, $http) {
  var all_listings = [];
  var states = [];
  var counties = {};

  $http.get('lists/all-companies.json').success(function(data) {
    all_listings = data;
    $scope.listings = all_listings;
  });
  $http.get('lists/lists.json').success(function(data) {
    $scope.nav_active_state = 'all';
    $scope.nav_active_county = '';
    data.forEach(function(item) {
      if(!states.includes(item.state)) {
        states.push(item.state);
      }
      if(!counties[item.state] && item.state != 'all') {
        counties[item.state] = ['all'];
      }
      if(item.state != 'all') {
        counties[item.state].push(item.county);
      }
    });
    $scope.states = states;
    $scope.counties = counties;
  });
  $scope.navClick = function(state) {
    var county = 'all';
    if(arguments[1]) {
      county = arguments[1];
    }
    $scope.nav_active_state = state;
    $scope.nav_active_county = county;
    // Now update the listings
    var listings = [];
    if(state == 'all') {
      $scope.listings = all_listings;
    } else {
      all_listings.forEach(function(item) {
        if(item.state == state && (county == 'all' || item.county == county)) {
          listings.push(item);
        }
      });
      $scope.listings = listings;
    }
  };

});

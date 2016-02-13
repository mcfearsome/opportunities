angular.module('jobapp', [])
.controller('mycontroller', function($scope, $http) {
  $http.get('/lists/all-companies.json').success(function(data) {
    $scope.listings = data;
  });
});

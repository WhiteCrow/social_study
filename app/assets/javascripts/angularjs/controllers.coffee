'use strict'
# Controllers
window.EntryList = ($scope, $http)->
  $http.get("/entries.json?user_id=#{$scope.userId}").success (data)->
    $scope.entries = data
    $scope.currentEntry = _.last($scope.entries)

  # add or select entry to currentEntry
  $scope.next = (title)->
    $http.get("/entries/next/#{title}?user_id=#{$scope.userId}").success (data)->
      $scope.currentEntry = _.find $scope.entries, (entry)->
        entry.title == data.title
      if !!$scope.currentEntry is false
        $scope.entries.push(data)
        $scope.currentEntry = $scope.entries.last()

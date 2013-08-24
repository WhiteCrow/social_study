'use strict'
# Controllers
window.EntryList = ($scope, $http)->
  $http.get("/entries.json?user_id=#{$scope.userId}").success (data)->
    $scope.entries = data

  $scope.next = (title)->
    $http.get("/entries/next/#{title}?user_id=#{$scope.userId}").success (data)->
      if entry = $scope.entries.isIncludeAttr('title', data['title'])
        $scope.currentEntry = entry
      else
        $scope.entries.push(data)
        $scope.currentEntry = $scope.entries.last()

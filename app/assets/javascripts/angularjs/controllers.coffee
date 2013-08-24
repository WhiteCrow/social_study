'use strict'
# Controllers
user_id = App.Entry.userId()

window.EntryList = ($scope, $http)->
  $http.get("/entries.json?user_id=#{user_id}").success (data)->
    $scope.entries = data

window.EntryNext = ($scope, $http)->
  $http.get("/entries/next/test.json?user_id=#{user_id}").success (data)->
    $scope.entries += data

'use strict'
# Controllers
#myApp.EntryParser = ($scope, $sce)->
#    html = currentEntry.parsed_content
#    entryHtml = $sce.trustAsHtml(html)

myApp.controller "EntryList", ($scope, $http)->
  $http.get("/entries.json?user_id=#{$scope.userId}").success (data)->
    $scope.entries = data
    $scope.currentEntry = _.last($scope.entries)
    $scope.currentHtml = $scope.currentEntry.parsed_content

  #$scope.currentEntryContent = $scope.trustAsHtml(html)

  # add or select entry to currentEntry
  $scope.next = (title)->
    $http.get("/entries/next/#{title}?user_id=#{$scope.userId}").success (data)->
      $scope.currentEntry = _.find $scope.entries, (entry)->
        entry.title == data.title
      if !!$scope.currentEntry is false
        $scope.entries.push(data)
        $scope.currentEntry = _.last($scope.entries)
      $scope.currentHtml = $scope.currentEntry.parsed_content

  $scope.edit = (entry)->
    id = entry._id
    $http.get("/entries/#{id}/edit").success (data)->
      $scope.currentHtml = data

  $scope.destroy = (entry)->
    id = entry._id
    if confirm('你确定要删除当前条目吗？')
      $http.delete("/entries/#{id}").success ->
        $scope.remove(entry)

  $scope.clear = ->
    $scope.entries = [$scope.currentEntry]

  $scope.remove= (entry)->
    index = $scope.entries.indexOf(entry)
    $scope.entries.splice(index, 1)
    $scope.currentEntry = _.last($scope.entries)
    $scope.currentHtml = $scope.currentEntry.parsed_content

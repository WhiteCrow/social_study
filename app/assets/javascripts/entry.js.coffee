App.Entry =
  init: ->
    @menuItemToggle()

  menuItemToggle: ->
    $('#entry-menu .entry-title').on 'click', ->
      $('#entry-menu .entry-title').parent('li').removeClass 'active'
      $(@).parent('li').addClass 'active'

  previousIsContain: (title) ->
    titles = @.previousTitles()
    $.inArray(title, titles) >= 0

  activePrevious: (title)->
    $("#entry-previous .entry-tab").filter(->
      if $.trim($(@).text()) == title
        $('#entry-previous .active').removeClass 'active'
        $(@).addClass 'active'
    )
    #  $.get("/entries/next/#{title}").success (result) =>
    #    $('#entry-previous .active').removeClass 'active'
    #    $('#entry-previous #remove-unactive-li').before(result)

  previousTitles: ->
    $.trim($('#entry-previous .entry-tab').text()).split(' ')

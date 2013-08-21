App.Entry =
  init: ->
    @menuItemToggle()
    @tabChange()

  tabChange: ->
    $('.entry-tab a').on 'click', (e)->
      e.preventDefault()
      link = $(@).data('link')
      $.get(link).error =>
        alert('无法载入数据')

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

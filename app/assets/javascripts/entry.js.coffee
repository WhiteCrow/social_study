App.Entry =
  init: ->
    $('#entry-menu a').on 'click', ->
      $('#entry-menu li').removeClass 'active'
      $(@).parent('li').addClass 'active'

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
App.State =
  init: ->
    @hover()

  hover: ->
    $('.state').on 'mouseover', ()->
      $(this).find('.oprate-mic').children('.hide').show()
      $(this).find('.oprate-mic').find('.gray-link').css('color','#08c')
    $('.state').on 'mouseout', ()->
      $(this).find('.oprate-mic').children('.hide').hide()
      $(this).find('.oprate-mic').find('.gray-link').css('color','#888')

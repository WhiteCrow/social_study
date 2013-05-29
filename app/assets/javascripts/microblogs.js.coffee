# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('.microblog').on 'mouseover', ()->
    $(this).find('.oprate-mic').children('a.hide').show()
    $(this).find('.oprate-mic').children('a.gray-link').css('color','#08c')
  $('.microblog').on 'mouseout', ()->
    $(this).find('.oprate-mic').children('a.hide').hide()
    $(this).find('.oprate-mic').children('a.gray-link').css('color','#ccc')

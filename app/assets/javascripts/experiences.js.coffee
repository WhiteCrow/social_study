$ ->
  $('.toggle-content').click (e)->
    e.preventDefault()

    icon = $(this).children('span')
    wholeContent = $(this).closest('div').find('.whole-content')
    shortContent = $(this).closest('div').find('.short-content')

    if wholeContent.hasClass('hidden')
      wholeContent.removeClass('hidden')
    else
      wholeContent.addClass('hidden')

    if shortContent.hasClass('hidden')
      shortContent.removeClass('hidden')
    else
      shortContent.addClass('hidden')

    if icon.hasClass('icon-caret-down')
      icon.removeClass('icon-caret-down')
      icon.addClass('icon-caret-up')
    else
      icon.removeClass('icon-caret-up')
      icon.addClass('icon-caret-down')

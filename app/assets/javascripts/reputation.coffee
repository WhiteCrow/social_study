App.Reputation =
  init: ->
    @unStar()
    @softStar()

  unStar: ->
    $('.grade-type').on 'mouseleave', ->
      $('.grade-type').removeClass('soft-graded-type')
      $('.grade-type').not('.hard-graded-type').removeClass('icon-star').addClass('icon-star-empty')

  softStar: ->
    $('.grade-type').on 'mouseover', ->
      gradeLinks = $(this).prevAll('.grade-type')
      gradeLinks.push this
      gradeLinks.removeClass('icon-star-empty').
                addClass('icon-star').
                addClass('soft-graded-type')

  hardStar: (gradeObj)->
    $('.hard-graded-type').addClass('soft-graded-type').
                          removeClass('hard-graded-type').
                          addClass('icon-star-empty').
                          removeClass('icon-star')

    gradeLinks = gradeObj.prevAll('.grade-type')
    gradeLinks.push gradeObj[0]

    gradeLinks.addClass('icon-star').
              removeClass('icon-star-empty').
              addClass('hard-graded-type').
              removeClass('soft-graded-star')

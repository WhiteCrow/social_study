window.App = App =
  init: ->
    @Experiences.init()
    @initNotice()

  initNotice: ->
    $("#message_container").slideDown().delay(3000).slideUp()

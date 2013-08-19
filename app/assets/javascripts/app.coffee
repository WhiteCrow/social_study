window.App = App =
  init: ->
    @Experiences.init()
    @Entry.init()
    @initNotice()

  initNotice: ->
    $("#message_container").slideDown().delay(3000).slideUp()

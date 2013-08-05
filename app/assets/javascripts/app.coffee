window.App = App =
  init: ->
    @Experiences.init()
    @State.init()
    @initNotice()

  initNotice: ->
    $("#message_container").slideDown().delay(5000).slideUp()

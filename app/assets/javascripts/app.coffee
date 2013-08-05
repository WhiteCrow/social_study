window.App = App =
  init: ->
    App.Experiences.init()
    App.State.init()
    @initNotice

  initNotice: ->
    $("#message_container").slideDown().delay(3000).slideUp();

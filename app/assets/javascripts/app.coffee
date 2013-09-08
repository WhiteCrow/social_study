window.App = App =
  init: ->
    $(".textarea").qeditor()
    @Experiences.init()
    @Entry.init()
    @Reputation.init()
    @initNotice()

  initNotice: ->
    $("#message_container").slideDown().delay(3000).slideUp()

define ["app/app", "enums", "marionette"], (app, Enums, Marionette) ->
  Marionette.Controller.extend
    doAdd: () ->
      app.vent.trigger Enums.Event.ContactAdd
    doView: (param) ->
      app.vent.trigger Enums.Event.ContactView, param


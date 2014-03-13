define ["app/app", "enums"], (app, Enums) ->
  Backbone.Marionette.Controller.extend
    doAdd: () ->
      app.vent.trigger Enums.Event.ContactAdd
    doView: (param) ->
      app.vent.trigger Enums.Event.ContactView, param


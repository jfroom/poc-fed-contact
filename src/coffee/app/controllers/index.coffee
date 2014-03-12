define ["app/app", "enums"], (app, Enums) ->
  console.log "app in controller: " + app
  doAdd: () ->
    app.vent.trigger Enums.Event.ContactAdd
  doView: (param) ->
    app.vent.trigger Enums.Event.ContactView, param


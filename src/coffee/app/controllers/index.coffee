define ["app/app"], (app) ->
  setFilter: (param) ->
    app.vent.trigger "contact:filter", param and param.trim() or ""
    return

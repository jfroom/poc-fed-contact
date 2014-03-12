define ["marionette"], (Marionette) ->
  console.log "creating routes"
  Marionette.AppRouter.extend appRoutes:
    "*filter": "setFilter"

define ["marionette"], (Marionette) ->
  console.log "Marionette:" + Marionette
  Marionette.AppRouter.extend
    appRoutes:
      "add": "doAdd"
      "view/:id": "doView"
      "*notFound": "doAdd"

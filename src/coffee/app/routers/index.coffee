define ["marionette"], (Marionette) ->

  Marionette.AppRouter.extend
    appRoutes:
      "add": "doAdd"
      "view/:id": "doView"

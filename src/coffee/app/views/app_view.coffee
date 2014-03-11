define [
  'backbone'
  'underscore'
  'text!templates/app.html'
], (Bacbone, _, tpl)->

  class App extends Backbone.View

    el: "section[role='main']"

    events: {}

    initialize: (options)->


    render: ->
      @$el.html _.template( tpl, {  } )

  appView = new App()

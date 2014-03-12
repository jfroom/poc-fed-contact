define [
  'marionette'
  'backbone'
  'underscore'
  'text!templates/app.html'
], (Marionette, Backbone, _, tmpl)->

  Marionette.CompositeView.extend
    # template: _.template( tmpl, @ )
    el: "section[role='main']"
    initialize: (options)->
      # console.log "appview init"
    render: ->
      @$el.html _.template( tmpl, {  } )



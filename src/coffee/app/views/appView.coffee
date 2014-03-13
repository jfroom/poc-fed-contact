define [
  'backbone'
  'underscore'
  'text!templates/app.html',
  'marionette'
], (Backbone, _, tmpl)->
  console.log "AppView file loaded..."
  Backbone.Marionette.ItemView.extend
    template: tmpl

define [
  'backbone'
  'underscore'
  'text!templates/app.html',
  'marionette'
], (Backbone, _, tmpl)->

  Backbone.Marionette.ItemView.extend
    template: tmpl

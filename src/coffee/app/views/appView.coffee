define [
  'marionette'
  'backbone'
  'underscore'
  'text!templates/app.html'
], (Marionette, Backbone, _, tmpl)->

  Marionette.ItemView.extend
    template: tmpl

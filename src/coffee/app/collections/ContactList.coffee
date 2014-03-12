define [
  "backbone"
  "app/models/Contact"
  "config"

], (Backbone, Contact, Config) ->

  Backbone.Collection.extend
    model: Contact
    comparator: (contact) ->
      contact.get "name"

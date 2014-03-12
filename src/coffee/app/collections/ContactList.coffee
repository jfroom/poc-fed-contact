define [
  "backbone"
  "app/models/Contact"
  "config"

], (Backbone, Contact, Config) ->

  ContactList = Backbone.Collection.extend
    model: Contact
    initialize: (options) ->
    getActive: ->
      @filter isActive

    getActive: ->
      @reject isActive

    comparator: (contact) ->
      contact.get "name"
    onSort: () ->
      console.log "sort running"

  return ContactList

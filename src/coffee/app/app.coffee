define [
  'backbone'
  #'app/router'
  'config'
  'app/collections/ContactList'
  'app/views/AppView'
  'app/views/CardView'
  'app/views/ContactListView'
  'marionette'

], (Backbone, Config, ContactList, AppView, CardView, ContactListView)->

  app = new Backbone.Marionette.Application()
  app.contactList = new ContactList Config.contactData

  viewOptions =
    collection: app.contactList
    app: app


  app.addRegions
    main: "section[role='main']"
    contacts: "nav[role=contacts]"
    card: "section[role=card]"


  appView = new AppView viewOptions
  contactListView = new ContactListView viewOptions
  cardView = new CardView viewOptions

  app.vent.on "routing:started", () ->
    console.log "routing start"
    app.main.show appView
    app.card.show cardView
    app.contacts.show contactListView
    Backbone.history.start()

  return window.app = app

define [
  'marionette'
  'backbone'
  #'app/router'
  'config'
  'app/collections/ContactList'
  'app/views/appView'
  'app/views/CardView'
  'app/views/ContactListView'

], (Marionette, Backbone, Config, ContactList, AppView, CardView, ContactListView)->

  app = new Marionette.Application()
  app.contactList = new ContactList Config.contactData

  viewOptions =
    collection: app.contactList
    app: app

  appView = new AppView viewOptions
  contactListView = new ContactListView viewOptions
  cardView = new CardView viewOptions

  app.addRegions
    main: "section[role='main']"
    contacts: "nav[role=contacts]"
    card: "section[role=card]"

  app.vent.on "routing:started", () ->
    console.log "routing start"
    appView.render()
    app.card.show cardView
    app.contacts.show contactListView
    Backbone.history.start()

  return window.app = app

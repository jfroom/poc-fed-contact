define [
  "marionette"
  'text!templates/contactList.html'
  'app/views/ContactItemView'
], (Marionette, tmpl, ContactItemView) ->

  Marionette.CompositeView.extend
    template: tmpl

    itemView: ContactItemView
    itemViewContainer: '.contact-list'
    #el: '.contact-list'
    initialize: (options) ->
      console.log "ContactListView collection:" + options.collection.length
    #ui:
      #input: ".contact-list"

    events:
      "keypress #new-todo": "onInputKeypress"

    onInputKeypress: (event) ->
      ENTER_KEY = 13
      todoText = @ui.input.val().trim()
      if event.which is ENTER_KEY and todoText
        @collection.create title: todoText
        @ui.input.val ""
      return


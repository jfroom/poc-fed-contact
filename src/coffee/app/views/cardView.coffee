
define [
  "marionette"
  'text!templates/card.html'
], (Marionette, tmpl) ->

  Marionette.ItemView.extend
    template: _.template( tmpl, {  } )
    ui:
      input: "#new-todo"

    events:
      "keypress #new-todo": "onInputKeypress"

    onInputKeypress: (event) ->
      ENTER_KEY = 13
      todoText = @ui.input.val().trim()
      if event.which is ENTER_KEY and todoText
        @collection.create title: todoText
        @ui.input.val ""
      return


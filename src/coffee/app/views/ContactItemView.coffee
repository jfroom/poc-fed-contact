define [
  "marionette"
  'text!templates/contactItem.html'
], (Marionette, tmpl) ->
  ENTER_KEY = 13
  ESCAPE_KEY = 27
  Marionette.ItemView.extend

    tagName: "li"
    template: _.template( tmpl, @model )
    value: ""
    ui:
      edit: ".edit"

    events:
      "click .toggle": "toggle"
      "click .destroy": "destroy"
      "dblclick label": "onEditDblclick"
      "keypress .edit": "onEditKeypress"
      "blur .edit": "onEditBlur"

    initialize: ->
      console.log "ContactItemView item"
      @value = @model.get("title")
      @listenTo @model, "change", @render, this
      return

    onRender: ->
      @$el.removeClass("active completed").addClass (if @model.get("completed") then "completed" else "active")
      return

    destroy: ->
      @model.destroy()
      return

    toggle: ->
      @model.toggle().save()
      return

    toggleEditingMode: ->
      @$el.toggleClass "editing"
      return

    onEditDblclick: ->
      @toggleEditingMode()
      @ui.edit.focus().val @value
      return

    onEditKeypress: (event) ->
      @ui.edit.trigger "blur"  if event.which is ENTER_KEY
      @toggleEditingMode()  if event.which is ESCAPE_KEY
      return

    onEditBlur: (event) ->
      @value = event.target.value.trim()
      if @value
        @model.set("title", @value).save()
      else
        @destroy()
      @toggleEditingMode()
      return


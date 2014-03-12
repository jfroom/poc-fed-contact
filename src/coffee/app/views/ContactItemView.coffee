define [
  "marionette"
  'text!templates/contactItem.html'
], (Marionette, tmpl) ->
  Marionette.ItemView.extend

    tagName: "li"
    template: _.template( tmpl, @model )
    value: ""

    events:
      "click .toggle": "toggle"

    initialize: ->
      console.log "ContactItemView item"
      @value = @model.get("title")
      @listenTo @model, "change", @modelChanged, @
      return
    modelChanged: ->
      #console.log "contactitem model changed" + @model.get("name") + " active? " + @model.get('active')
      @render()
    onRender: ->
      #console.log "onreder"
      @$el.find(".contact-item").removeClass("active").addClass (if @model.get("active") then "active")
      #debugger
      @$el.find("a").attr("href", "#/view/" + @model.get("guid"))



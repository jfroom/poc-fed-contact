define [
  'text!templates/contactItem.html'
  'marionette'
], (tmpl) ->
  Backbone.Marionette.ItemView.extend

    tagName: "li"
    template: _.template( tmpl, @model )
    value: ""

    initialize: ->
      console.log "ContactItemView item"
      @value = @model.get("title")
      @listenTo @model, "change", @modelChanged, @
    modelChanged: ->
      @render()
    onRender: ->
      @$el.find(".contact-item").removeClass("active").addClass (if @model.get("active") then "active")
      @$el.find("a").attr("href", "#/view/" + @model.get("guid"))

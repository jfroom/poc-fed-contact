
define [
  'app/app'
  "marionette"
  'text!templates/card.html'
  'config'
  'lorem'
  'Chance'
  'app/models/Contact'
  'enums'
], (app, Marionette, tmpl, Config, Lorem, Chance, Contact, Enums) ->

  chance: new Chance()

  Marionette.ItemView.extend
    template: _.template( tmpl, {  } )
    defaults:
      state: Enums.State.Idle
      app: null

    ui:
      form: "#cfm"
      cfm__name: "#cfm__name"
      cfm__pic: "#cfm__pic"
      cfm__sex: "#cfm__sex"
      cfm__dob__mm: "#cfm__dob--mm"
      cfm__dob__dd: "#cfm__dob--dd"
      cfm__dob__yyyy: "#cfm__dob--yyyy"
      cfm__age: "#cfm__age"
      cfm__street: "#cfm__street"
      cfm__city: "#cfm__city"
      cfm__state: "#cfm__state"
      cfm__postcode: "#cfm__postcode"
      cfm__phone: "#cfm__phone"
      cfm__email: "#cfm__email"
      cfm__btn__delete: "#cfm__btn--delete"
      cfm__btn__random: "#cfm__btn--random"
      cfm__btn__save: "#cfm__btn--save"

    initialize: (opts) ->
      @app = opts.app

    onRouteAdd: () ->
      console.log "route add"
      @toggleState Enums.State.CardAdd
      @model = new Contact()
      @renderModel()
      @ui.cfm__name.focus()

    onRouteView: (id) ->
      @toggleState Enums.State.CardView
      @model = @collection.findWhere {guid:id}
      if @model == undefined
        @app.router.navigate("/add")
        return
      @renderModel()
      @ui.cfm__name.focus()

    onShow: () ->
      @buildUI()
      @app.vent.on Enums.Event.ContactAdd, @onRouteAdd, @
      @app.vent.on Enums.Event.ContactView, @onRouteView, @

      @toggleState Enums.State.CardAdd
    toggleState: (state) ->
      if @model != undefined
        @model.set "active", false

      #turn off old state
      @ui.form.removeClass "card__state--add"
      @ui.form.removeClass "card__state--view"

      @state = state

      #turn on new state
      switch @state
        when Enums.State.CardAdd
          @ui.form.addClass "card__state--add"

        when Enums.State.CardView
          @ui.form.addClass "card__state--view"

      $("html, body").animate({ scrollTop: @ui.form.offset().top - 20}, 300)

    events:
      "click #cfm__btn--random": "onRandomClick"
      #"click #cfm__btn--save": "onSaveClick"
      "submit #cfm": "onSubmit"
    onInputKeypress: (event) ->
      ENTER_KEY = 13
      todoText = @ui.input.val().trim()
      if event.which is ENTER_KEY and todoText
        @collection.create title: todoText
        @ui.input.val ""
      return

    buildUI: () ->
      ui_ref = @ui

      # dob
      _.each _.range(1, 13), (element, index, list) ->
        ui_ref.cfm__dob__mm.append "<option>" + element + "</option>"
      _.each _.range(1, 32), (element, index, list) ->
        ui_ref.cfm__dob__dd.append "<option>" + element + "</option>"
      year = new Date().getFullYear()
      _.each _.range(year, year-150, -1), (element, index, list) ->
        ui_ref.cfm__dob__yyyy.append "<option>" + element + "</option>"

      # states
      _.each Config.states, (element, index, list) ->
        ui_ref.cfm__state.append "<option>" + index + "</option>"

    renderModel: () ->
      @model.set("active", true)
      @ui.cfm__name.val @model.get("name")
      @ui.cfm__street.val @model.get("address").street
      @ui.cfm__city.val @model.get("address").city
      @ui.cfm__postcode.val @model.get("address").postcode
      @ui.cfm__phone.val @model.get("phone")
      @ui.cfm__email.val @model.get("email")

      @ui.cfm__sex.val @model.get("sex")
      dob = @parseBirthdayFromString @model.get("birthday")
      @ui.cfm__dob__mm.val dob.mm
      @ui.cfm__dob__dd.val dob.dd
      @ui.cfm__dob__yyyy.val dob.yyyy
      @ui.cfm__state.val @model.get("address").state

    onRandomClick: () ->

      @ui.cfm__name.val chance.name()
      @ui.cfm__street.val chance.address()
      @ui.cfm__city.val chance.city()
      @ui.cfm__postcode.val chance.zip()
      @ui.cfm__phone.val chance.phone()
      @ui.cfm__email.val chance.email()

      @setRandomSelect @ui.cfm__sex, true
      @setRandomSelect @ui.cfm__dob__dd, true
      @setRandomSelect @ui.cfm__dob__mm, true
      @setRandomSelect @ui.cfm__dob__yyyy, true
      @setRandomSelect @ui.cfm__state, true

    setRandomSelect: (elm, omitFirst) ->

      opts = elm.find("option")
      len = (if omitFirst then opts.length - 1 else opts.length)
      rand = Math.floor(Math.random()*len)
      if omitFirst
        rand++
      elm.val( $(opts[rand]).val() )

    onSubmit: (e)->
      e.preventDefault()

      newModel =
        guid: if @model.get("guid") == '' then chance.guid() else @model.get("guid")
        name: @ui.cfm__name.val()
        sex: @ui.cfm__sex.val()
        email: @ui.cfm__email.val()
        birthday: @getBirthdayVal()
        phone: @ui.cfm__phone.val()
        address:
          street: @ui.cfm__street.val()
          city: @ui.cfm__city.val()
          postcode: @ui.cfm__postcode.val()
          state: @ui.cfm__state.val()

      @model.set newModel

      if @state == Enums.State.CardAdd
        @collection.add @model
        @app.router.navigate "view/" + @model.get("guid")
      else
        @collection.remove @model
        @collection.add @model

    getBirthdayVal: () ->
      return @ui.cfm__dob__mm.val() + "/" + @ui.cfm__dob__dd.val() + "/" + @ui.cfm__dob__yyyy.val()

    parseBirthdayFromString: (str) ->
      parts = str.split '/'
      out =
        mm: ''
        dd: ''
        yyyy: ''
      if parts.length >= 0 then out.mm = parts[0]
      if parts.length >= 1 then out.dd = parts[1]
      if parts.length >= 2 then out.yyyy = parts[2]
      return out

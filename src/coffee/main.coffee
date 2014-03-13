requirejs.config
  baseUrl: './js'

  paths:
    backbone:   '../components/backbone/backbone'
    underscore:   '../components/underscore/underscore'
    jquery:     '../components/jquery/dist/jquery'
    marionette:   '../components/marionette/lib/core/amd/backbone.marionette'
    "backbone.wreqr": "../components/backbone.wreqr/lib/amd/backbone.wreqr"
    "backbone.eventbinder": "../components/backbone.wreqr/lib/amd/backbone.eventbinder"
    "backbone.babysitter": "../components/backbone.babysitter/lib/amd/backbone.babysitter"
    text:    '../components/requirejs-text/text'
    domReady:   '../components/requirejs-domready/domReady'
    modernizr:  '../components/modernizr/modernizr'
    templates:  '../templates'
    Chance:  '../components/chance/chance'
    config:     'app/config/config_base'
    router:     'app/routers/baseRouter'
    enums:     'app/enums/enums'
    controller: 'app/controllers/baseController'

  shim:
    jquery:
      exports: '$'
    underscore:
      exports: '_'
    backbone:
      deps: ['jquery', 'underscore']
      exports: 'Backbone'
    marionette:
      deps : ['jquery', 'underscore', 'backbone']
      exports : 'Marionette'
    modernizr:
      exports: 'Modernizr'

require ['app/vendors'], ->

  require ['app/app', 'backbone', 'jquery', 'router', 'controller'], (app, Backbone, $, Router, Controller) ->

    app.addInitializer () ->
      app.routerController = new Controller()
      app.router = new Router {controller: app.routerController}
      app.vent.trigger "routing:started"
    app.start()

    if window.is_test
      mocha_div = $('<div />', { id: 'mocha' })
      $('body').prepend(mocha_div)

      $('head').append('<link rel="stylesheet" href="components/mocha/mocha.css">')
      $('head').append('<link rel="stylesheet" href="runner/test.css">')

      require [
        '../components/chai/chai'
        '../components/chai-backbone/chai-backbone'
        '../components/chai-jquery/chai-jquery'
        '../components/sinon-chai/lib/sinon-chai'
      ], (chai, chaiBackbone, chaiJQuery, sinonChai)->

        unless window.PHANTOMJS
          mocha.setup
            ui: 'bdd'
            bail: false
            ignoreLeaks: true
            timeout: 5000

        expect = window.expect = chai.expect

        chai.should()
        chai.use chaiBackbone
        chai.use chaiJQuery
        chai.use sinonChai

        require [
          'spec/all_tests'
          '../runner/bridge'
        ], (runner)->
          mocha.run()

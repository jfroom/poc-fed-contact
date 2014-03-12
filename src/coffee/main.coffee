requirejs.config
  baseUrl: './js'
  shim:
    'underscore':
      exports: '_'
    'jquery':
      exports: '$'
    'backbone':
      deps: ['underscore', 'jquery']
      exports: 'Backbone'
    'marionette':
      exports: 'Backbone.Marionette',
      deps: ['backbone']
    'modernizr':
      exports: 'Modernizr'

  paths:
    'underscore':   '../components/underscore/underscore'
    'backbone':   '../components/backbone/backbone'
    'marionette':   '../components/marionette/lib/backbone.marionette'
    'jquery':     '../components/jquery/dist/jquery'
    'text' :    '../components/requirejs-text/text'
    'domReady':   '../components/requirejs-domready/domReady'
    'modernizr':  '../components/modernizr/modernizr'
    'templates':  '../templates'
    'lorem':  '../components/lorem/src/library/lorem'
    'Chance':  '../components/chance/chance'
    'config':     'app/config/config_base'
    'router':     'app/routers/index'
    'enums':     'app/enums/enums'
    'controller': 'app/controllers/index'


require ['app/vendors'], ->

  require ['app/app', 'backbone', 'jquery', 'router', 'controller', 'app/collections/ContactList'], (app, Backbone, $, Router, Controller, ContactList) ->

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

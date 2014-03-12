# Add project configuration here
define ['underscore'], (_)->

  _.extend
    Event:
      ContactAdd: "contact:add"
      ContactView: "contact:view"

    State:
      Idle: "idle"
      CardView: "card:view"
      CardEdit: "card:edit"
      CardAdd: "card:add"

  , {}

define [
  "marionette"
  'text!templates/contactList.html'
  'app/views/ContactItemView'
], (Marionette, tmpl, ContactItemView) ->

  Marionette.CompositeView.extend
    template: tmpl

    itemView: ContactItemView
    itemViewContainer: '.contact-list'

    #https://github.com/marionettejs/backbone.marionette/wiki/Adding-support-for-sorted-collections
    appendHtml: (collectionView, itemView, index) ->
      childrenContainer = (if collectionView.itemViewContainer then collectionView.$(collectionView.itemViewContainer) else collectionView.$el)
      children = childrenContainer.children()
      if children.size() <= index
        childrenContainer.append itemView.el
      else
        children.eq(index).before itemView.el
      return



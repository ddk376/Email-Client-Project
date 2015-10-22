Email.Routers.Router = Backbone.Router.extend({
  initialize: function(options){
    this.$rootEl = options.$rootEl;
    this.$subroot = options.$subroot;
  },
  routes:{
    '': 'inbox',
    'email_threads/:id' : 'show',
    'starred' : 'index'
  },

  inbox: function(){
    debugger
    this.collection = new Email.Collections.EmailThreads();
    var view = new Email.Views.ThreadsIndex({collection: this.collection, edit: false, delete: false});

    this._swapView(view);
  },

  show: function(id){
    this.collection = new Email.Collections.EmailThreads();
    var showThread = this.collection.getOrFetch(id);
    var view = new Email.Views.ThreadShow({model: showThread});

    this._swapView(view);

  },
  edit: function(id){
    debugger
    this.collection = new Email.Collections.ElectronicMails();
    var email = this.collection.getOrFetch(id);
    var view = new Email.Views.EmailForm({model: email, collection: this.collection });

    this._swapView(view);
  },

  searchIndex: function(){
    this.collection = new Email.Collections.SearchResults();
    var view = new Email.Views.EmailsIndex({collection: this.collection, edit: false, delete: false});
    this._swapView(view);
  },
  _swapView: function(view){
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$subroot.html(view.$el);
    view.render();
  }
})

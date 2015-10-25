Email.Routers.Router = Backbone.Router.extend({
  initialize: function(options){
    this.$rootEl = options.$rootEl;
    // this.$subroot = options.$subroot;
  },
  routes:{
    '': 'inbox',
    'starred' : 'starred',
    'important': 'important',
    'draft': 'draft',
    'spam': 'spam',
    'trash': 'trash',
    'sent': 'sent',
    'email_threads/:id/emails': 'show'
  },

  // inbox: function(){
  //   this.collection = new Email.Collections.InboxThreads();
  //   var view = new Email.Views.ThreadsIndex({collection: this.collection, edit: false, delete: false});
  //
  //   this._swapView(view);
  // },

  starred: function(){
    this.collection = new Email.Collections.StarredThreads();
    var view = new Email.Views.ThreadsIndex({collection: this.collection, edit: false, delete: false});

    this._swapView(view);
  },

  important: function(){
    this.collection = new Email.Collections.ImportantThreads();
    var view = new Email.Views.ThreadsIndex({collection: this.collection, edit: false, delete: false});

    this._swapView(view);
  },

  sent: function(){
    this.collection = new Email.Collections.SentThreads();
    var view = new Email.Views.ThreadsIndex({collection: this.collection, edit: false, delete: false});

    this._swapView(view);
  },

  all: function(){
    this.collection = new Email.Collections.AllThreads();
    var view = new Email.Views.ThreadsIndex({collection: this.collection, edit: false, delete: false});

    this._swapView(view);
  },

  draft: function(){
    this.collection = new Email.Collections.DraftThreads();
    var view = new Email.Views.ThreadsIndex({collection: this.collection, edit: false, delete: false});

    this._swapView(view);
  },

  spam: function(){
    this.collection = new Email.Collections.SpamThreads();
    var view = new Email.Views.ThreadsIndex({collection: this.collection, edit: false, delete: false});

    this._swapView(view);
  },

  trash: function(){
    this.collection = new Email.Collections.TrashThreads();
    var view = new Email.Views.ThreadsIndex({collection: this.collection, edit: false, delete: false});

    this._swapView(view);
  },

  show: function(id){
    if(this.collection){
      var showThread = this.collection.getOrFetch(id)
      showThread.emails().fetch();
      var view = new Email.Views.ThreadShow({collection: this. collection,model: showThread});

      this._swapView(view);
    } else {
      Backbone.history.navigate("");
    }
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
    this.$rootEl.html(view.$el);
    view.render();
  }
})

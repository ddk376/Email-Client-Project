Email.Views.ThreadsIndex = Backbone.View.extend({
  template: JST['threads/index'],
  initialize: function(options){
    // this._page = 1;
    this.collection.fetch({
      remove: false,
      data: {page: this._page},
      success: function(){}
    })
    this.listenTo(this.collection, 'sync', this.render);
    $('.nextpage').click(this.nextPage.bind(this));
    $('.prevpage').click(this.prevPage.bind(this));
    $('.searchsubmit').click(this.getSearch.bind(this));
    this.edit = options.edit;
    this.delete = options.delete;
  },
  events:{
    "click .from": 'showThread',
    'click .subject_body': 'showThread',
    'click .paperclip': 'showThread',
    'click .date_time': 'showThread',
    'click .checkbox': 'mark',
    'click .star': 'markStarred',
    'click .important': 'markImportant'
  },
  render: function(){
    this.collection.sort();
    var content = this.template({emails: this.collection, edit: this.edit, delete: this.delete});
    this.$el.html(content);

    return this;
  },
  showThread: function(e){
    var id = $(e.currentTarget).data('id');
    Backbone.history.navigate("#/email_threads/" + id + "/emails", {trigger: true});
  },
  mark: function(e){
    var id = $(e.currentTarget).data('id');
    var model = this.collection.getOrFetch(id);
    if($(e.currentTarget).children().prop('checked')){
      model.set({is_checked: true})
      model.save();
      // console.log("I am now checked but was unchecked")
    }else {
      // console.log("I am now unchecked, but now was checked")
      model.set({is_checked: false})
      model.save();
    }

  },

  markStarred: function(e){
    var id = $(e.currentTarget).data('id');
    var model = this.collection.getOrFetch(id);
    if($(e.currentTarget).children().prop('checked')){
      model.set({is_starred: true})
      model.save();
      // console.log("I am now checked but was unchecked")
    }else {
      // console.log("I am now unchecked, but now was checked")
      model.set({is_starred: false})
      model.save();
    }
  },
  markImportant: function(e){
    var id = $(e.currentTarget).data('id');
    var model = this.collection.getOrFetch(id);
    if($(e.currentTarget).children().prop('checked')){
      model.set({is_important: true})
      model.save();
      // console.log("I am now checked but was unchecked")
    }else {
      // console.log("I am now unchecked, but now was checked")
      model.set({is_important: false})
      model.save();
    }
  },
  getSearch: function(e){
    e.preventDefault();
    this.searchResults = new Email.Collections.SearchResults();
		this.searchResults._query = $(".query").val();
    var that = this;
		this.searchResults.fetch({
			data: {query: this.searchResults._query},
      success: function(){
        console.log("I am here");
        debugger
        var content = that.template({emails: that.searchResults});
        that.$el.html(content);
      }
		});
  },


  nextPage: function(){
    this._page++;
    var that = this;
    that.collection.fetch({
      reset: true,
      data: {page: that._page},
      success: function(){}
    })
  },
  prevPage: function(){
    this._page--;
    var that = this;
    that.collection.fetch({
      reset: true,
      data: {page: that._page},
      success: function(){}
    })
  }
})

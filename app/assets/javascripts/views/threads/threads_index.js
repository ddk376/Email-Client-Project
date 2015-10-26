Email.Views.ThreadsIndex = Backbone.View.extend({
  template: JST['threads/index'],
  tagName: 'ul',
  initialize: function(options){
    // this._page = 1;
    // this.collection.fetch({
    //   remove: false,
    //   data: {page: this._page},
    //   success: function(){}
    // })
    this.collection.fetch();
    this.listenTo(this.collection, 'sync', this.render);
    $('.nextpage').click(this.nextPage.bind(this));
    $('.prevpage').click(this.prevPage.bind(this));
    $('.searchsubmit').click(this.getSearch.bind(this));
    this.edit = options.edit;
    this.delete = options.delete;
  },

  render: function(){
    this.collection.sort();
    var content = this.template({emails: this.collection});
    this.$el.html(content);
    var that = this;
    this.collection.each(function (thread) {
      var emails = thread.emails();
      emails.fetch({
        success: function(collection, response, options){
          debugger
          var last = response[response.length-1];
          var view = new Email.Views.ThreadListItem({ model: thread, emails: emails, last: last, edit: this.edit, delete: this.delete});
          that.$el.append(view.render().$el);
        }
      });
    });

    return this;
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

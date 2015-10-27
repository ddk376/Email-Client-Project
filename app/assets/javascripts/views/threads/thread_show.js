Email.Views.ThreadShow = Backbone.View.extend({
  template: JST['threads/show'],
  initialize: function(){
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.emails(), "sync", this.render);
  },

  render: function(){
    var content = this.template({thread: this.model})
    this.$el.html(content);
    var that = this;
    this.model.emails().each(function (email) {
      var view = new Email.Views.EmailShow({ thread: that.model, email: email});
      that.$el.append(view.render().$el);
    });

    return this;
  }

})

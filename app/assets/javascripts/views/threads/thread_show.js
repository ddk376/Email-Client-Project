Email.Views.ThreadShow = Backbone.View.extend({
  template: JST['threads/show'],
  initialize: function(){
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function(){
    parent_email = this.model.get('parent_email');
    var content = this.template({thread: this.model})
    this.$el.html(content);
    var that = this;
    parent = new Email.Models.Email(parent_email);
    parent.fetch({
      success: function(){
        var view = new Email.Views.EmailShow({thread: that.model, email: parent});
        that.$el.append(view.render().$el);
      }
    });

    return this;
  }

})

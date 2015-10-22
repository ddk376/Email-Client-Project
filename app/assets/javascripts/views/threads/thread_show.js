Email.Views.ThreadShow = Backbone.View.extend({
  template: JST['threads/show'],
  initialize: function(){
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function(){
    var content = this.template({email: this.model});
    this.$el.html(content);

    return this;
  }

})

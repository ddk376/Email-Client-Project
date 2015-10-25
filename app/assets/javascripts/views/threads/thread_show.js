Email.Views.ThreadShow = Backbone.View.extend({
  template: JST['threads/show'],
  initialize: function(){
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.emails(), "sync", this.render);
  },

  render: function(){

    this.$el.html(content);

    return this;
  }

})

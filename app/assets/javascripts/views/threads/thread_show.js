Email.Views.ThreadShow = Backbone.CompositeView.extend({
  template: JST['threads/show'],
  initialize: function(){
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.emails(), "sync", this.render);
  },

  render: function(){
    _.(this.model.emails()).each(function(email){
      var subView = new Email.Views.EmailShow({model: email});

    });
    this.$el.html(content);

    return this;
  }

})

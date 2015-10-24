Email.Views.EmailShow = Backbone.View.extend({
  template: JST['emails/show'],
  initialize: function(){
    this.model.to().fetch();
    this.model.bcc().fetch();
    this.model.cc().fetch();
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.to(), "sync", this.render);
    this.listenTo(this.model.bcc(), "sync", this.render);
    this.listenTo(this.model.cc(), "sync", this.render);
  },

  render: function(){
    var content = this.template({email: this.model});
    this.$el.html(content);
    
    return this;
  }

})

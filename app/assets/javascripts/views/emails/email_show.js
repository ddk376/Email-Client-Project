Email.Views.EmailShow = Backbone.View.extend({
  template: JST['emails/show'],
  initialize: function(options){
    this.thread = options.thread;
    this.email = options.email;
    this.to = this.email.to();
    this.bcc = this.email.bcc();
    this.cc = this.email;
    this.to.fetch();
    this.bcc.fetch();
    this.cc.fetch();
    this.listenTo(this.email, 'sync', this.render);
    this.listenTo(this.email.to(), "sync", this.render);
    this.listenTo(this.email.bcc(), "sync", this.render);
    this.listenTo(this.email.cc(), "sync", this.render);
  },

  render: function(){
    var content = this.template({thread: this.thread, email: this.email, to: this.to, bcc: this.bcc, cc: this.cc});
    this.$el.html(content);

    return this;
  }

})

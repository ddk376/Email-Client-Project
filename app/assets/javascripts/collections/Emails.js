Email.Collections.Emails = Backbone.Collection.extend({
  url: function(){
    return this.email_thread.url() + "/emails"
  },
  comparator: 'updated_at',
  model: Email.Models.Email,
  comparator: 'updated_at',
  getOrFetch: function(id){
    var thread = this.get(id);
    if(thread){
      thread.fetch();
    }else{
      thread = new Email.Models.EmailThread({id: id});
      this.add(thread);
      var that = this;
      thread.fetch({
        errors: function(){
          that.remove(thread);
        }
      });
    }
    return thread;
  },
  initialize: function(models, options){
    this.email_thread = options.email_thread
  }
})

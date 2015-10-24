Email.Collections.CcContacts = Backbone.Collection.extend({
  url: function(){
    return this.email.url() + "/cc_recipients"
  },
  model: Email.Models.Contact,
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
    this.email = options.email;
  }
})

Email.Collections.TrashThreads = Backbone.Collection.extend({
  url: 'api/trash_threads',
  model: Email.Models.EmailThread,
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
  initialize: function(){}
})

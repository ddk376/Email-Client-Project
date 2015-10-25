
Email.Views.ThreadListItem = Backbone.View.extend({
  template: JST['threads/list_item'],
  tagName: 'li',
  events:{
    "click .from": 'showThread',
    'click .subject_body': 'showThread',
    'click .paperclip': 'showThread',
    'click .date_time': 'showThread',
    'click .checkbox': 'mark',
    'click .star': 'markStarred',
    'click .important': 'markImportant'
  },
  initialize: function(){
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.emails(), "sync", this.render);
  },

  render: function(){
    var count = this.model.length();
    var last = this.model.emails().last();
    var content = this.template({model: thread, email: last, count: count});

    this.$el.html(content);

    return this;
  },

  showThread: function(e){
    debugger
    var id = $(e.currentTarget).data('id');
    Backbone.history.navigate("#/email_threads/" + id + "/emails", {trigger: true});
  },
  mark: function(e){
    var id = $(e.currentTarget).data('id');
    var model = this.collection.getOrFetch(id);
    if($(e.currentTarget).children().prop('checked')){
      model.set({is_checked: true})
      model.save();
      // console.log("I am now checked but was unchecked")
    }else {
      // console.log("I am now unchecked, but now was checked")
      model.set({is_checked: false})
      model.save();
    }

  },

  markStarred: function(e){
    var id = $(e.currentTarget).data('id');
    var model = this.collection.getOrFetch(id);
    if($(e.currentTarget).children().prop('checked')){
      model.set({is_starred: true})
      model.save();
      // console.log("I am now checked but was unchecked")
    }else {
      // console.log("I am now unchecked, but now was checked")
      model.set({is_starred: false})
      model.save();
    }
  },
  markImportant: function(e){
    var id = $(e.currentTarget).data('id');
    var model = this.collection.getOrFetch(id);
    if($(e.currentTarget).children().prop('checked')){
      model.set({is_important: true})
      model.save();
      // console.log("I am now checked but was unchecked")
    }else {
      // console.log("I am now unchecked, but now was checked")
      model.set({is_important: false})
      model.save();
    }
  },
})

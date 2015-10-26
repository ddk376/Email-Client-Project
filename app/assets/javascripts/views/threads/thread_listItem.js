
Email.Views.ThreadListItem = Backbone.View.extend({
  template: JST['threads/list_item'],
  tagName: 'li',
  className: 'email-show',
  events:{
    "click .from": 'showThread',
    'click .subject_body': 'showThread',
    'click .paperclip': 'showThread',
    'click .date_time': 'showThread',
    'click .checkbox': 'mark',
    'click .star': 'markStarred',
    'click .important': 'markImportant'
  },
  initialize: function(options){
    this.edit = options.edit;
    this.delete = options.delete;
    this.last = options.last;
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.emails(), "sync", this.render);
  },

  render: function(){
    debugger
    var content = this.template({thread: this.model, last: this.last, edit: this.edit, delete: this.delete});

    this.$el.html(content);


    return this;
  },

  showThread: function(e){
    debugger
    var id = this.model.get('id');
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

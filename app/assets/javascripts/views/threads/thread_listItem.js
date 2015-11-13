Email.Views.ThreadListItem = Backbone.View.extend({
  template: JST['threads/list_item'],
  tagName: 'li',
  className: 'email-show',
  events:{
    "click .from": 'showThread',
    'click .subject_body': 'showThread',
    'click .paperclip': 'showThread',
    'click .date_time': 'showThread',
    'click .checkbox-box': 'markChecked',
    'click .star': 'markStarred',
    'click .importance': 'markImportant'
  },
  initialize: function(options){
    this.edit = options.edit;
    this.delete = options.delete;
    this.last = options.last;
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function(){
    var content = this.template({thread: this.model, last: this.last, starred: this.hasStarred(), edit: this.edit, delete: this.delete});
    this.$el.html(content);


    return this;
  },

  showThread: function(e){
    var id = this.model.get('id');
    Backbone.history.navigate("#/email_threads/" + id , {trigger: true});
  },

  markChecked: function(e){
    if($(e.currentTarget).hasClass('is-checked')){
      $(e.currentTarget).removeClass('is-checked');
      this.model.set({is_checked: false});
    }else {
      $(e.currentTarget).addClass('is-checked');
      this.model.set({is_checked: false});
    }
    this.model.save();
  },

  markStarred: function(e){
    if($(e.currentTarget).hasClass('is-starred')){
      $(e.currentTarget).removeClass('is-starred').addClass('is-not-starred');
      this.setStarred(false);
    }else {
      $(e.currentTarget).removeClass('is-not-starred').addClass('is-starred');
      this.setStarred(true);
    }
  },

  markImportant: function(e){
    if($(e.currentTarget).hasClass('is-important')){
      $(e.currentTarget).removeClass('is-important').addClass('is-not-important');
      this.model.set({is_important: false})
    }else {
      $(e.currentTarget).removeClass('is-not-important').addClass('is-important');
      this.model.set({is_important: true})
    }
    this.model.save();
  },

  hasStarred: function(){
    emails = this.model.get('emails');
    _.each(emails, function(email){
      var e = new Email.Models.Email({id: email.id});
      e.fetch();
      if(e.escape('is_starred') === "true"){
        return true;
      }
    })
    return false;
  },

  setStarred: function(option){
    emails = this.model.get('emails');
    _.each(emails, function(email){
      var e = new Email.Models.Email({id: email.id});
      e.fetch({
        success: function(){
          if(option){
            e.set({is_starred: true});
          }else{
            e.set({is_starred: false});
          }
          e.save();
        }
      });
    })
  }

})

Email.Views.EmailShow = Backbone.View.extend({
  template: JST['emails/show'],
  initialize: function(options){
    this.thread = options.thread;
    this.email = options.email;
    this.listenTo(this.email, 'sync', this.render);

  },
  events:{
    'click #reply': 'showReply'
  },
  render: function(){
    //inside EmailShow
    var content = this.template({thread: this.thread, email: this.email});
    this.$el.html(content);
    this.render_children(this.email);
    return this;
  },
  showReply: function(){
    var r = ".respond"+this.email.get("id");
    $(r).removeClass("hidden").addClass('show')
  },

  render_children: function(email){
    children = email.get('children');
    if(children.length > 0){
      var that = this;
      _.each(children, function(child){
        child_email = new Email.Models.Email({id: child.id});
        child_email.fetch({
          success: function(){
            var view = new Email.Views.EmailShow({thread: that.thread, email: child_email});
            that.$el.append(view.render().$el);
          }
        })
      })
    }else{
      return;
    }
  }

})

Email.Views.ThreadForm = Backbone.View.extend({
  template: JST['threads/form'],
  className: 'compose',
  events: {
    'click button': 'send_email',
  },
  initialize: function(options){
    this.listenTo(this.model, 'sync', this.render);
  },
  tagName: 'form',
  render: function(){
    var content = this.template({email: this.model});
    this.$el.html(content);

    return this;
  },
  send_email: function(e){
    var email_to = $('#email_to').val();
    var email_cc = $('#email_cc').val();
    var email_bcc = $('#email_bcc').val();
    var email_subject = $('#email_subject').val();
    var email_body = $('#email_body').val();
    var email_attachment = this.$('#input-file-attachment')[0].files[0]

    var formData = new FormData();
    formData.append("electronic_mail[to]", email_to);
    formData.append("electronic_mail[cc]", email_cc);
    formData.append("electronic_mail[bcc]", email_bcc);
    formData.append("electronic_mail[subject]", email_subject);
    formData.append("electronic_mail[body]", email_body);

    formData.append("electronic_mail[file_avatar]", email_attachment);
    var that = this;
    this.model.saveFormData(formData, {
      success: function(){
        that.collection.add(that.model);
        Backbone.history.navigate("#", { trigger: true });
      }
    });

    // var attr = {to: email_to, subject: email_subject, body: email_body ,
    //             cc: email_cc, bcc: email_bcc,  is_draft: false}
    // this.model.save(attr, {
    //   success: function(){
    //     Backbone.history.navigate("#", {trigger: true});
    //   }
    // })
  },
  saveDraft: function(){
    var email_to = $('#email_to').val();
    if(email_to){
      var email_subject = $('#email_subject').val();
      var email_body = $('#email_body').val();

      var attr = {to: email_to, subject: email_subject, body: email_body}
      this.model.save(attr, {
        success: function(){

        }
      })
    }
  }
})

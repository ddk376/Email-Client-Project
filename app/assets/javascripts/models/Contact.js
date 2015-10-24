Email.Models.Contact = Backbone.Model.extend({
   urlRoot: function(){
     return 'api/email_threads/' + this.id + '/'},
   to: function(){

   },
   getDateOrTime: function(){
     var result = "";
     var date24hrsago = new Date().getTime() - (24 *3600);
     var date = new Date(this.escape('created_at'));
     var months =['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
     if(date > date24hrsago){
       result +=date.getHours();
       result += ":";
       result += date.getMinutes();
     }else{
       result += months[date.getMonth()];
       result += " ";
       result += date.getDate();
     }
     return result;
   },
   toJSON: function(){
      var json = {email: _.clone(this.attributes)};
      return json;
    },
   saveFormData: function(formData, options){
    var method = this.isNew() ? "POST" : "PUT";
    var model = this;

    $.ajax({
      url: _.result(model, "url"),
      type: method,
      data: formData,
      processData: false,
      contentType: false,
      success: function(resp){
        model.set(model.parse(resp));
        model.trigger('sync', model, resp, options);
        options.success && options.success(model, resp, options);
      },
      error: function(resp){
        options.error && options.error(model, resp, options);
      }
    });
  }

window.Email = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    this.router = new Email.Routers.Router({$rootEl: $('.window'), $subroot: $('.indexview')});
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Email.initialize();
});

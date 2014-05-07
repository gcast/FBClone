window.FBClone = {
  Models: {},
  Collections: {},
  Views: {},
  Notifiers: {},
  Routers: {},

  initialize: function(options) {

     window.notifier = new FBClone.Notifiers.Notifier();
	   window.notifier.subscribe("post1");

	   Pusher.log = function(message) {
    	console.log(message);
     };

	   FBClone.current_user = new FBClone.Models.User(options.current_user_data, {parse: true})
	   FBClone.messageThreads = new FBClone.Collections.MessageThreads(options.threads_data, {parse: true})

     new FBClone.Routers.MessagesRouter(options)
     Backbone.history.start()
     
  }

};




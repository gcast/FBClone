window.FBClone.Collections.MessageThreads = Backbone.Collection.extend({

	url: "/api/message_threads",

	model: FBClone.Models.MessageThread

});
window.FBClone.Collections.MessageThreads = Backbone.Collection.extend({

	initialize: function() {
		window.notifier.on("posts:change", this.postsChanged, this);
	},

	url: "/api/message_threads",

	model: FBClone.Models.MessageThread,

	postsChanged: function() {
		this.fetch()
	}

});
window.FBClone.Models.MessageThread = Backbone.Model.extend({

	initialize: function() {
		window.notifier.on("posts:change", this.messagesChanged, this);
	},

	urlRoot: "/api/message_threads",

	parse: function(jsonResp) {

		if (jsonResp.messages) {
			this.messages = new FBClone.Collections.Messages(jsonResp.messages, { parse: true })
			delete jsonResp.messages
		}

		return jsonResp

	},

	messagesChanged: function() {
		this.fetch();
	}
	
})
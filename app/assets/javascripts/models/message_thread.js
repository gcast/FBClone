window.FBClone.Models.MessageThread = Backbone.Model.extend({

	urlRoot: "/api/message_threads",

	parse: function(jsonResp) {

		if (jsonResp.messages) {
			this.messages = new FBClone.Collections.Messages(jsonResp.messages, { parse: true })
			delete jsonResp.messages
		}

		return jsonResp

	}
})
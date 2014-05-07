window.FBClone.Models.User = Backbone.Model.extend({
	urlRoot: "/api/users",

	parse: function(resp) {	

		if (resp.friends) {
			this.friends = new FBClone.Collections.Users(resp.friends)
			delete resp.friends
		}

		return resp

	}
})
;

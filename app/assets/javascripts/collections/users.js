window.FBClone.Collections.Users = Backbone.Collection.extend({

	url: "/api/users",

	model: FBClone.Models.User

});
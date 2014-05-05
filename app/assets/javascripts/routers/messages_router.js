window.FBClone.Routers.MessagesRouter = Backbone.Router.extend({

	initialize: function(options) {
		this.user = options.user
		this.messageThreads = FBClone.messageThreads
		this.$rootEl = options.$rootEl
	},

	routes: {
		"" : "threadIndex",
		 "threads/:id": "threadShow"
	},

	threadIndex: function() {
		var threadNewView = new FBClone.Views.ThreadNew
    	this.$rootEl.html(threadNewView.render().$el)

		var threadIndex = new FBClone.Views.ThreadIndex({ collection: this.messageThreads })	
		this.$rootEl.append(threadIndex.render().$el)

		//NEED TO IMPLEMENT A SWAPVIEWS TO REMOVE THESE
	},

	threadShow: function(id) {
		var thread = FBClone.messageThreads.get(id);
		var threadShowView = new FBClone.Views.ThreadShow({ model: thread })

		this.$rootEl.html(threadShowView.render().$el)
	}

	// _swapView: function(view) {
	// 	this.currentView && this.currentView.remove()
	// 	this.currentView = view
	// 	this.$rootEl.html(view.render().$el)
	// }

})


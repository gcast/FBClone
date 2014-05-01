window.FBClone.Routers.MessagesRouter = Backbone.Router.extend({

	initialize: function(options) {
		this.user = options.user
		this.messageThreads = options.messageThreads
		this.$rootEl = options.$rootEl


	},

	routes: {
		"" : "threadIndex"
	},

	threadIndex: function() {
		var threadIndex = new FBClone.Views.ThreadIndex({ collection: this.messageThreads })
		
		// this._swapview(threadIndex)
		
		this.$rootEl.html(threadIndex.render().$el)
	},

	// _swapView: function(view) {
	// 	this.currentView && this.currentView.remove()
	// 	this.currentView = view
	// 	this.$rootEl.html(view.render().$el)
	// }

})


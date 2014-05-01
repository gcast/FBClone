window.FBClone.Views.ThreadIndex = Backbone.View.extend({

	tagName: "section",

  	className: "message-threads",

 	initialize: function(options) {
 		this.other = options.other
 	},

  	template: JST["threads/index"],

  	render: function () {

    	var renderedContent = this.template({ threads: this.collection });
    	this.$el.html(renderedContent);

    	var threadNewView = new FBClone.Views.ThreadNew

    	this.$el.append(threadNewView.render().$el)

    	return this;
  	}
  

});
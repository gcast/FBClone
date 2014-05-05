window.FBClone.Views.ThreadIndex = Backbone.View.extend({

	  tagName: "section",

  	className: "message-threads",

 	  initialize: function() {
      	this.listenTo(this.collection, "sync add change", this.render);
 	  },

  	template: JST["threads/index"],


  	render: function() {
    	var renderedContent = this.template({ threads: this.collection });
    	this.$el.html(renderedContent);

    	return this;
  	}
  

});
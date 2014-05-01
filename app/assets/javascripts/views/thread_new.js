window.FBClone.Views.ThreadNew = Backbone.View.extend({

  tagName: "section",

  className: "new-message-thread",

  template: JST["threads/new"],


  render: function() {
  	
    var renderedContent = this.template({ friends: FBClone.current_user.friends });
    this.$el.html(renderedContent);

    return this;
  },

  events: {
  	"submit form" : "submit"
  },

  submit: function(event) {
  	event.preventDefault();

  	var params = $(event.currentTarget).serialize()

  	console.log(params)

  }


});
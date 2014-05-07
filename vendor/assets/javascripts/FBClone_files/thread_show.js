window.FBClone.Views.ThreadShow = Backbone.View.extend({

	tagName: "section",

  	className: "message-thread",

 	initialize: function() {
      this.listenTo(this.model.messages, "sync add change", this.render)
      this.listenTo(this.model, "sync add change", this.render)
 	},

 	events: {
 		"submit form" : "submit"
 	},

  	template: JST["threads/show"],

  	render: function() {
    	var renderedContent = this.template({ thread: this.model });

    	this.$el.html(renderedContent);

    	return this;
  	},

  	submit: function(event) {
  		event.preventDefault();

  		var that = this.model;

  		var params = $(event.currentTarget).serializeJSON()
  		
  		var recipient_id = 
  			this.model.get("user_one") === FBClone.current_user.id ? this.model.get("user_two") : this.model.get("user_one")

  		var message = new FBClone.Models.Message(params)

  		message.save({}, {
  			success: function() {
  				message.set({
  					thread_id: that.id,
  					sender_id: FBClone.current_user.id,
  					recipient_id: recipient_id,
  					is_read: false 	
  				})

  				that.messages.add(message)
  			}
  		})

  	}

});

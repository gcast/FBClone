window.FBClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function(options) {

    new FBClone.Routers.MessagesRouter(options)

    Backbone.history.start()

  }
};

// DO CLEAN UP LATER

// Backbone.CompositeView = Backbone.View.extend({

// 	addSubview: function (selector, subview) {

// 		var selectorSubviews = 
// 			this.subviews()[selector] || (this.subviews()[selector] = []);

// 		selectorSubviews.push(subview);

// 		var $selectorEl = this.$(selector);
// 		$selectorEl.append(subview.$el)

// 		window.subviews = this.subviews()
// 	},

// 	renderSubviews: function() {
// 		var view = this;

// 		_(this.subviews()).each(function(selectorSubviews, selector){
// 			var $selectorEl = view.$(selector)
// 			$selectorEl.empty();

// 			_(selectorSubviews).each(function(subview){
// 				$selectorEl.append(subview.render().$el);
// 				subview.delegateEvents();
// 			})
// 		})

// 	},

// 	subviews: function () {
//     	if (!this._subviews) {
//     	  this._subviews = {};
//     	}

//     	return this._subviews;
//   	}

// });



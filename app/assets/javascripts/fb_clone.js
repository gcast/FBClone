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


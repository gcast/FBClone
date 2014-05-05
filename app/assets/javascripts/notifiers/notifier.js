window.FBClone.Notifiers.Notifier = (function() {

  function Notifier() {
    _.extend(this, Backbone.Events);

    // ENV THING DOESNT WORK //

    this.pusher = new Pusher('69f375190cbaa886558e');
    this.channels = {};

  }

  Notifier.prototype.subscribe = function(channel) {

    var self = this;
    this.channels[channel] = this.pusher.subscribe(channel);

    this.channels[channel].bind_all(function(event, data) {
      console.log("event", event, "data", data)
      self.trigger(event, data);
    });
    
  };

  return Notifier;

})();
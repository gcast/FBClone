(function(root){

	var Asteroids = root.Asteroids = (root.Asteroids || {})

	var Bullet = Asteroids.Bullet = function(direction, position) {
		var normalizedDirection = this.normalizeDirection(direction)
		var vel = [normalizedDirection[0]*Bullet.SPEED, normalizedDirection*Bullet.SPEED]

		Asteroids.MovingObject.call(this, position, vel, Bullet.RADIUS, Bullet.COLOR);
	};

	Bullet.inherits(Asteroids.MovingObject)
	Bullet.SPEED = 10
	Bullet.RADIUS = 1;
   	Bullet.COLOR = "red";

	Bullet.prototype.normalizeDirection = function(direction) {
		var dx = direction[0];
     	var dy = direction[1];
     	var magnitude = Math.sqrt((dx * dx) + (dy * dy));

     	return [dx / magnitude, dy / magnitude];
	}

})(this);
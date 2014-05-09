(function(root){

	var Asteroids = root.Asteroids = (root.Asteroids || {});

	var Asteroid = Asteroids.Asteroid = function(pos, vel) {
		Asteroids.MovingObject.call(this, pos, vel, Asteroid.RAD, Asteroid.COL)
	}

	Asteroid.inherits(Asteroids.MovingObject);
	Asteroid.COL = "grey";
	Asteroid.RAD = 20;

	Asteroid.randomAsteroid = function(dimX, dimY) {
		var x = Math.random() * dimX
		var y = Math.random() * dimY
		var vel = [Math.random() * 2, Math.random() * 2]

		return new Asteroid([x,y], vel)
	}

})(this)
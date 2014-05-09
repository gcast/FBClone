(function(root){

	var Asteroids = root.Asteroids = (root.Asteroids || {});

	var MovingObject = Asteroids.MovingObject = function (pos, vel, rad, col) {
		this.pos = pos;
		this.vel = vel;
		this.rad = rad; 
		this.col = col;
	}

	MovingObject.prototype = function() {
		this.pos[0] += this.vel[0];
		this.pos[1] += this.vel[1];
	}

	MovingObject.prototype.draw = function(context) {
		context.fillStyle = this.col;
    	context.beginPath(); 
	
    	ctx.arc(
    	  this.pos[0], this.pos[1],
    	  this.rad,
    	  0, 2 * Math.PI,
    	  false
    	);

    	ctx.fill();
	}

	MovingObject.prototype.isCollidedWith = function(object) {

    	var dx2 = Math.pow((this.pos[0] - object.pos[0]), 2);
    	var dy2 = Math.pow((this.pos[1] - object.pos[1]), 2);
    	var distance = Math.sqrt((dx2) + (dy2));

    	return (distance <= (this.rad + object.rad));
	}

	MovingObject.prototype.move = function(){
    	this.pos[0] += this.vel[0];
    	this.pos[1] += this.vel[1];
  	};

})(this);


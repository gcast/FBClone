(function(root){

	var Asteroids = root.Asteroids = (root.Asteroids || {})

	var Ship = Asteroids.Ship = function(pos, vel) {
		Asteroids.MovingObject.call(this, pos, vel, Ship.RAD, Ship.COL);
	}

	Ship.inherits(Asteroids.MovingObject)
	Ship.RAD = 10
	Ship.COL = "Black"

	Ship.prototype.power = function(impulse) {
		this.vel[0] += impulse[0]
		this.vel[1] += impulse[1]
	};


   Ship.prototype.fireBullet = function(){
   	
     if(this.vel != [0,0]){
        var bulletVel = this.vel.slice(0);
        var bulletPos = this.pos.slice(0);
        var bullet = new Asteroids.Bullet(bulletVel, bulletPos);

        return bullet;

     } else {
       return null;
     };

   };

})(this);
/**
 * Bullet
 * -- Part of the Flixel Power Tools set
 * 
 * v1.2 Removed "id" and used the FlxSprite ID value instead
 * v1.1 Updated to support fire callbacks, sounds, random variances and lifespan
 * v1.0 First release
 * 
 * @version 1.2 - October 10th 2011
 * @link http://www.photonstorm.com
 * @author Richard Davey / Photon Storm
*/

package org.flixel.plugin.photonstorm.BaseTypes 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxMath;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import flash.utils.getTimer;

	public class Bullet extends FlxSprite
	{
		protected var weapon:FlxWeapon;
		
		protected var bulletSpeed:int;
		
		//	Acceleration or Velocity?
		public var accelerates:Boolean;
		public var xAcceleration:int;
		public var yAcceleration:int;
		
		public var rndFactorAngle:uint;
		public var rndFactorSpeed:uint;
		public var rndFactorLifeSpan:uint;
		public var lifespan:uint;
		public var launchTime:uint;
		public var expiresTime:uint;
		
		protected var animated:Boolean;
		
		public function Bullet(weapon:FlxWeapon, id:uint)
		{
			super(0, 0);
			
			this.weapon = weapon;
			this.ID = id;
			
			//	Safe defaults
			accelerates = false;
			animated = false;
			bulletSpeed = 0;
			
			exists = false;
		}
		
		/**
		 * Adds a new animation to the sprite.
		 * 
		 * @param	Name		What this animation should be called (e.g. "run").
		 * @param	Frames		An array of numbers indicating what frames to play in what order (e.g. 1, 2, 3).
		 * @param	FrameRate	The speed in frames per second that the animation should play at (e.g. 40 fps).
		 * @param	Looped		Whether or not the animation is looped or just plays once.
		 */
		override public function addAnimation(Name:String, Frames:Array, FrameRate:Number = 0, Looped:Boolean = true):void
		{
			super.addAnimation(Name, Frames, FrameRate, Looped);
			
			animated = true;
		}
		
		public function fire(fromX:int, fromY:int, velX:int, velY:int):void
		{
			x = fromX + FlxMath.rand( -weapon.rndFactorPosition.x, weapon.rndFactorPosition.x);
			y = fromY + FlxMath.rand( -weapon.rndFactorPosition.y, weapon.rndFactorPosition.y);
			
			if (accelerates)
			{
				acceleration.x = xAcceleration + FlxMath.rand( -weapon.rndFactorSpeed, weapon.rndFactorSpeed);
				acceleration.y = yAcceleration + FlxMath.rand( -weapon.rndFactorSpeed, weapon.rndFactorSpeed);
			}
			else
			{
				velocity.x = velX + FlxMath.rand( -weapon.rndFactorSpeed, weapon.rndFactorSpeed);
				velocity.y = velY + FlxMath.rand( -weapon.rndFactorSpeed, weapon.rndFactorSpeed);
			}
			
			postFire();
		}
		
		public function fireAtMouse(fromX:int, fromY:int, speed:int):void
		{
			x = fromX + FlxMath.rand( -weapon.rndFactorPosition.x, weapon.rndFactorPosition.x);
			y = fromY + FlxMath.rand( -weapon.rndFactorPosition.y, weapon.rndFactorPosition.y);
			
			if (accelerates)
			{
				FlxVelocity.accelerateTowardsMouse(this, speed + FlxMath.rand( -weapon.rndFactorSpeed, weapon.rndFactorSpeed), maxVelocity.x, maxVelocity.y);
			}
			else
			{
				FlxVelocity.moveTowardsMouse(this, speed + FlxMath.rand( -weapon.rndFactorSpeed, weapon.rndFactorSpeed));
			}
			
			postFire();
		}
		
		public function fireAtPosition(fromX:int, fromY:int, toX:int, toY:int, speed:int):void
		{
			x = fromX + FlxMath.rand( -weapon.rndFactorPosition.x, weapon.rndFactorPosition.x);
			y = fromY + FlxMath.rand( -weapon.rndFactorPosition.y, weapon.rndFactorPosition.y);
			
			if (accelerates)
			{
				FlxVelocity.accelerateTowardsPoint(this, new FlxPoint(toX, toY), speed + FlxMath.rand( -weapon.rndFactorSpeed, weapon.rndFactorSpeed), maxVelocity.x, maxVelocity.y);
			}
			else
			{
				FlxVelocity.moveTowardsPoint(this, new FlxPoint(toX, toY), speed + FlxMath.rand( -weapon.rndFactorSpeed, weapon.rndFactorSpeed));
			}
			
			postFire();
		}
		
		public function fireAtTarget(fromX:int, fromY:int, target:FlxSprite, speed:int):void
		{
			x = fromX + FlxMath.rand( -weapon.rndFactorPosition.x, weapon.rndFactorPosition.x);
			y = fromY + FlxMath.rand( -weapon.rndFactorPosition.y, weapon.rndFactorPosition.y);
			
			if (accelerates)
			{
				FlxVelocity.accelerateTowardsObject(this, target, speed + FlxMath.rand( -weapon.rndFactorSpeed, weapon.rndFactorSpeed), maxVelocity.x, maxVelocity.y);
			}
			else
			{
				FlxVelocity.moveTowardsObject(this, target, speed + FlxMath.rand( -weapon.rndFactorSpeed, weapon.rndFactorSpeed));
			}
			
			postFire();
		}
		
		public function fireFromAngle(fromX:int, fromY:int, fireAngle:int, speed:int):void
		{
			x = fromX + FlxMath.rand( -weapon.rndFactorPosition.x, weapon.rndFactorPosition.x);
			y = fromY + FlxMath.rand( -weapon.rndFactorPosition.y, weapon.rndFactorPosition.y);
			
			var newVelocity:FlxPoint = FlxVelocity.velocityFromAngle(fireAngle + FlxMath.rand( -weapon.rndFactorAngle, weapon.rndFactorAngle), speed + FlxMath.rand( -weapon.rndFactorSpeed, weapon.rndFactorSpeed));
			
			if (accelerates)
			{
				acceleration.x = newVelocity.x;
				acceleration.y = newVelocity.y;
			}
			else
			{
				velocity.x = newVelocity.x;
				velocity.y = newVelocity.y;
			}
			
			postFire();
		}
		
		private function postFire():void
		{
			if (animated)
			{
				play("fire");
			}
			
			if (weapon.bulletElasticity > 0)
			{
				elasticity = weapon.bulletElasticity;
			}
			
			exists = true;
			
			launchTime = getTimer();
			
			if (weapon.bulletLifeSpan > 0)
			{
				lifespan = weapon.bulletLifeSpan + FlxMath.rand( -weapon.rndFactorLifeSpan, weapon.rndFactorLifeSpan);
				expiresTime = getTimer() + lifespan;
			}
			
			if (weapon.onFireCallback is Function)
			{
				weapon.onFireCallback.apply();
			}
			
			if (weapon.onFireSound)
			{
				weapon.onFireSound.play();
			}
		}
		
		public function set xGravity(gx:int):void
		{
			acceleration.x = gx;
		}
		
		public function set yGravity(gy:int):void
		{
			acceleration.y = gy;
		}
		
		public function set maxVelocityX(mx:int):void
		{
			maxVelocity.x = mx;
		}
		
		public function set maxVelocityY(my:int):void
		{
			maxVelocity.y = my;
		}
		
		override public function update():void
		{
			if (lifespan > 0 && getTimer() > expiresTime)
			{
				kill();
			}
			
			if (FlxMath.pointInFlxRect(x, y, weapon.bounds) == false)
			{
				kill();
			}
		}
		
	}

}
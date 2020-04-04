package org.flixel.plugin.photonstorm.BaseTypes 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxExtendedSprite;
	
	public class MouseSpring 
	{
		public var sprite:FlxExtendedSprite;
		
		/**
		 * The tension of the spring, smaller numbers create springs closer to the mouse pointer
		 * @default 0.1
		 */
		public var tension:Number = 0.1;
		
		/**
		 * The friction applied to the spring as it moves
		 * @default 0.95
		 */
		public var friction:Number = 0.95;
		
		/**
		 * The gravity controls how far "down" the spring hangs (use a negative value for it to hang up!)
		 * @default 0
		 */
		public var gravity:Number = 0;
		
		private var retainVelocity:Boolean = false;
		
		private var vx:Number = 0;
		private var vy:Number = 0;
	
		private var dx:Number = 0;
		private var dy:Number = 0;
		
		private var ax:Number = 0;
		private var ay:Number = 0;
		
		/**
		 * Adds a spring between the mouse and a Sprite.
		 * 
		 * @param	sprite				The FlxExtendedSprite to which this spring is attached
		 * @param	retainVelocity		true to retain the velocity of the spring when the mouse is released, or false to clear it
		 * @param	tension				The tension of the spring, smaller numbers create springs closer to the mouse pointer
		 * @param	friction			The friction applied to the spring as it moves
		 * @param	gravity				The gravity controls how far "down" the spring hangs (use a negative value for it to hang up!)
		 */
		public function MouseSpring(sprite:FlxExtendedSprite, retainVelocity:Boolean = false, tension:Number = 0.1, friction:Number = 0.95, gravity:Number = 0)
		{
			this.sprite = sprite;
			this.retainVelocity = retainVelocity;
			this.tension = tension;
			this.friction = friction;
			this.gravity = gravity;
		}
		
		/**
		 * Updates the spring physics and repositions the sprite
		 */
		public function update():void
		{
			dx = FlxG.mouse.x - sprite.springX;
			dy = FlxG.mouse.y - sprite.springY;
			
			ax = dx * tension;
			ay = dy * tension;
			
			vx += ax;
			vy += ay;
			
			vy += gravity;
			vx *= friction;
			vy *= friction;
			
			sprite.x += vx;
			sprite.y += vy;
		}
		
		/**
		 * Resets the internal spring physics
		 */
		public function reset():void
		{
			vx = 0;
			vy = 0;
		
			dx = 0;
			dy = 0;
			
			ax = 0;
			ay = 0;
		}
		
	}

}
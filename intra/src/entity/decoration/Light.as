package entity.decoration 
{
	import flash.geom.Point;
	import global.Registry;
	import helper.EventScripts;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Light extends FlxSprite
	{
		[Embed (source = "../../res/sprites/light/glow-light.png")] public var GLOW_LIGHT:Class;
		[Embed (source = "../../res/sprites/light/cone-light.png")] public var CONE_LIGHT:Class;
		[Embed (source = "../../res/sprites/light/5-frame-glow.png")] private var FIVE_FRAME_GLOW:Class;
		[Embed (source = "../../res/sprites/light/beach-screen-light.png")] private var BEACH_GLOW:Class;
		
		public static var T_GLOW_LIGHT:int = 0;
		public static var T_FIVE_FRAME_GLOW:int = 1;
		public static var T_CONE_LIGHT:int = 2;
		public static var T_BEACH_GLOW:int = 3;
		public static var T_BEDROOM_BOUNCE:int = 4;
		private var locked_on:Boolean = false;
		private var lock_latency:Number = 2.0;
		private var lock_latency_max:Number = 2.0;
		private var current_room:Point = new Point(0, 0);
		
		public static var L_PLAYER:int = 1;
		public static var L_SUN_GUY_ORBS:int = 2;
		public static var L_BEDROOM_BOUNCE:int = 3;
		
		public var darkness:FlxSprite;
		public var followee:FlxSprite;
		public var flicker_rate:int = 0;
		public var base_x_scale:Number = 3.0;
		public var base_y_scale:Number = 3.0;
		public var flicker_timer:int = flicker_rate;
		public var special_type:int = 0;
		
		public var xml:XML;
		/**
		 * Creates a light at the given point, to be blended with the darkness reference. Specifying the type will
		 * determine what to use. Client must specify the animation  and offset. 
		 * @param	_x
		 * @param	_y
		 * @param	_darkness A reference to the darkness sprite to draw into
		 * @param	type  What type of light sprite to use
		 * @param	follows   
		 * @param	_followee The sprite to follow
		 * @param _flicker_rate
		 * @param _special_type
		 */
		public function Light(_x:int, _y:int, _darkness:FlxSprite, type:int, follows:Boolean = false, _followee:FlxSprite=null,_flicker_rate:int=0,_special_type:int=0) 
		{
			super(_x, _y);
			xml = <Light/>;
			setlighttype(type);
			
			flicker_rate = _flicker_rate;
			darkness = _darkness;
			special_type = _special_type;
			blend = "screen";
			
			followee = _followee;
			if (follows) {
				x = followee.x - ((followee.width - width) / 2);
				y = followee.y - ((followee.height - height) / 2);
			}
		}
		
		override public function update():void {
			if (followee != null) {
				if (special_type == L_PLAYER) {
					x = followee.x- ((width - followee.width) / 2);
					y = followee.y - ((height - followee.height) / 2) - 16;
				} else if (special_type == L_SUN_GUY_ORBS) {
					x = followee.x + (followee.width / 2) - 26;
					y = followee.y + (followee.height / 2) - 45;
				} else if (special_type == L_BEDROOM_BOUNCE) {
					if (velocity.x > 0) {
						if (x > Registry.SCREEN_WIDTH_IN_PIXELS) {
							velocity.x *= -1;
						} 
					} else {
						if (x < 0) {
							velocity.x *= -1;
						}
					}
					if (velocity.y > 0) {
						if (y > Registry.SCREEN_HEIGHT_IN_PIXELS) {
							velocity.y *= -1;
						} 
					} else {
						if (y < 0) {
							velocity.y *= -1;
						}
					}
					
					lock_latency -= FlxG.elapsed;
					/* Wait for a bit before locking onto the player */
					if (overlaps(followee, true) && lock_latency < 0) {
						locked_on = true;
						velocity.x = velocity.y = 0;
					}
					/* If locked on follow the player */
					if (locked_on) {
						var _x:int = (followee.x - ((width - followee.width) / 2)) % Registry.SCREEN_WIDTH_IN_PIXELS;
						var _y:int = ((followee.y - 20) % Registry.SCREEN_HEIGHT_IN_PIXELS) - 16;
						EventScripts.send_property_to(this, "x", _x, 0.5);
						EventScripts.send_property_to(this, "y", _y, 0.5);
					} else { /* Randomize the velocity a bit */
						velocity.x += (Math.random() * 2 + -1);
						velocity.y += (Math.random() * 2 + -1);
					}
					/* Unlock on room transition */
					if (Registry.CURRENT_GRID_X != current_room.x || Registry.CURRENT_GRID_Y != current_room.y) {
						locked_on = false;
						lock_latency = lock_latency_max;
						current_room.x = Registry.CURRENT_GRID_X;
						current_room.y = Registry.CURRENT_GRID_Y;
						randomize_velocity();
					}
					
					/* Not visible if sun boss defeated. */
					if (Registry.GE_States[Registry.GE_Bedroom_Boss_Dead_Idx]) {
						visible = false;
					}
				}
				
			}
			
			
			
			flicker_timer--;
			if (flicker_timer < 0 && flicker_rate != 0) {
				scale.x = base_x_scale + Math.random() * 0.2;
				scale.y = base_y_scale + Math.random() * 0.2;
				flicker_timer = flicker_rate;
			} else {
				scale.x = base_x_scale;
				scale.y = base_y_scale;
			}
			
			super.update();
		}
		override public function draw():void {
			var screenXY:FlxPoint = getScreenXY();
			darkness.stamp(this, screenXY.x, screenXY.y);
		}
		
		private function randomize_velocity():void 
		{
			var i:int = int(4 * Math.random());
			var base_speed:int = 30;
			switch (i) {
				case 0:
					velocity.x  = velocity.y = base_speed; break;
				case 1:
					velocity.x  = velocity.y = -base_speed; break;
				case 2:
					velocity.x = base_speed; velocity.y = -base_speed; break;
				case 3:
					velocity.x = -base_speed; velocity.y = base_speed; break;
			}
		}
		
		public function setlighttype(type:int):void 
		{
			
			if (type == T_GLOW_LIGHT) {
				loadGraphic(GLOW_LIGHT, false, false, 64, 64);
				framePixels.colorTransform(framePixels.rect, new ColorTransform(0.5, 0.5, 1, 1, 0, 0, -5));
			} else if (type == T_FIVE_FRAME_GLOW) {
				loadGraphic(FIVE_FRAME_GLOW, true, false, 48, 48);
			} else if (type == T_CONE_LIGHT) {
				loadGraphic(CONE_LIGHT, false, false, 32, 32);
				base_x_scale = 0.2;
				base_y_scale = 0.2;
			} else if (type == T_BEACH_GLOW) {
				loadGraphic(BEACH_GLOW, false, false, 160, 160);
				base_x_scale = base_y_scale = 1;
				scrollFactor = new FlxPoint(0, 0);
			} else if (type == T_BEDROOM_BOUNCE) {
				special_type = L_BEDROOM_BOUNCE;
				loadGraphic(GLOW_LIGHT, false, false, 64, 64);
				scrollFactor = new FlxPoint(0, 0);
				x = 160 * Math.random();
				y = 160 * Math.random();
				randomize_velocity();
				base_x_scale = base_y_scale = 2;
				current_room.x = Registry.CURRENT_GRID_X;
				current_room.y = Registry.CURRENT_GRID_Y;
				//x = followee.x - ((followee.width - width) / 2);
				//y = followee.y - ((followee.height - height) / 2);
			}
		}
	}

}
package helper 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Parabola_Thing 
	{
	
		/**
		 */
		/**
		* helper class for making stuff move like a parabola. when tick is called it will
		* change the given PROPERTY. changes it over a PERIOD of time, reaches MAX value..
		* up to you to use the return stuff blahbalh
		* DOESNT CHECK FOR ERRORS so get your values right. ia m lazy
		 * @param	s
		 * @param	max
		 * @param	period
		 * @param	property
		 */
		
		private var sprite_ref:FlxSprite;
		private var height:Number;
		public var period:Number;
		public var t:Number;
		private var coeff:Number;
		private var prop:String;
		private var subprop:String;
		
		private var shadow_fall_anim:String;
		
		private var has_fallen:Boolean = true;
		
		public var OFFSET:int = 0;
		
		public function Parabola_Thing(s:FlxSprite,_height:Number,_period:Number,_property:String,_subprop:String="")
		{
			sprite_ref = s;
			height = _height;
			period = _period;
			prop = _property;
			subprop = _subprop;
			t = 0;
			coeff = get_parabola_coeff(height, period);
			
		}
		
		public function destroy():void {
			sprite_ref = null;
		}
		/**
		 * Set an animation for the shadow to play when it falls.
		 * (Falls = current t > period/2)
		 * @param	name
		 */
		public function set_shadow_fall_animation(name:String):void {
			shadow_fall_anim = name;
			has_fallen = false;
		}
		/**
		 * changes its set property according to the parabola and blah blah.
		 * @return 1 if done, 0 if not. might be useful, but this sets "done" for you anyways
		 */
		public function tick():int {
			
			if (t > period) {
				return 1;
			} 
			if (!has_fallen && (t > period/2)) {
				has_fallen = true;
				sprite_ref.my_shadow.play(shadow_fall_anim);
			}
			if (subprop != "") {
				sprite_ref[prop][subprop] = OFFSET + get_next_parabola_param(t, period, coeff);
			} else {
				sprite_ref[prop] = OFFSET + get_next_parabola_param(t, period, coeff);
			}
			
			t += FlxG.elapsed;
			return 0;
		}
		
		
		public function reset_time():void {
			t = 0;
		}
		/* Returns the coefficient for  a parameterization of parabola-like path */
		
		public static function get_parabola_coeff(h:Number, period:Number):Number {
			return (-4*h)/(period*period);
		}
		
		/**
		 * given current time, period, and coeff, return the next value of
		 * what ever value is being changed
		 * @return next value yo
		 */
		public static function get_next_parabola_param(t:Number,period:Number,coeff:Number):Number {
			return  coeff * t * (t - period);
		}
		
		
	}

}
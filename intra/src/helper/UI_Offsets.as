package helper 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Copyright Melos Han-Tani, Developer of Analgesic Productions LLC, 2013 - ? , www.twitter.com/seagaia2
	 */
	public class UI_Offsets 
	{
		
		public function UI_Offsets() 
		{
			// Set defaults
		}
		
		public var save_array:Array;
		
		public var portrait_dpad:Point = new Point();
		public var portrait_x_a1:Point = new Point();
		public var portrait_c_a2:Point = new Point();
		public var portrait_pause:Point = new Point();
		public var portrait_game:Point = new Point();
		
		public var landscape_dpad:Point = new Point();
		public var landscape_x_a1:Point = new Point();
		public var landscape_c_a2:Point = new Point();
		public var landscape_pause:Point = new Point();
		public var landscape_game:Point = new Point();
	
		public var scale_portrait_dpad:Number = 1;
		public var scale_portrait_x_a1:Number = 1;
		public var scale_portrait_c_a2:Number = 1;
		public var scale_portrait_pause:Number = 1;
		public var scale_portrait_game:Number = 1;
		
		public var scale_landscape_dpad:Number = 1;
		public var scale_landscape_x_a1:Number = 1;
		public var scale_landscape_c_a2:Number = 1;
		public var scale_landscape_pause:Number = 1;
		public var scale_landscape_game:Number = 1;
		
		public function get_save_array():Array {
			var a:Array = new Array(
			portrait_dpad.x, portrait_dpad.y, scale_portrait_dpad,
			portrait_x_a1.x, portrait_x_a1.y, scale_portrait_x_a1,
			portrait_c_a2.x, portrait_c_a2.y, scale_portrait_c_a2,
			portrait_pause.x, portrait_pause.y, scale_portrait_pause,
			portrait_game.x,portrait_game.y,scale_portrait_game,
			landscape_dpad.x, landscape_dpad.y, scale_landscape_dpad,
			landscape_x_a1.x, landscape_x_a1.y, scale_landscape_x_a1,
			landscape_c_a2.x, landscape_c_a2.y, scale_landscape_c_a2,
			landscape_pause.x, landscape_pause.y, scale_landscape_pause,
			landscape_game.x,landscape_game.y,scale_landscape_game);
			return a;
			
			
		}
		
		public function load_save_array(a:Array):void {
			if (a == null) return;
			save_array = a;
			portrait_dpad.x = a[0]; portrait_dpad.y = a[1]; scale_portrait_dpad = a[2];
			portrait_x_a1.x = a[3]; portrait_x_a1.y = a[4]; scale_portrait_x_a1 = a[5];
			portrait_c_a2.x = a[6]; portrait_c_a2.y = a[7]; scale_portrait_c_a2 = a[8];
			portrait_pause.x = a[9]; portrait_pause.y = a[10]; scale_portrait_pause = a[11];
			portrait_game.x = a[12]; portrait_game.y = a[13]; scale_portrait_game = a[14];
			landscape_dpad.x = a[15]; landscape_dpad.y = a[16]; scale_landscape_dpad = a[17];
			landscape_x_a1.x = a[18]; landscape_x_a1.y = a[19]; scale_landscape_x_a1 = a[20];
			landscape_c_a2.x = a[21]; landscape_c_a2.y = a[22]; scale_landscape_c_a2 = a[23];
			landscape_pause.x = a[24]; landscape_pause.y = a[25]; scale_landscape_pause = a[26];
			landscape_game.x = a[27]; landscape_game.y = a[28]; scale_landscape_game = a[29];
		}
		
		public function set_defaults(sw:int, sh:int,fsw:int,fsh:int,only_land:Boolean=false,only_portrait:Boolean=false):void {
			
			var l:int = sw > sh ? sw : sh;
			var s:int = sw > sh ? sh : sw;
			
			trace(s, l);
			 //Landscape
			//scale_landscape_game = int(3 * (s / 540.0)) / 3.0;
			if (!only_portrait) {
			scale_landscape_game = (s / 540.0);
			
			var margin_w:int = (l - 480.0 * scale_landscape_game) / 2;
			scale_landscape_dpad = int(4 * ((margin_w - 8) / 144.0)) / 4.0;
			if (scale_landscape_dpad <= 0.85) {
				scale_landscape_dpad = 1;
			}
			landscape_dpad.x = (margin_w - 144.0 * scale_landscape_dpad) / 2.0;
			if (s < 600) {
				landscape_dpad.y = (s - 144.0 * scale_landscape_dpad);
			} else {
				landscape_dpad.y = (s - 144.0 * scale_landscape_dpad) / 2.0;
			}
			if (landscape_dpad.x < 0) landscape_dpad.x = 0;
			
			scale_landscape_x_a1 = scale_landscape_c_a2 = int (4 * ((margin_w - 6 ) / (2 * 48.0))) / 4.0;
			if (scale_landscape_c_a2 < 1) {
				scale_landscape_c_a2 = scale_landscape_x_a1 = 1;
			}
			landscape_x_a1.x = (l - margin_w) + ((margin_w / 2) - (48.0 * scale_landscape_x_a1)) / 2.0;
			landscape_c_a2.x = landscape_x_a1.x + (margin_w / 2);
			
			var action_bottom:int = 3 * (s / 5.0);
			landscape_x_a1.y = action_bottom - 96.0 * scale_landscape_x_a1;
			landscape_c_a2.y = action_bottom - 96.0 * scale_landscape_c_a2;
			
			scale_landscape_pause = int (4 * ((margin_w - 6 ) / 96.0)) / 4.0;
			landscape_pause.x = (l - margin_w) + (margin_w - (scale_landscape_pause * 96.0)) / 2;
			landscape_pause.y = s - 4.0 - 48 * scale_landscape_pause;
			
			
			landscape_game.x = (l - 480.0 * scale_landscape_game) / 2;
			landscape_game.x /= scale_landscape_game; // ???
			landscape_game.y = (s - 540.0 * scale_landscape_game) / 2;
			landscape_game.y /= scale_landscape_game;
			}
			// Portrait
			//scale_portrait_game = int(3*((2*l / 3) / 480.0))/3.0;
			if (!only_land) {
			scale_portrait_game =Math.min((2 * l / 3) / 480.0, s / 480.0);
			var game_bottom:int = scale_portrait_game * 540.0;
			var margin_h:int = l - game_bottom;
			action_bottom = (game_bottom + (3 / 4) * margin_h);
			margin_w = s / 2;
			
			scale_portrait_dpad = int(3 * ((Math.min(margin_h, margin_w) * 0.9) / 144.0)) / 3.0;
			if (scale_portrait_dpad <= 1) {
				scale_portrait_dpad = 0.85;
			}
			portrait_dpad.x = (margin_w - 144.0 * scale_portrait_dpad) / 2.0;
			portrait_dpad.y = ((margin_h - scale_portrait_dpad * 144.0) / 2) + game_bottom;
			
			scale_portrait_c_a2 = scale_portrait_x_a1 = Math.min( int(4 * ((margin_w * 0.8) / (2 * 48.0))) / 4.0, int(4 * (((3 / 4) * margin_h - 6) / 96.0)) / 4.0);
			if (scale_portrait_c_a2 < 1) { // on a fucking iphone
				scale_portrait_c_a2 = 0.86;
				scale_portrait_x_a1 = 0.86;
			}
			portrait_x_a1.x = (margin_w) + ((margin_w / 2.0) - (48.0 * scale_portrait_x_a1)) / 2.0;
			portrait_c_a2.x = portrait_x_a1.x + (margin_w / 2.0);
			
			portrait_c_a2.y = portrait_x_a1.y = game_bottom + ((action_bottom - game_bottom) - (scale_portrait_c_a2 * 96.0)) / 2.0;
			
			scale_portrait_pause = Math.min(int(((margin_w * 0.8) / 96.0) * 2) / 2.0, int(((margin_h * 0.9 * .25) / 48.0) * 2) / 2.0);
			if (scale_portrait_pause < 1) scale_portrait_pause = 0.77;
			portrait_pause.x = ((margin_w - 96.0 * scale_portrait_pause) / 2) + margin_w;
			portrait_pause.y = action_bottom + ((l - action_bottom) - (48.0 * scale_portrait_pause)) / 2.0;
	
			if (scale_portrait_pause < 1) {
				portrait_pause.y -= 2;
			}
			
			
			portrait_game.x = (s - 480.0 * scale_portrait_game) / 2;
			portrait_game.x /= scale_portrait_game;
			portrait_game.y = 0;
			}
			//scale_portrait_game = int(3*((2*l / 3) / 480.0))/3.0;
			//scale_landscape_game = int(3 * (s / 540.0)) / 3.0;	
			
			
			
			//Intra.scale_ctr = Intra.SCALE_TYPE_FIT;
			//var i:Intra = FlxG._game as Intra;
			//i.resize_mobile_game();
		}
	}

}
package entity.interactive 
{
	import entity.enemy.bedroom.Sun_Guy;
	import entity.interactive.npc.Forest_NPC;
	import flash.geom.Point;
	import global.Registry;
	import org.flixel.AnoSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import org.flixel.plugin.photonstorm.FlxMath;
	
	
	/**
	 * uses multiple draw calls to make a black square with other
	 * black squares that do silly things via sin/linear interpolation
	 * 
	 * FUN CLASS PROJECT make a class thing to hold timer/state/etc states and
	 * do this all with wrapper functions
	 */
	
	
	public class Black_Thing extends AnoSprite 
	{
		
		private var is_green:Boolean = false;
		
		public function Black_Thing(a:Array) 
		{
			super(a);	
			
			make_sin_table_180();
			makeGraphic(32, 32, 0xff000000);
			
			if (Registry.CURRENT_MAP_NAME == "FOREST") {
				is_green = true;
				loadGraphic(Forest_NPC.embed_forest_npcs, true, false, 16, 16);
				addAnimation("walk", [32, 33], 4);
				play("walk");
				x = tl.x ;
			}
		}
		
		private var dumct:int = 0;
		private var t_yell:Number = 0;
		private var t_lol:Number = 0;
		
		override public function update():void 
		{
			
			if (is_green) {
				if (x > tl.x + 80 && x < tl.x + 160	) {
					Registry.GRID_PUZZLES_DONE = 1;
				} else if (x > tl.x + 160) {
					Registry.GRID_PUZZLES_DONE = 2;
				}
				
				t_yell += FlxG.elapsed;
				if (t_yell > 0.5) {
					Registry.sound_data.play_sound_group(Registry.sound_data.rat_move);
					t_yell = 0;
				}
				
				t_lol += FlxG.elapsed;
				if (x < tl.x + 80) {
					if (t_lol > 1) {
						x += 1;
						t_lol = 0;
					}
				} else { // ~100 minutes
					if (t_lol > 80) {
						t_lol = 0;
						x += 1;
					}
				}
			//if (FlxG.keys.J) {
				//t_lol = 90;
			//}
				if (player.velocity.x != 0 || player.velocity.y != 0) {
					x -= 1;
				}
				super.update();
				return;
			}
			
			if (player.overlaps(this) && Registry.keywatch.JP_ACTION_2) {
				Registry.sound_data.fall_in_hole.play();
				dumct++;
				if (dumct > 50) {
					mm1.y = 10;
					mm2.y = 12;
					mm3.y = 9;
					Registry.GRID_PUZZLES_DONE++;
				}
			}
			super.update();
		}
		
		
		private var scale1:Number = 0.5;
		private var mm1:Point = new Point(0.5, 2);
	
		private var scale2:Number = 2;
		private var mm2:Point = new Point(0.5, 2);
		
		private var scale3:Number = 3;
		private var mm3:Point = new Point(0.75, 3);
		
		
		
		private var state1:int = 0;
		private var state2:int = 0;
		private var state3:int = 0;
		
		private var t3:Number = 0;
		private var t3_m:Number = 1;
		
		// vals between 0 and 1
		private var sin_table_180:Array;
		
		public function make_sin_table_180():void {
			sin_table_180 = new Array;
			for (var i:int = 0; i < 180; i++) {
				sin_table_180.push((1 + Math.sin( (i / 180.0) * 6.28))/2);
			}
		}
		
		private var rate:Number = 0.03;
		override public function draw():void 
		{
			if (is_green) {
				super.draw();
				return;
			}
			alpha = 0.25;
			color = 0xff0000;
			
			scale.x = scale.y = scale1;
			
			

			if (state1 == 0)  {
				scale1 += rate;
				if (scale1 > mm1.y) {
					state1 = 1;
				}
			} else if (state1 == 1) {
				scale1 -= rate;
				if (scale1 < mm1.x) {
					state1 = 0;
				}
			}
			super.draw();
			
			
			
			alpha = 0.5;
			color = 0x00ff00;
			scale.x = scale.y = scale2;
			

			if (state2 == 0)  {
				scale2 += rate;
				if (scale2 > mm2.y) {
					state2 = 1;
				}
			} else if (state2 == 1) {
				scale2 -= rate;
				if (scale2 < mm2.x) {
					state2 = 0;
				}
			}
			
			super.draw();
			
			alpha = 0.7;
			color = 0x0000ff;
			scale.x = scale.y = scale3;
			t3 += FlxG.elapsed;
			if (t3 > t3_m) {
				t3 = 0;
			}
			
			scale3 = sin_table_180[int(180 * (t3 / t3_m))] * (mm3.y - mm3.x) + mm3.x;
			
			angle = get_sin_table_180(t3, t3_m, -90, 90);
			super.draw();
			
			color = 0x000000;
			angle = 0;
			scale.x = scale.y = 1;
			alpha = 0.3;
			super.draw();
		}
		
		public function get_sin_table_180(t:Number,tm:Number,min:Number,max:Number):Number {
			return sin_table_180[int(180 * (t3 / t3_m))] * (max - min) + min;
		}
	}

}
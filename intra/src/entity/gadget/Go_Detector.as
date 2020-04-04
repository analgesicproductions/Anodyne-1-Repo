package entity.gadget 
{
	import flash.geom.Point;
	import global.Registry;
	import org.flixel.AnoSprite;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	
	
	
	public class Go_Detector extends AnoSprite 
	{
	
		private var map:FlxTilemap;
		public var door:FlxSprite;
		
		private const RED_ID:int = 60;
		private const GREEN_ID:int = 62;
		private const YELLOW_ID:int = 63;
		private const BLUE_ID:int = 61;
		
		private var RED_PT:Point = new Point(0 + 2, 4 + 2);
		private var BLUE_PT:Point = new Point(5 + 2, 3 + 2);
		private var GREEN_PT:Point = new Point(4 + 2, 1 + 2);
		private var YELLOW_PT:Point = new Point(1 + 2, 1 + 2);
		
		private const s_closed:int = 0;
		private const s_opening:int = 1;
		private const s_open:int = 2;
		
		public function Go_Detector(args:Array)
		{
			super(args);
			
			makeGraphic(4, 4, 0xff151515);
			
			door = new FlxSprite(0, 0);
			door.makeGraphic(16, 16, 0xffff0000);
			
			xml.@p = "2";
			
			
			if (xml.@alive == "false") {
				state = s_open;
				door.color = 0x00ff00;
			} else {
				state = s_closed;
				
			}

			if (Registry.CURRENT_GRID_X == 0 && Registry.CURRENT_GRID_Y == 4) {
				RED_PT.x = 2 + 1; RED_PT.y =  2 + 3;
				BLUE_PT.x = 2 + 4; BLUE_PT.y = 2 + 1;
				GREEN_PT.x = 2 + 4; GREEN_PT.y = 2 + 3;
				YELLOW_PT.x = 2 + 3; YELLOW_PT.y = 2 + 0;
			}
			visible = door.visible = false;
			
		}
		
		override public function update():void 
		{
			if (Registry.GE_States[Registry.GE_Briar_Blue_Done]) {
				Registry.GRID_PUZZLES_DONE = 1;
			}
			if (!did_init) {
				did_init = true;
				map = parent.curMapBuf;
				parent.sortables.add(door);
				door.x = tl.x + 50;
				door.y = tl.y + 16;
			}
			
			if (state == s_closed) {
				var r:int = map.getTile(RED_PT.x, RED_PT.y);
				var g:int = map.getTile(GREEN_PT.x, GREEN_PT.y);
				var b:int = map.getTile(BLUE_PT.x, BLUE_PT.y);
				var y:int = map.getTile(YELLOW_PT.x, YELLOW_PT.y);
				
				
				if (r == RED_ID && y == YELLOW_ID && g == GREEN_ID && b == BLUE_ID) {
					xml.@alive = "false";
					state = s_opening;
					Registry.sound_data.open.play();
					
				}
			} else if (state == s_opening) {
				door.alpha -= 0.07;
				if (door.alpha == 0) {
					state = s_open;
					Registry.GRID_PUZZLES_DONE += 1;
					door.color = 0x00ff00;
				}
			} else if (state == s_open) {
			
			}
			
			
			
			super.update();
		}
		
		override public function destroy():void 
		{
			RED_PT = BLUE_PT = GREEN_PT = YELLOW_PT = null;
			parent.sortables.remove(door, true);
			door.destroy();
			door = null;
			
			super.destroy();
		}
	}

}
package entity.player 
{
	import data.CSV_Data;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import global.Registry;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	import states.MinimapState;
	
	public class Miniminimap extends FlxSprite 
	{
		
		[Embed(source = "../../res/tilemaps/mini_minimap_tiles.png")] public static const embed_miniminimap_tiles:Class;
		
		// Used for calculating room bounds
		private var width_in_rooms:int;
		private var height_in_rooms:int; 
		private var buffer:FlxSprite;
		private var minimap:FlxTilemap;
		
		private const RED_IDX:int = 9;
		private var bm:FlxSprite;
		private var t:FlxTilemap;
		
		public function Miniminimap()
		{
			makeGraphic(25, 20, 0x00000000);
			//visible = false;
			scrollFactor.x = scrollFactor.y = 0;
			x = 55;
			y = 0;
			bm = new FlxSprite(0, 0, embed_miniminimap_tiles);
			t = new FlxTilemap();
		}
		
		/**
		 * 
		 * @param	x_next
		 * @param	y_next
		 */
		public function switch_rooms(x_next:int, y_next:int):void {
			if (visible == false) return;
			// Find next room, get type, update map buffer
			dirty = true;
			
			// Max coords of minimap
			var mx:int = minimap.widthInTiles - 1;
			var my:int = minimap.heightInTiles - 1;
			
			// Try to find a 5x4 rectangle of things to show with the marker at (2,1). If not then offset it.
			
			//We're good
			if (y_next >= 1 && (my - y_next >= 2) && x_next >= 2 && (mx - x_next) >= 2) {
				update_graphics_routine(x_next - 2, y_next - 1, 7);
			// Otherwise change the rectangle a bit
			} else {
				var cx:int;
				var cy:int;
				if (x_next < 2) {
					cx = 2 - x_next;
				} else if ((mx - x_next) < 2) {
					cx = -2 + (mx - x_next);
				}
				
				if (y_next < 1) {
					cy = 1;
				} else if ((my - y_next) < 2) {
					cy = -2 + (my - y_next);
				}
				update_graphics_routine(x_next - 2 + cx, y_next - 1 + cy,7 + (-cy * 5) - cx	);
				// Edge cases fuuuuuuuuck
			}
		}
		
		private function update_graphics_routine(_x:int, _y:int, red_idx: int):void {
			var w:int = minimap.widthInTiles;
			var h:int = minimap.heightInTiles;
			var source_rect:Rectangle = new Rectangle(0, 0, 5, 5);
			var dest_point:Point = new Point(0, 0);
			
 			var visited:Array = MinimapState.visited[Registry.CURRENT_MAP_NAME];
			visited[w * Registry.CURRENT_GRID_Y + Registry.CURRENT_GRID_X] = 1;
			var data:Array = t.getData();
			
			var t_idx:int; // tile idex
			var tt:int; //tile type
			for (var i:int = 0; i < 20; i++) {
				
				t_idx = w * (_y + int (i / 5)) + (_x + (i % 5));
				tt = data[t_idx];
				if (visited[t_idx] == 0) {
					tt = 0; // Make it blank
				}
				
				dest_point.x = 5 * (i % 5);
				dest_point.y =  5 * int (i / 5);
				// Miniminimap tileset is 20x25 pixels. Indexed by same values as the other minimap
				source_rect.x = (tt % 4) * 5;
				source_rect.y = int(tt / 4) * 5;
				pixels.copyPixels(bm.pixels, source_rect, dest_point);
			}
			
			source_rect.x = 5 + 1;
			source_rect.y = 10 + 1
			source_rect.width = 3;
			source_rect.height = 3;
			dest_point.x = (red_idx % 5) * 5 + 1;
			dest_point.y = int(red_idx / 5) * 5 + 1;
			pixels.copyPixels(bm.pixels, source_rect, dest_point);
			draw();
		}
		/**
		 * Switch to the next map, either make visible or not. Call AFTER updatin' minimap
		 * Set bounds of map.
		 * @param	next_map
		 */
		public function switch_map():void {
			
			
			var mms:MinimapState = Registry.GAMESTATE.pause_state.minimap;
			var _minimap:FlxTilemap = mms.get_minimap();
			
			if (_minimap == null) {
				visible = false;
				return;
			}
			
			visible = true;
			var s:String = new CSV_Data.minimap_csv[Registry.CURRENT_MAP_NAME];
			t = new FlxTilemap();
			t.loadMap(s, embed_miniminimap_tiles, 5, 5);
			minimap = _minimap;
		}
	}

}
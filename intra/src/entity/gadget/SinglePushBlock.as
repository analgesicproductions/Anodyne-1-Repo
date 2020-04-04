package entity.gadget 
{
	import data.CLASS_ID;
	import entity.player.Player;
    import flash.geom.Point;
    import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	import global.Registry;
	/**
	 *	Single push blocks...push em from one direction, they move a tile. yeah WHAT
	 * @author seagaia
	 */
	public class SinglePushBlock extends FlxSprite
	{
		private var dir:int;
		private var hasBeenPushed:Boolean = false;
		private var sound_played:Boolean = false;
		private var distanceToGo:int = Registry.TILE_HEIGHT;
		private var startedMoving:Boolean = false;
        public var type:String = "SinglePushBlock";
		public var xml:XML;
		public var sentinel:FlxSprite = new FlxSprite(0, 0);
        public var timeToPush:Number = 0.3;
        public var initial_coords:Point = new Point();
        public var MOVE_VEL:int = 24;
		public var INCREMENTED_REG:Boolean = false;
		public var BEDROOM_INDEX:int = 4;
		public var STREET_INDEX:int = 5;
		public var cid:int = CLASS_ID.SINGLEPUSHBLOCK;
		
		private var is_non_puzzle:Boolean = false;
		[Embed (source = "../../res/sprites/gadgets/pushyblocks.png")] public var C_PUSH_BLOCKS:Class;
		
		public var player:Player;
//frame mod 4 determines direction

		public function SinglePushBlock(_x:int, _y:int, _xml:XML, _p:Player) 
		{
			super(_x, _y);
            initial_coords.x = x;
            initial_coords.y = y;
			xml = _xml;
            switch (parseInt(xml.@frame) % 4) {
                case 0: dir = FlxObject.UP; break;
                case 1: dir = FlxObject.DOWN; break;
                case 2: dir = FlxObject.LEFT; break;
                case 3: dir = FlxObject.RIGHT; break;
            }
			
			loadGraphic(C_PUSH_BLOCKS,true, false, 16, 16);
			if (Registry.CURRENT_MAP_NAME == "BEDROOM") {
				trace("SET PUSH BLOCK FRAME: ", BEDROOM_INDEX);
				frame = BEDROOM_INDEX;
			} else if (Registry.CURRENT_MAP_NAME == "STREET") {
				frame = STREET_INDEX;
			}
			
			if (parseInt(xml.@type) == 1) {
				is_non_puzzle = true;
			}
			immovable = true;
			createSentinel();
			player = _p;
			
		}
		
		override public function update():void {
        
			
            if (FlxG.collide( player, this)) {
				if (player.overlaps(sentinel)) startMoving();
			}

			if (timeToPush < 0) {
				if (!sound_played) {
					hasBeenPushed = true;
					Registry.sound_data.push_block.play();
					sound_played = true;
				}
			switch (dir) {
				case FlxObject.UP:
					velocity.y = -MOVE_VEL;
					break;
				case FlxObject.DOWN:
                    velocity.y = MOVE_VEL;
					break;
				case FlxObject.RIGHT:
					velocity.x = MOVE_VEL;
					break;
				case FlxObject.LEFT:
					velocity.x = -MOVE_VEL;
					break;
                }
			}
            
            if (Math.abs(x - initial_coords.x) >= 16 || Math.abs(y - initial_coords.y) >= 16) {
				if (!INCREMENTED_REG) {
					if (!is_non_puzzle) {
						Registry.GRID_PUZZLES_DONE++;
					}
					INCREMENTED_REG = true;
				}
				if ((x - initial_coords.x) > 16) {
					x = initial_coords.x + 16;
				} else if ((x - initial_coords.x) < -16) {
					x = initial_coords.x - 16;
				}
				
				if ((y - initial_coords.y > 16)) {
					y = initial_coords.y + 16;
				} else if ((y - initial_coords.y) < -16) {
					y = initial_coords.y - 16;
				}
                velocity.x = velocity.y = 0;
            }
            
            if (!startedMoving) timeToPush = 0.3;
            startedMoving = false;
			super.update();
		}
		
		public function startMoving():void {
			if (hasBeenPushed) return;
            timeToPush -= FlxG.elapsed;
			startedMoving = true;
		}
		
		public function createSentinel():void {
			sentinel.makeGraphic(4, 2, 0xFF022000);
			sentinel.visible = false;
			switch (dir) {
				case FlxObject.DOWN:
					sentinel.x = x + Registry.TILE_WIDTH / 2 - 2; 
					sentinel.y = y - 2;
					break;     
                case FlxObject.UP:
                    sentinel.x = x + Registry.TILE_WIDTH / 2 - 2;
                    sentinel.y = y + Registry.TILE_WIDTH + 2;
                    break;
                case FlxObject.LEFT:
                    sentinel.x = x + Registry.TILE_WIDTH + 2;
                    sentinel.y = y + Registry.TILE_WIDTH / 2;
                    break;
                case FlxObject.RIGHT:
                    sentinel.x = x  - 2;
                    sentinel.y = y + Registry.TILE_WIDTH / 2;
			}
		}
		
	}

}
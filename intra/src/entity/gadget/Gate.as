package entity.gadget 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import flash.geom.Point;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import data.SoundData;
	
	import global.Registry;
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Gate extends FlxSprite
	{
		
		public var xml:XML;
		public var type:String = "Gate";
		
		/* These stay open forever once opened */
		public static var ENEMY_1:int = 0;
		public static var ENEMY_2:int = 1;
		public static var ENEMY_3:int = 2;
		public static var ENEMY_4:int = 3;
		public static var PUZZLE_1:int = 5;
		public static var PUZZLE_2:int = 6;
		public static var PUZZLE_3:int = 7;
		/* These stay open ONLY WHEN THEIR CONDITIONS ARE MET. */
		public static var TEMP_ENEMY_1:int = 10;
		public static var TEMP_ENEMY_2:int = 11;
		public static var TEMP_ENEMY_3:int = 12;
		
		public static var TEMP_PUZZLE_1:int = 15;
		public static var TEMP_PUZZLE_2:int = 16;
		public static var TEMP_PUZZLE_3:int = 17;
		
		// Set to 10 as a theoretical limit
		public var REQUIRED_ENEMIES:int = 10;
		public var REQUIRED_PUZZLES:int = 10;
		public var is_temporary:Boolean = false;  //DOes this close when its conditions arent met
		public var CLOSED_FRAME:int;
		public var behavior_type:int;
		public var player:Player;
		
		public var cid:int = CLASS_ID.GATE;
		
		public var grid_coords:Point = new Point;
		
		private var player_hasnt_stepped_off:Boolean = false;
		/**
		 * A gate - basically blocks a room except for some condition.
		 * Conditions include: enemy deaths, or some puzzle events...
		 * "ALIVE": 
		 * @param	_x
		 * @param	_y
		 */
		 
		[Embed (source = "../../res/sprites/gadgets/gates.png")] public var C_GATE_SPRITES:Class;
		
		
		public function Gate(_x:int, _y:int, _xml:XML,_player:Player) {
			xml = _xml;
			type = xml.name();
			super(_x, _y);
			player = _player;
			grid_coords.x = Registry.CURRENT_GRID_X;
			grid_coords.y = Registry.CURRENT_GRID_Y;
			immovable = true;
			loadGraphic(C_GATE_SPRITES, true, false, 16, 16);
			/* set anims */
			/*if (Registry.CURRENT_MAP_NAME == "BEDROOM") {
				CLOSED_FRAME = frame = 0;
				addAnimation("still", [0]);
				addAnimation("rise", [0, 1, 2, 3],10,false);
				addAnimation("close", [3,2,1,0],10,false);
			} else if (Registry.CURRENT_MAP_NAME == "STRE1ET") { //TODO change
				CLOSED_FRAME = frame = 4;
				addAnimation("still", [4]);
				addAnimation("rise", [4, 5, 6, 7], 4, false);
				addAnimation("close", [7,6,5,4], 4, false);*/
			if (Registry.CURRENT_MAP_NAME == "BLANK") {
				CLOSED_FRAME = frame = 8;
				addAnimation("still", [8]);
				addAnimation("rise", [8,9,10,11], 8, false);
				addAnimation("close", [11, 10, 9, 8], 4, false);
			} else if (Registry.CURRENT_MAP_NAME == "TRAIN") {
				CLOSED_FRAME = frame = 16;
				addAnimation("still", [16]);
				addAnimation("close", [19,18,17,16], 8, false);
				addAnimation("rise", [16,17,18,19], 4, false);
			} else {
				CLOSED_FRAME = frame = 0;
				addAnimation("still", [0]);
				addAnimation("rise", [0, 1, 2, 3],10,false);
				addAnimation("close", [3,2,1,0],10,false);
			}
			behavior_type = xml.@frame;
			/* if temporary we always revive this gate */
			
			/* set conditions to open */
			switch (behavior_type) {
				case ENEMY_1:
					REQUIRED_ENEMIES = 1; break;
				case ENEMY_2:
					REQUIRED_ENEMIES = 2; break;
				case ENEMY_3:
					REQUIRED_ENEMIES = 3; break;
				case ENEMY_4:
					REQUIRED_ENEMIES = 4; break;
				case PUZZLE_1: 
					REQUIRED_PUZZLES = 1; break;
				case PUZZLE_2:
					REQUIRED_PUZZLES = 2; break;
				case PUZZLE_3:
					REQUIRED_PUZZLES = 3; break;
				case TEMP_PUZZLE_1:
					REQUIRED_PUZZLES = 1;
					is_temporary = true; break;
				case TEMP_PUZZLE_2:
					REQUIRED_PUZZLES = 2;
					is_temporary = true; break;
				case TEMP_PUZZLE_3:
					REQUIRED_PUZZLES = 3;
					is_temporary = true; break;	
				case TEMP_ENEMY_1:
					REQUIRED_ENEMIES = 1;
					is_temporary = true; break;
				case TEMP_ENEMY_2:
					REQUIRED_ENEMIES = 2;
					is_temporary = true; break;
				case TEMP_ENEMY_3:
					REQUIRED_ENEMIES = 3;
					is_temporary = true; break;
			}
			/* Temp gates are always closed until told otherwise. */
			if (is_temporary) { 
				xml.@alive = "true";
			}
			
			/* If already opened (permanently), open up when entering ar oom*/
			if (xml.@alive == "false") {
				exists = false;
				//Registry.sound_data.open.play();
			} else {
				if (player.overlaps(this)) {
					player_hasnt_stepped_off = true;
					frame = CLOSED_FRAME + 3;
				}
			}
			/* set rotation */
/*			if (x % 160 < 10) {
				angle = -90;
			} else if (x % 160 > 140) {
				angle = 90;
			}*/
			
			//HACKS
			if (Registry.CURRENT_MAP_NAME == "CROWD" && Registry.CURRENT_GRID_X == 0 && Registry.CURRENT_GRID_Y == 4 && REQUIRED_PUZZLES == 3) {
				REQUIRED_PUZZLES = 2;
			}
			Registry.subgroup_gates.push(this);
		}
		
		/**
		 * TODO: Enemies that are perma-dead, as well as perma-solved 
		 * puzzles should count in the GRID_..._... counter.
		 * 
		 * possible source of bugs - dead enemies not auto-incrementing the counter. 
		 * I checked over this on 7/23, though., seems okay
		 */
		 
		override public function update():void {
			
			if (player_hasnt_stepped_off) {
				if (!player.overlaps(this)) {
					play("close");
					Registry.sound_data.hitground1.play();
					player_hasnt_stepped_off = false;
				}
			}
			if (Registry.CURRENT_GRID_X != grid_coords.x || Registry.CURRENT_GRID_Y != grid_coords.y) {
				return;
			}
			
			FlxG.collide(this, player);
			/* If ever alive and not closed, then close */
			if (frame != CLOSED_FRAME) {
				//close it if we're not touching
				if (xml.@alive == "true" && !player.overlaps(this)) {
					play("close");
					Registry.sound_data.hitground1.play();
					solid  = true;
				} 
			}
			if (Registry.GRID_ENEMIES_DEAD >= REQUIRED_ENEMIES) {
				xml.@alive = "false";
			} else if (Registry.GRID_PUZZLES_DONE >= REQUIRED_PUZZLES) {
				xml.@alive = "false";
			} else if (is_temporary) {
				xml.@alive = "true";
			}
			
			if (frame == CLOSED_FRAME && xml.@alive == "false") {		
					Registry.sound_data.open.play();
					play("rise");
					solid = false;
			}
			super.update();
		}
	}

}
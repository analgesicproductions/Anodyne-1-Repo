package entity.player 
{
	import global.Registry;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import states.PlayState;
	
	/**
	 * sanity class for the foot overlay
	 * @author Seagaia
	 */
	public class Foot_Overlay extends FlxSprite 
	{
		[Embed (source = "../../res/sprites/decoration/player_overlay_foot_test.png")] public static var foot_test:Class;
		[Embed (source = "../../res/sprites/decoration/overlay_APARTMENT_water.png")] public static var APARTMENT_water:Class;
		[Embed (source = "../../res/sprites/decoration/overlay_REDCAVE_water.png")] public static var REDCAVE_water:Class;
		[Embed (source = "../../res/sprites/decoration/overlay_REDSEA.png")] public static var REDSEA_water:Class;
		[Embed (source = "../../res/sprites/decoration/overlay_WINDMILL_water.png")] public static var WINDMILL_water:Class;
		[Embed (source = "../../res/sprites/decoration/overlay_FIELDS_grass.png")] public static var FIELDS_grass:Class;
		[Embed (source = "../../res/sprites/decoration/overlay_water.png")] public static var general_water:Class;
		
		private var debug_tiles:Array = new Array(2, -1);
		private var fields_tiles:Array = new Array(200,201,250,270,271,272,273, -1);
		private var apartment_tiles:Array = new Array(206, 231, -1);
		private var redcave_tiles:Array = new Array(16, 17, 18, 19, 28, -1);
		private var redsea_tiles:Array = new Array(61, 71, -1);
		private var circus_tiles:Array = new Array(110, 111, 112, 113, 114, -1);
		private var windmill_tiles:Array = new Array(130, -1);
		private var working_maps:Array = new Array("DEBUG", "FOREST", "TERMINAL", "GO", "FIELDS", "APARTMENT", "REDCAVE", "CIRCUS", "HOTEL", "WINDMILL","BEACH", "REDSEA");
		
		
		private var player:Player
		private var cur_player_state:int;
		private var cur_player_anim_state:int;
		private var cur_tile:int = -1;
		
		public var map:FlxTilemap;
		private var map_name:String;
		
		
		private var X_OFF:int = -4;
		private var Y_OFF:int = 0;
		private var W:int = 24;
		private var H:int = 24;
		private var player_midpoint:FlxPoint = new FlxPoint();
		
		
		public function Foot_Overlay(_player:Player) 
		{
			super();
			
			player = _player;
			player_midpoint = player.getMidpoint(player_midpoint);
			
			if (working_maps.indexOf(Registry.CURRENT_MAP_NAME) == -1) {
				exists = false;
			}
			
			loadGraphic(foot_test, true, false, W, H);
			addAnimation("foot_test", [0, 1], 12);
			
			//200  - yello, 201 - green
			addAnimation("FIELDS_yellow_stop", [3],20);
			addAnimation("FIELDS_yellow_go", [2, 3], 8);
			addAnimation("FIELDS_green_stop", [5],20);
			addAnimation("FIELDS_green_go", [4, 5], 8);
			
			addAnimation("REDCAVE_water", [0],1);
			
			addAnimation("APARTMENT_water", [0], 5);
			
			addAnimation("WINDMILL_water", [0, 1], 5);
			
			addAnimation("general_water", [0], 5);
			
			visible = false;
			map_name = Registry.CURRENT_MAP_NAME;
		}
		
		// When we change a map we need to reset some data 
		// so that things don't break.
		public function reset_anodyne():void {
			map_name = Registry.CURRENT_MAP_NAME;
			if (working_maps.indexOf(Registry.CURRENT_MAP_NAME) == -1) {
				exists = false;	
			} else {
				exists = true;
			}
		}
		override public function update():void 
		{

			player_midpoint = player.getMidpoint(player_midpoint);
			
			var tile_type:int = map.getTile(player_midpoint.x/16, (player_midpoint.y - Registry.HEADER_HEIGHT)/16);
			if (tile_type != cur_tile) {
				cur_tile = tile_type;
				change_anim();
			}
			
			// Player state takes precedence over tile type
			if (player.state != cur_player_state) {
				cur_player_state = player.state;
				change_anim();
			}
			
			if (player.ANIM_STATE != cur_player_anim_state) {
				cur_player_anim_state = player.ANIM_STATE;
				change_anim();
			}
			
			if (player.facing == LEFT) {
				x = player.x - player.offset.x + X_OFF + 1;
			} else if (player.facing == RIGHT) {
				x = player.x - player.offset.x + X_OFF - 1;
				
			} else {
				x = player.x  - player.offset.x + X_OFF; //SUBTrACTION DOESNTO COMMUTe
				y = player.y - player.offset.y + Y_OFF ;
			}
			
			super.update();
		}
		
		private function change_anim():void {
			flicker(0); // Stop infinite flickering	
			visible = false;
			
			Y_OFF = 0;
			
			if (map_name == "DEBUG") {
				if (cur_player_state == player.S_GROUND) {
					if (debug_tiles.indexOf(cur_tile) != -1) {
						if (cur_tile == 2) {
							visible = true;
							loadGraphic(foot_test, true, false, W, H);
							play("foot_test");
						}
					}
				} 
			} else if (map_name == "FIELDS") {
				if (cur_player_state == player.S_GROUND) {
					if (fields_tiles.indexOf(cur_tile) != -1) {
						if (cur_tile == 201) {
							Y_OFF = -1;
							loadGraphic(FIELDS_grass, true, false, W, H);
							if (player.velocity.x == 0 && player.velocity.y == 0) {
								visible = true;
								play("FIELDS_green_stop");
							} else {						
								visible = true;
								play("FIELDS_green_go");
							}
						} else if (cur_tile == 200) {
							loadGraphic(FIELDS_grass, true, false, W, H);
							if (player.velocity.x == 0 && player.velocity.y == 0) {
								//visible = true;
								play("FIELDS_yellow_stop");
							} else {						
								//visible = true;
								play("FIELDS_yellow_go");
							}
						} else { // It's a water tile
							visible = true;
							loadGraphic(WINDMILL_water, true, false, W, H);
							play("WINDMILL_water");
							flicker( -1);
							
						}
					}
				} 
			} else if (map_name == "APARTMENT") {
				if (cur_player_state == player.S_GROUND) {
					if (apartment_tiles.indexOf(cur_tile) != -1) {
					if (cur_tile == 231 || cur_tile == 206) {
							visible = true;
							loadGraphic(APARTMENT_water, true, false, W, H);
							play("APARTMENT_water");
							flicker( -1);
						}
					}
				} 
			} else if (map_name == "REDCAVE") {
				if (cur_player_state == player.S_GROUND) {
					if (redcave_tiles.indexOf(cur_tile) != -1) {
					if (cur_tile == 16 || cur_tile == 17 || cur_tile == 18 || cur_tile == 19 || cur_tile == 28) {
							visible = true;
							loadGraphic(REDCAVE_water, true, false, W, H);
							play("REDCAVE_water");
							flicker( -1);
						}
					}
				}
			} else if (map_name == "REDSEA") {
				if (cur_player_state == player.S_GROUND) {
					if (redsea_tiles.indexOf(cur_tile) != -1) {
					if (cur_tile == 61 || cur_tile == 71) {
							visible = true;
							loadGraphic(REDSEA_water, true, false, W, H);
							play("WINDMILL_water");
							flicker( -1);
						}
					}
				}
			} else if (map_name == "WINDMILL") {
				if (cur_player_state == player.S_GROUND) {
					if (windmill_tiles.indexOf(cur_tile) != -1) {
					if (cur_tile == 130) {
							visible = true;
							loadGraphic(WINDMILL_water, true, false, W, H);
							play("WINDMILL_water");
							//flicker( -1);
						}
					}
				}
			} else if (map_name == "CIRCUS") {
				if (cur_player_state == player.S_GROUND) {
					if (circus_tiles.indexOf(cur_tile) != -1) {
						if (cur_tile == 110 || cur_tile == 111 || cur_tile == 112 || cur_tile == 113 || cur_tile == 114) {
							visible = true;
							loadGraphic(general_water, true, false, W, H);
							play("general_water");
							flicker( -1);
						}
					}
				}
			} else if (map_name == "BEACH") {
				if (cur_player_state == player.S_GROUND) {
					if ((cur_tile >= 140 && cur_tile <= 146) || cur_tile >= 250) {
						visible = true;
						loadGraphic(WINDMILL_water, true, false, W, H);
						play("WINDMILL_water");
						flicker( -1);
					}
				}
			} else if (map_name == "FOREST") {
				if (cur_player_state == player.S_GROUND) {
					if (cur_tile == 110 || (cur_tile >= 134 && cur_tile <= 137)) {
						visible = true;
						loadGraphic(general_water, true, false, W, H);
						play("general_water");
						flicker( -1);
					}
				}
			} else if (map_name == "TERMINAL") {
				if (cur_player_state == player.S_GROUND) {
					if (cur_tile == 150 || cur_tile == 151) {
						visible = true;
						loadGraphic(WINDMILL_water, true, false, W, H);
						play("WINDMILL_water");
						flicker( -1);
					}
				}
			} else if (map_name == "GO") {
				if (cur_player_state == player.S_GROUND) {
					if (cur_tile >= 50 && cur_tile <= 53) {
						visible = true;
						loadGraphic(WINDMILL_water, true, false, W, H);
						play("WINDMILL_water");
						flicker( -1);
					}
				}
			}
		}
	}

}
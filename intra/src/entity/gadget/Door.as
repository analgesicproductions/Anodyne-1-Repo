package entity.gadget 
{
	import data.CLASS_ID;
	import entity.interactive.Fisherman;
	import entity.player.HealthBar;
	import entity.player.Player;
	import helper.Cutscene;
	import helper.DH;
	import helper.EventScripts;
	import helper.Parabola_Thing;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
    import org.flixel.FlxSprite;
	import states.PauseState;
    import states.PlayState;
    import global.Registry;
    // Door class - based on "type" input, load
    /* the right sprite, whether it's visible, etc,,,whatever the need arises */
    public class Door extends FlxSprite
    
	
    {
	
	public static const INVISIBLE_TYPE:int = 1;
	public static const NORMAL_TYPE:int = 2;
	public static const THIN_INVISIBLE_TYPE:int = 3;
	public static const BLANK_PORTAL_UP_TYPE:int = 4;
	public static const INVISIBLE_TYPE_UP:int = 5;
	public static const NO_ENTRANCE_INVIS:int = 6;
	public static const WHIRLPOOL:int = 7;
	public static const FALL_DOOR:int = 8;
	public static const NO_MOVE_DOOR:int = 9;
	public static const RIGHT_DOOR:int = 11; 
	public static const LEFT_DOOR:int = 10;
	public static const WIDE_5_DOOR_D:int = 12; 
	public static const TALL_5_DOOR_L:int = 13;
	public static const WIDE_5_DOOR_U:int = 14; 
	public static const TALL_5_DOOR_R:int = 15;
	public static const NEXUS_PAD:int = 16;
	
	/* descriptive constants that essentially act like shitty keys
	 * for the state of certain doors in the game. */
	private static const Door_Red_Cave_Left:int = 5;
	private static const Door_Red_Cave_Right:int = 7;
	private static const Door_Red_Cave_North:int = 8;
	
	private static const Door_CrowdBossFilm:int = 14;
	
	/* Nexus door constants */
    private static const Door_Nexus2Blank:int = 4;
    public static const Door_Nexus2Street:int = 13;
	
    public static const Door_Nexus_Cell:int = 45;
    public static const Door_Nexus_Suburb:int = 46;
    public static const Door_Nexus_Space:int = 47;
    public static const Door_Nexus_Fields:int = 48;
    public static const Door_Nexus_Overworld:int = 49;
    public static const Door_Nexus_Forest:int = 50;
    public static const Door_Nexus_Terminal:int = 51;
    public static const Door_Nexus_Go:int = 52;
    public static const Door_Nexus_Redsea:int = 53;
    public static const Door_Nexus_Cliff:int = 54;
    public static const Door_Nexus_Beach:int = 55;
    public static const Door_Nexus_Blue:int = 56;
    public static const Door_Nexus_Happy:int = 57;
    public static const Door_Nexus_Circus:int = 58;
    public static const Door_Nexus_Hotel:int = 59;
    public static const Door_Nexus_Apartment:int = 60;
    public static const Door_Nexus_Crowd:int = 61;
    public static const Door_Nexus_Redcave:int = 62;
    public static const Door_Nexus_Bedroom:int = 63;
    public static const Door_Nexus_Windmill:int = 64;
	private static const Door_Go_Secret:int = 71;
	
	
	
	private static var Nexus_Door_Keys:Array = new Array(4, 13, 45, 46, 47, 48, 49, 50, 51, 52, 53,54,55,56,57,58,59,60,61,62,63,64);
	// Maps door keys -> indices in the preview spritesheet
	// E,g, if you addded the graphic for REDSEA, then you'd look up the key (53), and then add "53: x" to the object below,
	// where x is the first frame of the 4-frame animation in the spritesheet
	private static var Nexus_Graphic_Hash:Object = { 13: 0, 49: 4  , 62:8, 61:12, 60: 16, 59: 20, 58: 24, 54: 28, 50: 32, 64: 36, 53: 40, 55:44
	, 63: 48, 48:52,52:56,51:60,57:64,47:68,45:72,46:76,56:80};
	private static var Nexus_Key_Hash:Object = {  // For the states
		4: 0, 13: 1, 45: 2, 46: 3, 
		47: 4, 48: 5, 49: 6, 50: 7, 
		51: 8, 52: 9, 53: 10, 54: 11,
		55: 12, 56: 13, 57: 14, 58: 15,
		59: 16, 60: 17, 61: 18, 62: 19,
	63: 20, 64: 21 };
	private var nexus_jump_exit_d:Number = 0;
	
	
	//defaults to -1
	public static var Next_Door_Pair_ID:int = -1;
	
	/**
	 * Whether or not this door's sibling was used to enter the map.
	 * Used in determining which door is the "entrance" door, allowing the
	 * player to stand on it indefinitely until he moves off.
	 */
	private var is_entered_door:Boolean = false; 
	
        [Embed(source = "../../res/sprites/gadgets/doors.png")] public static var Door_Sprites:Class;
        [Embed(source = "../../res/sprites/decoration/whiteportal.png")] public static var White_Portal_Sprite:Class;
		[Embed(source = "../../res/sprites/decoration/whirlpool.png")] public static var Whirlpool_Door_Sprite:Class;
		[Embed(source = "../../res/sprites/gadgets/nexus_door.png")] public static var Sprite_nexus_door:Class;
		[Embed(source = "../../res/sprites/decoration/nexus_door_preview_overlay.png")] public static var Nexus_door_previews_embed:Class;
		[Embed(source = "../../res/sprites/decoration/nexus_door_preview_fade.png")] public static var Nexus_door_overlay_embed:Class;
		[Embed(source = "../../res/sprites/decoration/nexus_cardgem.png")] public static const embed_nexus_cardgem:Class;
        public var local_id:int;
        public var mapName:String;
        // Constants used to lookup values in the door lookup array
        public var XVAL:int = 0;
        public var YVAL:int = 1;
        public var MAPVAL:int = 2;
		public var xml:XML;
        public var index:int; // The key into the door lookup array
		public var inactive:Boolean = false; //whether or not this door 'works'
		public var type:int;
		public var parent:*; //playstate or roamstate
		
		public var nexus_gem:FlxSprite;
		public var preview:FlxSprite = new FlxSprite;
		public var preview_fade:FlxSprite = new FlxSprite;
		public var undim_region:FlxObject = new FlxObject;
		public var is_dimmed:Boolean = false;
		
		public var is_nexus_door:Boolean =  false;
		private var start_nexus_door_outro:Boolean = false;
		private var nexus_ctr:int = 0;
		
		public var cid:int = CLASS_ID.DOOR;
        public function Door(_x:int, _y:int,  _xml:XML, _parent:*)
        {
            super(_x, _y);
			
			parent = _parent;
			
            mapName = Registry.CURRENT_MAP_NAME;
            loadGraphic(Door_Sprites, false, false, 16, 16);
			
            immovable = true;
			type = parseInt(_xml.@type); // behavior
			
            index = parseInt(_xml.@frame); // wher eit is
			
			if (index == Next_Door_Pair_ID || Next_Door_Pair_ID == -1) {
				trace("is entered door! ", index);
				is_entered_door = true;
			}
			
			if (Registry.CURRENT_GRID_X == 2 && Registry.CURRENT_GRID_Y == 2 && Registry.CURRENT_MAP_NAME == "GO") {
				if (false == Registry.GE_States[Registry.GE_QUEST_SPACE]) {
					exists = false;
				} 
			}
			
			
			xml = _xml;
			
			makeGraphic(16, 16, 0x00ffffff);
			
			
			if (Registry.CURRENT_MAP_NAME == "NEXUS" && Nexus_Door_Keys.indexOf(index) != -1) {
				
				
				
				
            var doorPair:Array =  Registry.DOOR_INFO[index];
				
				loadGraphic(Sprite_nexus_door, true, false, 32, 32);
				visible = false;
				addAnimation("locked", [0, 1], 12);
				addAnimation("open", [2]);
				is_nexus_door = true;
				
				inactive = !is_active(index);
				
				if (inactive) {
					play("locked");
				} else {
					play("open");
				}
				
				
				// Load the door preview graphics. By default they are hiden, they will
				// pop iinto view if that nexus door is open
				load_nexus_preview_graphics(index);
				preview_fade.alpha = 0.5;
				if (inactive) {
					height = 32;
					preview.visible = preview_fade.visible = false;
				} else {
					
					preview.visible = preview_fade.visible = true;
				}
				is_nexus_door = true;
				parent.bg_sprites.add(preview);
				parent.bg_sprites.add(preview_fade);
				
				if (Registry.DOOR_INFO[index] == null || Registry.DOOR_INFO[index][0] == null || Registry.DOOR_INFO[index][1] == null)  {
					exists = false;
				} else {
					var check_name:String = Registry.DOOR_INFO[index][0][MAPVAL] == "NEXUS" ?  Registry.DOOR_INFO[index][1][MAPVAL] : Registry.DOOR_INFO[index][0][MAPVAL];
				}
				
				if (true == have_all_cards(check_name)) {
					nexus_gem = new FlxSprite(x, y + 2, embed_nexus_cardgem);
					parent.bg_sprites.add(nexus_gem);
					//trace(check_name, " has all cards.");
				} else {
					
					//trace(check_name, " not has all.");
				}
				
				undim_region = new FlxObject(x, y + 32, 32, 25);
				
			} else {
				if (!is_active(index)) {
					trace("Door ",index," inactive");
					inactive = true;
				} 
			}
			
			
			if (is_nexus_door) {
			} else if (type == Door.THIN_INVISIBLE_TYPE) {
				makeGraphic(16, 4, 0x00ffffff);
				visible = false;
				height = 4;
			} else if  (type == Door.BLANK_PORTAL_UP_TYPE) {
				loadGraphic(White_Portal_Sprite, true, false, 16, 16);
				width = height = 2;
				if (Registry.CURRENT_MAP_NAME == "TRAIN") {
					
				addAnimation("a", [4,5], 8, true);
				} else {
					
				addAnimation("a", [0, 1, 2], 10, true);
				}
				play("a");
				centerOffsets(true);
			} else if  (type == Door.INVISIBLE_TYPE_UP) {
				width = height = 8;
				centerOffsets(true);
			} else if (type == Door.NO_ENTRANCE_INVIS) {
				x = -65234; //lol
				y = -3422;
			} else if (type == Door.LEFT_DOOR) { // Generally these are on the left side of a map 
				width = 16;
				if (Registry.CURRENT_MAP_NAME == "WINDMILL") {
					width = 20; // BAD HAX MAN
				}
			} else if (type == Door.WHIRLPOOL) {
				loadGraphic(Whirlpool_Door_Sprite, true, false, 16, 16);
				addAnimation("whirl", [0, 1], 6, true);
				addAnimation("transition", [3, 4,4], 6, false);
				addAnimation("whirl_red", [4, 5], 6, true);
				if (Fisherman.fisherman_dead) {
					play("whirl_red");
				} else {
					play("whirl");
				}
			} else if (type == Door.WIDE_5_DOOR_D || type == Door.WIDE_5_DOOR_U) {
				width = 80;
				x -= 32;
				offset.x = -32;
			} else if (type == Door.TALL_5_DOOR_L || type == Door.TALL_5_DOOR_R) {
				height = 80;
				y -= 32;
				offset.y = -32;
			} else if (type == Door.NEXUS_PAD) {
				x = -60000;
				y = -60000;
			} else {
				trace("Otherwise...", index);
				width = height = 14;
				centerOffsets(true);
			}
			
        }
        
        override public function update():void {
			if (start_nexus_door_outro) {
				nexus_outro();
				super.update();
				return;
			}
			
			if (type == WHIRLPOOL) {
				if (Fisherman.fisherman_dead) {
					if (_curAnim.name == "whirl") {
						play("transition");
					}
					
					if (_curAnim.name == "transition" && _curFrame == _curAnim.frames.length - 1) {
						play("whirl_red");
					}
				}
			}
				
			/* Bugginess in FlxG.collide? When x values are aligned, 
			 * collide returns true even though they're separated by 48 pixels */
			if (!is_nexus_door && parent.player.touches(this)) { 
				if (!is_entered_door || (is_entered_door && !parent.player.hasnt_stepped_off_the_door_yet)) {
					if (doorCallback(this, parent.player)) {
						exists = false;
					}
				}
				// jesus christ look at that conditional
			} else if (is_nexus_door && !inactive ) {
				y += 3;
				if (parent.player.touches(this)) {
					parent.player.actions_disabled = true;
					if (parent.player.facing == UP && Registry.keywatch.JP_ACTION_1 && !start_nexus_door_outro) {
						start_nexus_door_outro = true;
					}
				}
				y -= 3;
			} else {
				y += 2;
				if (is_entered_door && parent.player.hasnt_stepped_off_the_door_yet) {
					parent.player.hasnt_stepped_off_the_door_yet = false;
				} else if (is_nexus_door && parent.player.touches(this)) {
					parent.player.actions_disabled = true;
					if (parent.player.facing == UP && Registry.keywatch.JP_ACTION_1) {
						parent.player.be_idle();
						//DH.dialogue_popup("The portal does not appear to be active.");
						DH.dialogue_popup(DH.lk("door", 0));
					}
				}
				y -= 2;
			}
			
			if (parent.SWITCH_MAPS) return;
			
			if (is_nexus_door) {
				if (!inactive) {
					if (is_dimmed) {
						if (undim_region.overlaps(parent.player)) {
							is_dimmed = false;
							preview.play("a");
						}
						EventScripts.send_property_to(preview_fade, "alpha", 0.5, 0.01);
					} else {
						if (!undim_region.overlaps(parent.player)) {
							is_dimmed = true;
							preview.play("stop");
						}
						EventScripts.send_property_to(preview_fade, "alpha", 0, 0.01);
					}
				} 
				
				if (Math.abs(x - parent.player.x) < 48 && Math.abs(y - parent.player.y) < 48) {
					if (parent.state == parent.S_NORMAL) {
						FlxG.collide(parent.player, this);	
					}
				}
			} else {
				if (inactive && is_active(index)) {
					inactive = false;
				}
			}
			super.update();
        }
		
		// There is nothing good about this entire class's code.
		// this function does nothing but reinforce that fact.
		private function nexus_outro():void {
			parent.player.actions_disabled = true;
			switch (nexus_ctr) {
				case 0:
					var p :Player = parent.player;
					p.solid = false;
					p.parabola_thing = new Parabola_Thing(parent.player, 16, 0.5, "offset", "y");
					p.my_shadow.visible = true;
					p.my_shadow.x = p.x + 2;
					p.my_shadow.y = p.y + 7;
					parent.bg_sprites.add(p.my_shadow);
					p.my_shadow.frame = 3;
					p.s_interact_shadow_visibility_override = true;
					p.state = p.S_INTERACT;
					Registry.sound_data.player_jump_up.play();
					nexus_ctr++;
					p.play("jump_u");
					break;
				case 1:
					parent.player.y -= 0.57;
					nexus_jump_exit_d += 0.57;
					if (nexus_jump_exit_d > 7) {
						parent.player.s_interact_shadow_visibility_override = false;
					}
					parent.player.my_shadow.x = parent.player.x + 2;
					parent.player.my_shadow.y = parent.player.y + 5;
					if (parent.player.parabola_thing.tick()) {
						parent.bg_sprites.remove(parent.player.my_shadow, true);
						parent.player.state = parent.player.S_GROUND;
						parent.player.velocity.y = 0;
						parent.player.my_shadow.visible = false;
						doorCallback(this, parent.player);
					}
			}
		}
		
        /* Lookup corresponding door and switch states, also revive sprites with permanence <= 1 */
        public function doorCallback(door:Door, player:Player):Boolean {
			if (door.inactive) return false;
			if (player.state != player.S_GROUND && player.state != player.S_LADDER) return false;
            door.getNextParams();
            return true;
        }
		/**
		 * If there is a door (a,mid) and (mid,b) then calling this function when
		 * you touch a or b will send you to respectively, b or a. Useful for skipping unfinished
		 * areas without mucking around with the level editor.
		 * @param	a
		 * @param	mid
		 * @param	b
		 * @param	a_id
		 * @param	b_id
		 */
        private function warp(a:String, mid:String, b:String, a_id:int, b_id:int):void {
			if (mapName == a && index == a_id) {
				index = b_id;
				Registry.CURRENT_MAP_NAME = mapName = mid;
				yeah_no = true;
			} else if (mapName == b && index == b_id) {
				index = a_id;
				Registry.CURRENT_MAP_NAME = mapName = mid;
				yeah_no = true;
			}
		}
		
		//used in conjunction with warp to do something god knows what
		private var yeah_no:Boolean = false;
        /* Sets the correct global values (map name, entrance x/y) based on the door. Then call switch state
         * whereever ye want */
        public function getNextParams():void {
			// Override door ehaviors for demo since DEEP areas arent finished
			// Door 3 (Fields-beach) and 34 (fields-windmill) are moved to forest for the time being.
			if (Intra.is_demo) {
				//warp("CLIFF", "SPACE", "HOTEL", 39, 25);
				//warp("REDCAVE", "TRAIN", "CIRCUS", 41, 31);
				//warp("OVERWORLD", "SUBURB", "APARTMENT", 37, 18);
				//warp("OVERWORLD", "FIELDS", "FOREST", 33, 35);
				
			} 
            var doorPair:Array =  Registry.DOOR_INFO[index];
			
			Next_Door_Pair_ID = index;
            var pairIndex:int;
			
			
			if (yeah_no) {
				if (doorPair[0][MAPVAL] == mapName) {
					pairIndex = 1;
				} else {
					pairIndex = 0;
				}
			} else {
				if (doorPair[0][XVAL] == (x - offset.x)  && doorPair[0][YVAL] == (y - offset.y) && doorPair[0][MAPVAL] == mapName) {
					pairIndex = 1;
				} else {
					pairIndex = 0;
				}
			}
			
			
			if (Intra.is_release) {
				if (Registry.CURRENT_MAP_NAME == "FIELDS" && (Registry.CURRENT_GRID_X < 5 || Registry.CURRENT_GRID_Y > 1)) {
					//if ((Registry.CURRENT_GRID_X != 1 || Registry.CURRENT_GRID_Y != 5) &&
					//(Registry.CURRENT_GRID_X != 10 || Registry.CURRENT_GRID_Y != 8)) {
						// 10 8 windmill
					parent.player.hasnt_stepped_off_the_door_yet = true;
					//DH.dialogue_popup("A voice: Sorry, but this area is as far as the demo goes! To proceed beyond, purchase the full version from www.anodynegame.com ! Thanks for playing!");
					DH.dialogue_popup("A voice: Sorry, but this area is blocked off in this demo! Buy the full version to explore more than these fields!");
					parent.player.be_idle();
					return;
					//}
				}
			}
			
            Registry.NEXT_MAP_NAME = doorPair[pairIndex][MAPVAL];
            Registry.ENTRANCE_PLAYER_X = doorPair[pairIndex][XVAL];
            Registry.ENTRANCE_PLAYER_Y = doorPair[pairIndex][YVAL];
		
			
			//Special case things when transitioning
			
			Registry.E_PLAY_ROOF = false;
			Registry.BOI = false;
			// If coming from SPACE -> Hotel, play the roof song
			if (Registry.NEXT_MAP_NAME == "HOTEL" && index == 25) {
				Registry.E_PLAY_ROOF = true;
				
			} else if (index == 26) {
				// Always change songs going between roof and hotel
				Registry.E_OVERRIDE_SAME_MAP_SONG = true;
				// Coming from inside to outside, play roof
				if (Registry.CURRENT_GRID_Y != 0) {
					Registry.E_PLAY_ROOF = true;
				} else {
				}
			} else if (index == 14) {
				if (!Registry.Event_Biofilm_Broken) {
					return;
				}
			// Don't allow you to enter GO secret hut till quest is over
			} else if (index == Door_Go_Secret && false == Registry.GE_States[Registry.GE_QUEST_SPACE]) {
				return;
			} else if (index == 73 || index == 75) { 
				// If we are entering a SUBURB house with no filter..
				Registry.E_OVERRIDE_SAME_MAP_SONG = true;
				if (Registry.CURRENT_GRID_Y < 4) {
					Registry.sound_data.trigger_soft = true;
					Registry.E_NEXT_MAP_NO_STATIC = true;
				}
			} else if (index == 74 || index == 76 || index == 78 || index == 77) {
				if (Registry.CURRENT_GRID_Y < 4) {
					Registry.E_NEXT_MAP_TURN_ON_LIGHT = true;
					Registry.E_NEXT_MAP_DARKNESS_8 = true;
				}
			} else if (index == 94 && Registry.CURRENT_MAP_NAME == "REDSEA") { // Entering BoI
				Registry.E_PLAY_ROOF = true;
				Registry.E_OVERRIDE_SAME_MAP_SONG = true;
				Registry.BOI = true;
			}
			
			
			trace("Getting next door...\ninput is (", x, ",", y, ",", Registry.CURRENT_MAP_NAME);
			trace("offsets; ", offset.x, offset.y);
            trace("New : ", Registry.ENTRANCE_PLAYER_X, Registry.ENTRANCE_PLAYER_Y, Registry.NEXT_MAP_NAME);
			//trace(Registry.ENTRANCE_PLAYER_Y % Registry.SCREEN_HEIGHT_IN_PIXELS);
			/* Use the just-stepped-on-door's type to determine where the player enters
			 * the next map in reference to the next door. */
			var door_type:int = parseInt(xml.@type);
			var curmap:String = Registry.CURRENT_MAP_NAME;
			var next_y:int = Registry.ENTRANCE_PLAYER_Y;
			var next_x:int = Registry.ENTRANCE_PLAYER_X;
			
			var going_to_nexus:Boolean = false;
			if (Registry.CURRENT_MAP_NAME != "NEXUS" &&  Registry.CURRENT_MAP_NAME != "BLANK" && Nexus_Door_Keys.indexOf(index) != -1) {
				going_to_nexus = true;
				Registry.sound_data.teleport_up.play();
			} else if (is_nexus_door) {
				Registry.sound_data.teleport_up.play();
			}
			
			// Based on this input door, determine which way
			// hthe player should face in the next map
			// and where it should be positioned wrt next map's door.
			if (going_to_nexus) {
				next_y += 35;
				next_x += 10;
				Registry.sound_data.enter_door.play();
			} else if (door_type == INVISIBLE_TYPE_UP || door_type == WIDE_5_DOOR_U) { 
				next_y = doorPair[pairIndex][YVAL] - 20; 
				Registry.GAMESTATE.player.TRANSITION_IDLE = "idle_u";
				Registry.GAMESTATE.player.facing = UP;
				Registry.sound_data.enter_door.play();
			}	else if (door_type == INVISIBLE_TYPE || door_type == WIDE_5_DOOR_D) {  
				trace("Door type: Invisible Down");
				next_y += 16;
				Registry.GAMESTATE.player.TRANSITION_IDLE = "idle_d";
				Registry.GAMESTATE.player.facing = DOWN;
				Registry.sound_data.enter_door.play();
			}	else if (door_type == BLANK_PORTAL_UP_TYPE) {
				Registry.sound_data.teleport_up.play();
				Registry.EVENT_TELEPORT_DOWN_SOUND = true;
				if (Registry.CURRENT_MAP_NAME == "TRAIN") {
					next_y -= 12;
				}
				
			} else if (door_type == WHIRLPOOL) {
				
				Registry.E_Enter_Whirlpool_Down = true;
				if (curmap == "REDSEA") {
					next_y -= 36;
				}
			} else if (door_type == FALL_DOOR) {
				Registry.E_Enter_Fall_Down = true;
			} else if (door_type == NO_MOVE_DOOR) {
				if (is_nexus_door) {
					next_x += 10;
					next_y += 8;
				}
				Registry.sound_data.enter_door.play();
			} else if (door_type == RIGHT_DOOR || door_type == TALL_5_DOOR_R) {
				next_x += 17;
				Registry.sound_data.enter_door.play();
				Registry.GAMESTATE.player.TRANSITION_IDLE = "idle_r";
				Registry.GAMESTATE.player.facing = RIGHT;
			} else if (door_type == LEFT_DOOR || door_type == TALL_5_DOOR_L) {
				next_x -= 16;
				Registry.sound_data.enter_door.play();
				Registry.GAMESTATE.player.TRANSITION_IDLE = "idle_l";
				Registry.GAMESTATE.player.facing = LEFT;
			} else {
				Registry.sound_data.enter_door.play();
				next_y += 20; 
			}
			Registry.ENTRANCE_PLAYER_Y = next_y;
			Registry.ENTRANCE_PLAYER_X = next_x;
			
            parent.SWITCH_MAPS = true;
        }
        
		private function change_stats(amount:int,give_jump:Boolean):void {
			amount = amount > 16 ? 16 : amount;
			if (Registry.MAX_HEALTH < amount) {
				parent.header_group.remove(parent.player.health_bar, true);
				parent.player.health_bar = new HealthBar(155, 2, amount);
				parent.header_group.add(parent.player.health_bar);
			}
			
			if (give_jump) {
				Registry.bound_item_2 = "JUMP";
				Registry.inventory[Registry.IDX_JUMP] = true;
			} else {
				Registry.bound_item_2 = "";
				Registry.inventory[Registry.IDX_JUMP ] = false;
			}
		}
		/* Based on global game state,
		 * check if this door is active based on its dame index*/
		public function is_active(_index:int):Boolean {
			switch (_index) {
				case Door_Red_Cave_Left:
					if (Registry.CUTSCENES_PLAYED[Cutscene.Red_Cave_Left] == 0) return false;
					break;
				case Door_Red_Cave_Right:
					if (Registry.CUTSCENES_PLAYED[Cutscene.Red_Cave_Right] == 0) return false;
					break;
				case Door_Red_Cave_North:
					if (Registry.CUTSCENES_PLAYED[Cutscene.Red_Cave_North] == 0) return false;
					break;
			
				/* For all of the NEXUS doors, if we're entering the pair from a non-nexus map,
				 * then we flip the state to on. which makes the nexus door appear open (vs. closed) */
				case Door_Nexus2Blank:
					if (Registry.CURRENT_MAP_NAME == "NEXUS") {
						preview_fade.exists = preview.exists = false;
						exists = false;
					}
				case Door_CrowdBossFilm: 
					//if...event film broken, active is true
					return true;
					break;
					
					
			}
			
			if (Nexus_Door_Keys.indexOf(_index) != -1) {
				return is_nexus_door_open(Nexus_Key_Hash[_index]);
			}
			return true;
		}
		
		public static function is_nexus_door_open(door_index:int):Boolean 
		{
			// If the nexus door is not open
			if (!Registry.Nexus_Door_State[door_index]) {
				// And we're entering from the non-nexus side
				if (Registry.CURRENT_MAP_NAME != "NEXUS") {
					// Open the nexus side
					Registry.Nexus_Door_State[door_index] = true;
				} else {
					return false;
				}
			}
			return true;
		}
		
		public static function igf_unlock():void {
			Registry.Nexus_Door_State[Nexus_Key_Hash[Door_Nexus_Apartment]] = true;
			Registry.Nexus_Door_State[Nexus_Key_Hash[Door_Nexus_Redcave]] = true;
			Registry.Nexus_Door_State[Nexus_Key_Hash[Door_Nexus_Crowd]] = true;
			Registry.Nexus_Door_State[Nexus_Key_Hash[Door_Nexus_Circus]] = true;
			Registry.Nexus_Door_State[Nexus_Key_Hash[Door_Nexus_Hotel]] = true;
		}
		
		private function load_nexus_preview_graphics(key:int):void { 
			preview_fade.loadGraphic(Nexus_door_overlay_embed, true, false, 32, 32);
			preview_fade.alpha = 0;
			
			preview.loadGraphic(Nexus_door_previews_embed, true, false, 32, 32);
			if (Nexus_Graphic_Hash.hasOwnProperty(key)) {
				var i:int = Nexus_Graphic_Hash[key];
				preview.addAnimation("a", [i, i + 1, i + 2, i + 3], 10, true);
				preview.addAnimation("stop", [i], 1, true);
				preview.play("a");
			} else {
				preview.addAnimation("a", [0,1,2,3], 10, true);
				preview.addAnimation("stop", [0], 1, true);
				preview.play("a");
			}
			
			preview_fade.x = preview.x = x;
			preview_fade.y = preview.y = y;
		}
		
		private function have_all_cards(map:String):Boolean {
			
				if (map == "BLANK") return false;
			if (PauseState.card_data.hasOwnProperty(map) == false) {
				if (Registry.Nexus_Door_State[Nexus_Key_Hash[index]] == false) return false;
				return true;
			}
			
			var id:int = 0;
			for each (var o:Object in PauseState.card_data[map]) {
				id = o.id;
				if (id < 36 || id == 43) {
					if (Registry.card_states[id] == 0) {
						return false;
					}
				}
			}
			if (map == "STREET") return true;
			Registry.GE_States[Registry.GE_got_all_cards_inanarea] = true;
			return true;
		}
		
		override public function destroy():void 
		{
			if (preview != null) preview.destroy();
			preview = null;
			nexus_gem = null;
			
			if (preview_fade != null) preview_fade.destroy();
			preview_fade = null;
			super.destroy();
		}
	
        
    }

}
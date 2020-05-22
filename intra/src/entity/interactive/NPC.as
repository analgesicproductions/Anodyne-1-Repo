package entity.interactive 
{
	import data.CLASS_ID;
	import data.Common_Sprites;
	import entity.enemy.crowd.Dog;
	import entity.enemy.etc.Briar_Boss;
	import entity.enemy.hotel.Eye_Boss;
	import entity.enemy.suburb.Suburb_Walker;
	import entity.gadget.Door;
	import entity.interactive.npc.Forest_NPC;
	import entity.interactive.npc.Shadow_Briar;
	import entity.interactive.npc.Space_NPC;
	import entity.interactive.npc.Trade_NPC;
	import entity.player.Player;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.net.FileFilter;
	import global.Registry;
	import helper.Cutscene;
	import helper.DH;
	import helper.EventScripts;
	import helper.S_NPC;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import states.EndingState;
	import states.PlayState;
	import states.TitleState;
	
	/**
	 * ...
	 * @author Seagaia
	 */
	public class NPC extends FlxSprite 
	{
		
		public var xml:XML;
		public var parent:*;
		public var player:Player;
		public var active_region:*;
		public var get_dialogue:Function;
		public var cid:int = CLASS_ID.NPC_;
		[Embed (source = "../../res/sprites/npcs/npc.png")] public static var npc_spritesheet:Class;
		[Embed (source = "../../res/sprites/gadgets/biofilm.png")] public static var npc_biofilm:Class;
		[Embed (source = "../../res/sprites/npcs/sage_statue.png")] public static var sage_statue:Class;
		[Embed (source = "../../res/sprites/npcs/note_rock.png")] public static var note_rock:Class;
		[Embed (source = "../../res/sprites/npcs/cube_kings.png")] public static var embed_cube_kings:Class;
		[Embed (source = "../../res/sprites/gadgets/key_green.png")] public static var key_green_embed:Class;
		[Embed (source = "../../res/sprites/gadgets/key_sparkle.png")] public static var key_sparkle_embed:Class;
		[Embed(source = "../../res/sprites/gadgets/nexus_pad.png")] public static var embed_nexus_pad:Class;
		[Embed(source = "../../res/sprites/gadgets/windmill_shell.png")] public static var embed_windmill_shell:Class;
		[Embed(source = "../../res/sprites/gadgets/windmill_blade.png")] public static var embed_windmill_blade:Class;
		[Embed(source = "../../res/sprites/npcs/cell_bodies.png")] public static var embed_cell_bodies:Class;
		[Embed(source = "../../res/sprites/npcs/trade_npcs.png")]	 public static var embed_trade_npcs:Class;
		[Embed(source = "../../res/sprites/npcs/geoms.png")] public static var embed_geoms:Class;
		[Embed(source = "../../res/sprites/npcs/easter/randoms.png")] public static var embed_randoms:Class;
		[Embed(source = "../../res/sprites/npcs/easter/smoke_red.png")] public static var embed_smoke_red:Class;
		[Embed(source = "../../res/sprites/npcs/blue_npcs.png")] public static var embed_blue_npcs:Class;
		[Embed(source="../../res/sprites/npcs/cliffs_npcs.png")] public static var embed_cliff_npcs:Class;
		
		[Embed(source = "../../res/sprites/npcs/beach_npcs.png")] public static var embed_beach_npcs:Class;
		[Embed(source = "../../res/sprites/npcs/hotel_npcs.png")] public static const embed_hotel_npcs:Class;
		
		public var sparkles:FlxGroup = new FlxGroup(3);
		
		private var t:Number = 0;
		private var tm:Number = 0;
		private var ctr:int = 0;
		
		private var is_key:Boolean = false;
		private var is_generic:Boolean = false;
		private var generic_update:Function;
		
		public var radius:Number = 0;
		private var rotational_velocity:Number = 0.06;
		private var did_init:Boolean = false;
		
		private var windmill_blades:Array;
		private var windmill_shell:FlxSprite;
		private static var windmill_info:Array = new Array(0, 0, 0, 270, 0, 180);
		private var windmill_invis:Number = 0.1;
		
		private var distance:Number = 0;
		private var lonk_bush:FlxSprite;
		
		private const gen_id_sbr_blocker:int = 0; // Guy blocking way to card / death room in SBR
		private const gen_id_happy_event:int = 1; // even marker for happy
		private const gen_id_nexus_pad:int = 2;
		private const gen_id_windmill_stuff:int = 3;
		private const gen_id_cube_kings:int = 4;
		private const gen_id_eyeboss_preview:int = 5;
		private const gen_id_cliff_dog:int = 6;
		private const gen_id_quest_npc:int = 7;
		// redcave smoker, apartment thing
		private const gen_id_easter_eggs:int = 8; // not a typo
		private const gen_id_death_place:int = 9;
		private const gen_id_snowman:int = 10;
		private const gen_id_go_happy_blocker:int = 11;
		private const gen_id_hotelguy:int = 12;
		private const gen_id_hamster:int = 13;
		private const gen_id_chikapu:int = 14;
		private const gen_id_electric:int = 15;
		private const gen_id_marvin:int = 16;
		private const gen_id_melos:int = 17;
		private const gen_id_marina:int = 18;
		
		
		private static var eyeboss_preview_played:Boolean = false;
	/* dame vars:
		 * type - name
		 * */
	private var locked_ticks:int = 0;
	

		public function NPC(_xml:XML,_parent:*,_player:Player)
		{
			super(parseInt(_xml.@x), parseInt(_xml.@y));
			parent = _parent;
			player = _player;
			xml = _xml;
			immovable = true;
			switch (xml.@type.toString()) {
				//exports from the Generic_NPC sprite in DAME.
				// The frame determines what actions it will have.
				// The mapping of DAME-frame to NPC is above
				case "Cell_Body":
					is_generic = true;
					loadGraphic(embed_cell_bodies, true, false, 16, 16);
					generic_update = gu_cell_body;
					active_region = new FlxSprite(x - 2000, y - 2 + Registry.HEADER_HEIGHT);
					active_region.makeGraphic(20, 20, 0x0000ff00);
					frame = parseInt(xml.@frame);
					
					break;
				case "generic":
					is_generic = true;
					switch (parseInt(xml.@frame)) {
						case 0: // SBR blocker
							xml.@p = "2";
							generic_update = gu_suburb_blocker;
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							loadGraphic(Suburb_Walker.embed_suburb_folk, true,false, 16, 16);
							addAnimation("walk_d", [0,1], 4, true);
							addAnimation("walk_r", [2,3], 4, true);
							addAnimation("walk_u", [4,5], 4, true);
							addAnimation("walk_l", [6,7], 4, true);
							play("walk_d");
							if (xml.@alive == "false") {
								exists = false;
							}
							break;
						case 1:
							if (Registry.GE_States[Registry.GE_Happy_Started]) {
								exists = false;
								
							}
							generic_update = gu_happy_event;
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							makeGraphic(1, 1, 0x00123123);
						
							break;
						case 2:
						// NEXUS Pad
							generic_update = gu_nexus_pad;
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							loadGraphic(embed_nexus_pad, true, false, 32, 32);
							width = 20;
							height = 16;
							offset.y = 6; y += 8;
							offset.x = 8; x += 8;
							if (Registry.CURRENT_MAP_NAME == "TRAIN") {
								addAnimation("on", [3], 12);
								addAnimation("off", [2], 12);
							} else {
								addAnimation("on", [1], 12);
								addAnimation("off", [0], 12);
							}
							play("off");
							break;
						case gen_id_windmill_stuff:
							
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							generic_update = gu_windmill;
							
							windmill_blades = new Array();
							for (var i:int = 0; i < 3; i++) {
								var blade:FlxSprite = new FlxSprite(0, 0);
								blade.loadGraphic(embed_windmill_blade, true, false, 192, 192);
								switch (i) {
									case 1:
										blade.addAnimation("rotate", [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23,0, 1, 2, 3, 4, 5, 6,7,8,9,10,11,12,13,14,15], 20, true);
										
										blade.play("rotate");
										blade._curFrame = windmill_info[2];
										blade.angle = windmill_info[3];
										break;
									case 0:
										blade.addAnimation("rotate", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 0, 1, 2, 3, 4, 5, 6, 7], 20, true);
								blade.play("rotate");
										blade._curFrame = windmill_info[0];
										blade.angle = windmill_info[1];
										break;
									case 2:
										blade.addAnimation("rotate", [16, 17, 18, 19, 20, 21, 22, 23, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23], 20, true);
								blade.play("rotate");
										blade._curFrame = windmill_info[4];
										blade.angle = windmill_info[5];
										break;
								}
								blade.visible = false;
								// 0: Right, 1: up, 2: left, 3: down
								parent.anim_tiles_group.add(blade); // Removed automagically.
								windmill_blades.push(blade);
								
								
							}
							
							windmill_shell = new FlxSprite(0, 0);
							windmill_shell.loadGraphic(embed_windmill_shell, false, false, 48, 48);
							windmill_shell.x = Registry.CURRENT_GRID_X * 160 + 32;
							windmill_shell.y = Registry.CURRENT_GRID_Y * 160 + 20 + 48;
							if (Registry.CURRENT_GRID_Y == 3) windmill_shell.y -= 160;
							parent.fg_sprites.add(windmill_shell);
							//windmill_shell.visible = false;
							var center:Point = new Point(windmill_shell.x + 16, windmill_shell.y + 16);
							windmill_blades[0].x = center.x - 16;
							windmill_blades[0].y = center.y - 192 + 32;
							windmill_blades[1].x = center.x -192 + 32;
							windmill_blades[1].y = center.y  - 192 + 32;
							windmill_blades[2].x = center.x - 192 + 32;
							windmill_blades[2].y = center.y - 16;
							
							makeGraphic(1, 1, 0x00ffffff);
							break;
						// marina_ANIMS_CUBE_KINGS
						case gen_id_cube_kings:
							generic_update = gu_cube_kings;
							// add anmations ass needed
							if (Registry.CURRENT_GRID_X < 5) { // "gray"
								loadGraphic(Space_NPC.embed_space_npc, true, false, 32,32);
								addAnimation("a", [10,11], 4);
								play("a");
								ctr = 0;
							} else { // "color"
								loadGraphic(Space_NPC.embed_space_npc, true, false, 32,32);
								addAnimation("a", [12,13], 4);
								play("a");
								ctr = 1;
							}
							active_region = new FlxSprite(x, y + 30 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(32, 3, 0x0000ff00);
							break;
						case gen_id_eyeboss_preview:
							
							active_region = new FlxSprite(x, y + 30 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(32, 3, 0x0000ff00);
							
							loadGraphic(Eye_Boss.eye_boss_water_sprite, true, false, 24,24);
							addAnimation("blink", [0, 1, 2, 3, 2, 1, 0], 10, false);
							addAnimation("open", [3, 2, 1, 0], 5);
							addAnimation("closed", [3]);
							play("closed");
							alpha = 0;
							frame = 3;
							generic_update = gu_eyeboss_preview;
							if (Registry.GE_States[Registry.GE_Hotel_Boss_Dead_Idx]) exists = false;
							if (eyeboss_preview_played) {
								if (Math.random() > 0.3) {
									exists = false;
								}
							} else {
								eyeboss_preview_played = true;
							}
							break;
						case gen_id_cliff_dog:
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							loadGraphic(Dog.dog_sprite, true, false, 16, 16);
							addAnimation("walk", [2, 3], 8, true);
							addAnimation("stop", [0], 12, true);
							play("stop");
							generic_update = gu_cliff_dog;
							break;
						// NPCs for the trade quest. (dialogue quest)
						// Need to be talked to in order, give you access to the shed
						// in northern GO that gives a hint to the post-game temple NW of OVERWORLD
						case gen_id_quest_npc:
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							loadGraphic(embed_trade_npcs, true, false, 16, 16);
							generic_update = gu_quest_npc;
							switch (Registry.CURRENT_MAP_NAME) {
								case "CLIFF":
									loadGraphic(embed_cliff_npcs, true, false, 16, 16);
									addAnimation("a", [1], 2);
									addAnimation("move", [1,3,1,5,1,1,1,0,2,0,4,0,0,1,1], 3, false);
									break;
								case "BEACH":
									loadGraphic(embed_beach_npcs, true, false, 16, 16);
									addAnimation("a", [0], 2);
									addAnimation("turn", [1], 2);
									break;
								case "FOREST":
									loadGraphic(Forest_NPC.embed_forest_npcs, true, false, 16, 
									16);
									addAnimation("a", [10,10,10,11,10,10,10,12], 3, true);
									break;
								case "FIELDS":
									loadGraphic(Trade_NPC.embed_dame_trade_npc, true, false, 32,32);
									addAnimation("a", [15,15,15,15,15,15,15,15,16,17,17,18,18], 18, true);
									lonk_bush = new FlxSprite(x + 16, y + 32);
									lonk_bush.loadGraphic(Trade_NPC.embed_dame_trade_npc, true, false, 16, 16);
									lonk_bush.frame = 30;
									width = height = 16;
									y += 16;
									offset.y = 16;
									parent.bg_sprites.add(lonk_bush);
									break;
								case "TRAIN": //CELLc
									loadGraphic(embed_cell_bodies, true, false, 16, 16);
									addAnimation("idle_d", [8]);
									addAnimation("a", [8]);
									addAnimation("idle_r", [9]);
									addAnimation("idle_u", [10]);
									addAnimation("idle_l", [11]);
									play("idle_d");
									break;
								case "SUBURB":
									loadGraphic(Suburb_Walker.embed_suburb_folk, true, false, 16, 16);
									addAnimation("a", [0,1], 4, true);
									break;
								case "SPACE":
									loadGraphic(Space_NPC.embed_space_npc, true, false, 16, 16);
									addAnimation("a", [0,10,1,11], 10, true);
									break;
								case "GO":
									loadGraphic(note_rock, true, false, 16, 16);
									addAnimation("a", [0], 12, true);
										break;
							}
							play("a");
							break;
						case gen_id_easter_eggs:
							//MARINA_ANIMS_GEOMS
							switch (Registry.CURRENT_MAP_NAME) {
								case "REDCAVE":
									// smoking guy hidden in redcave
									active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
									active_region.makeGraphic(36, 36, 0x0000ff00);
									generic_update = gu_easter;
									loadGraphic(embed_smoke_red, false, true, 32, 32);
									break;
								case "APARTMENT":
									// Hidden something in roof of apartment
									active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
									active_region.makeGraphic(20, 20, 0x0000ff00);
									generic_update = gu_easter;
									loadGraphic(embed_randoms, true, false, 16, 16);
									addAnimation("APT", [0], 10);
									play("APT");
									break;
								case "FIELDS":
									// Rabbit (Olive)
									generic_update = gu_easter;
									active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
									active_region.makeGraphic(20, 20, 0x0000ff00);
									loadGraphic(Forest_NPC.embed_forest_npcs, true, false, 16, 16);
									addAnimation("idle", [30], 4, true);
									addAnimation("hop", [32,33,32,33], 4, false);
									break;
							}
							break;
						case gen_id_death_place:
							generic_update = gu_death_place;
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							visible = false;
							break;
						case gen_id_snowman:
							generic_update = gu_snowman;
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							loadGraphic(embed_blue_npcs, true, false, 16, 16);
							addAnimation("melt", [2, 3, 4, 5, 6], 8, false);
							frame = 0;
							
							if (xml.@alive == "false") {
								frame = 6;
							} else {
								xml.@alive = "true";
								xml.@p = "1";
							}
							
							break;
						case gen_id_go_happy_blocker:
							generic_update = gu_go_happy_blocker;
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							
							if (Registry.GE_States[Registry.GE_Briar_Blue_Done]) exists = false;
							loadGraphic(Briar_Boss.embed_ground_thorn, true, false, 16, 16);
							addAnimation("a", [7, 11], 8);
							play("a");
							y += 8;
							break;
						case gen_id_hotelguy:
							loadGraphic(embed_hotel_npcs, true, false, 16, 16);
							generic_update = gu_hotel_guy;
							addAnimation("idle_d", [0], 8);
							addAnimation("idle_r", [1], 8);
							addAnimation("idle_u", [2], 8);
							addAnimation("idle_l", [3], 8);
							play("idle_u");
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							break;
						case gen_id_hamster:
							generic_update = gu_fields_easter;
							fields_easter_scene = "hamster";
							loadGraphic(Trade_NPC.embed_dame_trade_npc, true, false, 16, 16);
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							addAnimation("a", [80, 81], 4);
							play("a");
							break;
						case gen_id_chikapu:
							generic_update = gu_fields_easter;
							fields_easter_scene = "chikapu";
							loadGraphic(Trade_NPC.embed_dame_trade_npc, true, false, 16, 16);
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							addAnimation("a", [82,83], 4);
							play("a");
							break;
						case gen_id_electric:
							generic_update = gu_fields_easter;
							fields_easter_scene = "electric";
							loadGraphic(Trade_NPC.embed_dame_trade_npc, true, false, 16, 16);
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							addAnimation("a", [84,85], 4);
							play("a");
							break;
						case gen_id_marvin:
							generic_update = gu_fields_easter;
							fields_easter_scene = "marvin";
							loadGraphic(Trade_NPC.embed_dame_trade_npc, true, false, 16, 16);
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							addAnimation("a", [86,87], 4);
							play("a");
							break;
						case gen_id_melos:
							generic_update = gu_easter;
							fields_easter_scene = "melos";
							loadGraphic(EndingState.embed_dev_npcs, true, false, 16, 16);
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							addAnimation("a", [0], 4);
							play("a");
							break;
						case gen_id_marina:
							generic_update = gu_easter;
							fields_easter_scene = "marina";
							loadGraphic(EndingState.embed_dev_npcs, true, false, 16, 16);
							active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
							active_region.makeGraphic(20, 20, 0x0000ff00);
							addAnimation("a", [10], 4);
							play("a");
							break;
						default:
							
							// Load some graphic
							// Sets width/height
							// Set update function
							break;
					}
					break;
					
				case "npc_test":
					loadGraphic(npc_spritesheet, true, false, 16, 16);
					active_region = new FlxSprite(x - 2, y - 2 + Registry.HEADER_HEIGHT);
					active_region.makeGraphic(20, 20, 0x0000ff00);
					get_dialogue = dialogue_test;
					break;
				case "statue":
					loadGraphic(sage_statue, true, false, 16, 16);
					height = 16;
					//offset.y = 16 - 8;
					//y += 16;
					active_region = new FlxObject(x, y, 20, 20);
					get_dialogue = dialogue_statue;
					break;
				case "rock":
					get_dialogue = dialogue_rock;
					if (Registry.CURRENT_MAP_NAME == "SPACE") {
							loadGraphic(Space_NPC.embed_space_npc, true, false, 16, 16);
						if (Registry.CURRENT_GRID_X > 5) {
							frame = 31;
						} else {
							frame = 30;
						}
					} else if (Registry.CURRENT_MAP_NAME == "TRAIN") {
						
						loadGraphic(note_rock, true, false, 16, 16);
						frame = 1;
					} else {
						loadGraphic(note_rock, true, false, 16, 16);
					}
					active_region = new FlxObject(x, y, 20, 20);
					break;
				case "big_key":
					if (xml.@alive == "false") {
						exists = false;
					}
					active_region = new FlxObject(x, y, 20, 20);
					Registry.subgroup_interactives.push(this);
					loadGraphic(key_green_embed, false, false, 16, 16);
					
					switch (Registry.CURRENT_MAP_NAME) {
						case "BEDROOM": 
							frame = 0;
							break;
						case "REDCAVE":
							frame = 2;
							break;
						case "CROWD":
							frame = 4;
							break;
					}
					width = 9;
					offset.x = 3;
					x += 3;
					tm = 0.8;
					for (i = 0; i < sparkles.maxSize; i++) {
						var s:FlxSprite = new FlxSprite;
						s.loadGraphic(key_sparkle_embed, true, false, 7, 7);
						s.addAnimation("sparkle", [3, 2, 1, 0], 8, false);
						s.play("sparkle");
						s.visible = false;
						sparkles.add(s);
					}
					my_shadow = EventScripts.make_shadow("8_small", false);
					my_shadow.frame = 1;
					xml.@p = "2";
					parent.fg_sprites.add(sparkles);
					parent.bg_sprites.add(my_shadow);
					is_key = true;
					break;
				case "biofilm":
					loadGraphic(npc_biofilm, true, false, 32, 32);
					active_region = new FlxObject(0, 0, 1, 1);
					addAnimation("move", [0], 8, true);
					addAnimation("break", [1], 7, false);
					addAnimation("broken", [1], 2, false);
					if (xml.@alive == "false") {
						play ("broken");
						Registry.Event_Biofilm_Broken = true;
					} else {
						play("move");
					}
					is_generic = true;
					generic_update = update_biofilm;
					break;
					
			}
			
			Registry.subgroup_interactives.push(this);
		}
		
		
		private var fields_easter_scene:String;
		private function gu_fields_easter():void {
			immovable = true;
			FlxG.collide(this, player);
			if (DH.nc(player, active_region)) {
				DH.start_dialogue(DH.name_generic_npc, fields_easter_scene, "FIELDS");
			}
		}
		
		private function gu_hotel_guy():void {
			immovable = true;
			FlxG.collide(this, player);
			if (DH.nc(player, active_region)) {
				DH.start_dialogue(DH.name_generic_npc, "one", "HOTEL");
				EventScripts.face_and_play(this, player, "idle");
			}
		}
		private function gu_go_happy_blocker():void {
			if (parent.state == parent.S_TRANSITION) return;
			if (player.x < (Registry.CURRENT_GRID_X * 160 + 16)) {
				player.x = Registry.CURRENT_GRID_X  * 160 + 16;
			}
			return;
		}
		
		private var  talk_tm:Number = 3;
		private var talked:Boolean = false;
		private function gu_snowman():void {
			
			if (frame != 7) {
				FlxG.collide(player, this);
			}
			
			if (xml.@alive == "false") {
				if (false == DH.a_chunk_is_playing() && player.overlaps(active_region) && Registry.keywatch.JP_ACTION_1) {
					DH.dialogue_popup("...");
					player.be_idle();
				}
				return;
			}
			
			var gx:int = Registry.CURRENT_GRID_X;
			var gy:int = Registry.CURRENT_GRID_Y;
			if (false == talked && false == DH.a_chunk_is_playing() && player.overlaps(active_region) && Registry.keywatch.JP_ACTION_1) {
				var pos:int;
				if (gx == 0 && gy == 1) {
					DH.start_dialogue(DH.name_generic_npc, DH.scene_snowman_one, "", 0);
				} else if (gx == 1 && gy == 1) {
					DH.start_dialogue(DH.name_generic_npc, DH.scene_snowman_one, "", 2);
				}  else if (gx == 1 && gy == 2) {
					DH.start_dialogue(DH.name_generic_npc, DH.scene_snowman_one, "", 4);
				}
				player.be_idle();
				talked = true;
			}
			
			if (false == DH.a_chunk_is_playing() && talked == true && frame != 7) {
				play("melt");
				xml.@alive = "false";
			}
			
			
			talk_tm -= FlxG.elapsed;
			if (false == talked && talk_tm < 0) {
				talk_tm = 500000;
				player.be_idle();
				if (gx == 0 && gy == 1) {
					DH.start_dialogue(DH.name_generic_npc, DH.scene_snowman_one, "", 1);
				} else if (gx == 1 && gy == 1) {
					DH.start_dialogue(DH.name_generic_npc, DH.scene_snowman_one, "", 3);
				}  else if (gx == 1 && gy == 2) {
					DH.start_dialogue(DH.name_generic_npc, DH.scene_snowman_one, "", 5);
				}
			}
		}
		
		// Area you enter if you die and don't continue. When passing through this,
		// send game state to title screen after fading
		private function gu_death_place():void {
			var tl:int = Registry.CURRENT_GRID_Y * 160 + 20;
			
			Registry.GAMESTATE.darkness.alpha = Math.max(0.8, (player.y - tl) / 120.0);
			
			if (Registry.GAMESTATE.darkness.alpha > 0.95 && (player.y - tl) > 140) {
				Registry.E_DESTROY_PLAYSTATE = true;
				Registry.cleanup_on_map_change();
				Registry.sound_data.stop_current_song();
				DH.enable_menu(); // Disabled when you chose "No" from death screen
				FlxG.switchState(new TitleState);
			}
		}
		private function gu_easter():void {
			
			immovable = true;
			FlxG.collide(player, this);
			
			if (player.overlaps(active_region) && Registry.keywatch.JP_ACTION_1) {
				player.be_idle();
				switch (Registry.CURRENT_MAP_NAME) {
					case "REDCAVE":
						DH.start_dialogue(DH.name_generic_npc, DH.scene_generic_npc_any_easter_egg);
						break;
					case "APARTMENT":
						DH.start_dialogue(DH.name_generic_npc, DH.scene_generic_npc_any_easter_egg);
						break;
					case "FIELDS":
						DH.start_dialogue(DH.name_generic_npc, DH.scene_generic_npc_any_easter_egg);
						break;
					case "DEBUG":
						DH.start_dialogue(DH.name_generic_npc, fields_easter_scene);
						break;
				}
			}
			
			switch (Registry.CURRENT_MAP_NAME) {
				case "REDCAVE":
					PlayState.turn_on_effect(PlayState.GFX_DISCO);
					alpha = 0.6 + 0.4 * Math.random();
					scale.x = 0.8 + 0.4 * Math.random();
					scale.y = 0.8 + 0.4 * Math.random();
					break;
				case "APARTMENT":
					break;
				case "FIELDS":
					if (ctr == 0) {
						play("idle");
						t += FlxG.elapsed;
						if (t > 1.4) {
							t = 0;
							ctr = 1;
						}
					} else if (ctr == 1) {
						play("hop");
						scale.x = 1;
						velocity.x = 25;
						ctr = 2;
					} else if (ctr == 2) {
						if (_curAnim.frames.length - 1 == _curFrame) {
							play("idle");
							velocity.x = 0;
							ctr = 3;
						}
					} else if (ctr == 3) {
						t += FlxG.elapsed;
						if (t > 1.6) {
							t = 0;
							ctr = 4;
							velocity.x = -25;
							scale.x = -1;
							play("hop");
						}
					} else if (ctr == 4) {
						if (_curAnim.frames.length - 1 == _curFrame) {
							play("idle");
							velocity.x = 0;
							ctr = 0;
						}
					}
					break;
					
			}
		}
		
		// Only play the Quest NPC dialogue once per entrance into the current room
		private var local_played_quest:Boolean = false;
		private function gu_quest_npc():void {
			
			immovable = true;
			FlxG.collide(player, this);
			
			if (false == DH.a_chunk_is_playing() && player.overlaps(active_region) && Registry.keywatch.JP_ACTION_1) {
				player.be_idle();
				immovable = true;
				FlxG.collide(player, this);
				var a:Array = Registry.GE_States;
				var n:String = Registry.CURRENT_MAP_NAME;
				var b:Boolean = false;
				if (n == "CLIFF" && false == a[Registry.GE_QUEST_BEACH]) {
					b = a[Registry.GE_QUEST_CLIFF] = true;
					play("move");
				} else if (n == "BEACH" && false == a[Registry.GE_QUEST_FOREST] && true == a[Registry.GE_QUEST_CLIFF]) {
					b = a[Registry.GE_QUEST_BEACH] = true;
				} else if (n == "FOREST" && false == a[Registry.GE_QUEST_FIELDS] && true == a[Registry.GE_QUEST_BEACH]) {
					b = a[Registry.GE_QUEST_FOREST] = true;
				} else if (n == "FIELDS" && false == a[Registry.GE_QUEST_CELL] && true == a[Registry.GE_QUEST_FOREST]) {
					b = a[Registry.GE_QUEST_FIELDS] = true;
				} else if (n == "TRAIN" && false == a[Registry.GE_QUEST_SUBURB] && true == a[Registry.GE_QUEST_FIELDS]) {
					b = a[Registry.GE_QUEST_CELL] = true;
				} else if (n == "SUBURB" && false == a[Registry.GE_QUEST_SPACE] && true == a[Registry.GE_QUEST_CELL]) {
					b = a[Registry.GE_QUEST_SUBURB] = true;
				}  else if (n == "SPACE" && false == a[Registry.GE_QUEST_GO] && true == a[Registry.GE_QUEST_SUBURB]) {
					b = a[Registry.GE_QUEST_SPACE] = true;
				} else if (n == "GO" && true == a[Registry.GE_QUEST_SPACE]) {
					b = a[Registry.GE_QUEST_GO] = true;
				}
				
				// If the previous thing was done and the next is not done, play the event dialogue.
				// Otherwise, play normal dialogue.
				if (true == b && false == local_played_quest) {
					local_played_quest = true;
					DH.start_dialogue(DH.name_generic_npc, DH.scene_generic_npc_any_quest_event, n);
				} else {
					if (n == "BEACH" || n == "FOREST" || n == "CLIFF") {
						if (n == "CLIFF") {
							play("move");
						}
						if (S_NPC.check_to_play_second(DH.name_generic_npc, DH.scene_generic_npc_any_quest_normal, n)) {
							DH.start_dialogue(DH.name_generic_npc, DH.scene_generic_npc_any_second, n);
						} else {
							DH.start_dialogue(DH.name_generic_npc, DH.scene_generic_npc_any_quest_normal, n);
						}
					} else {
						DH.start_dialogue(DH.name_generic_npc, DH.scene_generic_npc_any_quest_normal, n);
					}
				}
				
				if (n == "TRAIN") {
					EventScripts.face_and_play(this, player, "idle");
				}
				if (n == "BEACH") {
					play("turn");
				}
				
			}
			// for debugging
			//if (FlxG.keys.justPressed("W")) Registry.GE_States[Registry.GE_Bedroom_Boss_Dead_Idx] = true;
			
			if (Registry.CURRENT_MAP_NAME == "FIELDS") {
				lonk_bush.immovable = true;
				active_region.x = x - 2;
				active_region.y = y - 2;
				FlxG.collide(lonk_bush, player);
				if (false == DH.a_chunk_is_playing() && player.broom.visible && player.broom.overlaps(lonk_bush)) {
					DH.start_dialogue(DH.name_generic_npc, DH.scene_rank_bush);
				}
			}
			
			// Other behavior, possibly..
		}
		private function gu_cliff_dog():void {
			t += FlxG.elapsed;
			if (ctr == 0) { // Still left
				if (t > 1) {
					if (Math.random() > 0.6) {
						t = 0;
						ctr = 1;
						play("walk");
						scale.x = 1;
						velocity.x = 15;
					} 
				}
			} else if (ctr == 1) { // move l -> r
				if (t > 1) {
					t = 0;
					ctr = 3;
					play("stop");
					scale.x = 1;
					velocity.x = 0;
				}
			} else if (ctr == 2) { // move r _> l
				
				if (t > 1) {
					t = 0;
					ctr = 0;
					scale.x = 1;
					play("stop");
					velocity.x = 0;
				}
			} else {
				if (t > 1) {
					if (Math.random() > 0.6) {
					t = 0;
						ctr = 2;
						scale.x = -1;
						play("walk");
						velocity.x = -15;
					}
				}
			}
			
			
			FlxG.collide(player, this);
			active_region.x = x - 2;
			active_region.y = y - 2;
			
			
			if (player.overlaps(active_region) && Registry.keywatch.JP_ACTION_1) {
				player.be_idle();
				DH.start_dialogue(DH.name_cliff_dog, DH.scene_cliff_dog_top_left);
			}
			
		}
		private function gu_cell_body():void {
			
		}
		private function gu_eyeboss_preview():void {
			
			switch (ctr) {
				case 0:
					alpha += 0.008;
					if (alpha >= 1) {
						ctr++;
						play("open");
					}
					break;
				case 1:
					if (finished) {
						ctr++;
						play("blink");
					}
					break;
				case 2:
					if (finished) {
						ctr++;
						
					}
					break;
				case 3:	
					alpha -= 0.05;
					break;
			}
			
		}
		private function gu_cube_kings():void {
			FlxG.collide(player, this);
			if (player.overlaps(active_region) && Registry.keywatch.JP_ACTION_1) {
				switch (ctr) {
					case 0: //gray
						if (!DH.a_chunk_is_playing()) {
							player.be_idle();
							DH.start_dialogue(DH.name_cube_king, DH.scene_cube_king_space_gray);
						}
						break;
					case 1: //color 
						if (!DH.a_chunk_is_playing()) {
							DH.start_dialogue(DH.name_cube_king, DH.scene_cube_king_space_color);
						}
						break;
				}
			}
		}
		private function gu_windmill():void {
			// rotate the blades
			// RULD'
			
			windmill_invis -= FlxG.elapsed;
			
			var b:FlxSprite;
			for (var i:int = 0; i < 3; i ++) {
				b = windmill_blades[i];
				
				if (windmill_invis < 0) {
					b.visible = true;	
				}
				if (Registry.CUTSCENES_PLAYED[Cutscene.Windmill_Opening] == 0) {
					trace(1);
					if (i == 0) 
					b.frame = 0;
					if (i == 1)
					b.frame = 8;
					if (i == 2)
					b.frame = 16;
				} else {
					if (b._curAnim == null) 
						b.play("rotate");
				}
				
				switch (i) {
					case 0:
						if (b._curFrame >= 24) {
							b.angle = 270;
						} else {
							b.angle = 0;
						}
						break;
					case 1:
						if (b._curFrame >= 16) {
							b.angle = 180;
						} else {
							b.angle = 270;
						}
						 
						break;
					case 2:
						if (b._curFrame >= 8) {
							b.angle = 90;
						} else {
							b.angle = 180;
						}
						break;
				}
				set_pos(b);
				windmill_info[2*i] = b._curFrame;
				windmill_info[2 * i + 1] = b.angle;
			}
			
		}
		
		
		private function set_pos(blade:FlxSprite):void {
			var center:Point = new Point(windmill_shell.x + 16, windmill_shell.y + 16);
			switch (blade.angle) {
				case 0:
					blade.x = center.x - 16;
					blade.y = center.y - 192 + 32;
					break;
				case 90:
					blade.x = center.x - 16;
					blade.y = center.y - 16;
					break;
				case 180:
					blade.x = center.x - 192 + 32;
					blade.y = center.y - 16;
					break;
				case 270:
					blade.x = center.x -192 + 32;
					blade.y = center.y  - 192 + 32;
					break;
			}
		}
		
		private function gu_nexus_pad():void {
			// If on, beep, if press c, warp
			// if off..
			
			// off
			if (!did_init) {
				did_init = true;
				parent.sortables.remove(this, true);
				parent.bg_sprites.add(this);
			}
			if (ctr == 0) {
				if (player.overlaps(this) && player.state == player.S_GROUND) {
					ctr = 1;
					play("on");
					Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
				}
			} else {
				if (!player.overlaps(this)) {
					ctr = 0;
					play("off");
				}
				
				if (Registry.keywatch.JP_ACTION_1) {
					load_nexus_data();
					parent.SWITCH_MAPS = true;	
				}
			}
			
		}
		
		private var happy_tlx:int = Registry.CURRENT_GRID_X * 160 + 80;
		private function gu_happy_event():void {
			switch (ctr) {
				case 0:
					Registry.volume_scale -= 0.015;
					if (player.state == player.S_GROUND && player.x < happy_tlx) {
						Registry.volume_scale = 0;
						Registry.sound_data.stop_current_song();
						Registry.sound_data.red_cave_rise.play();
						FlxG.shake(0.02, 1.0);
						player.state = player.S_INTERACT;
						DH.disable_menu();
						DH.start_dialogue(DH.name_happy_npc, DH.scene_happy_npc_briar);
						player.be_idle();
						ctr++;
					}
					break;
				case 1:
					FlxG.shake(0.02,0.1);
					if (DH.a_chunk_is_playing() == false && !Registry.sound_data.red_cave_rise.playing) {
						ctr++;
						player.state = player.S_GROUND;
						FlxG.flash(0xffff0000, 1);
						Registry.volume_scale = 1;
						Registry.GE_States[Registry.GE_Happy_Started] = true;
						Registry.GAMESTATE.ext_make_anims();
						Registry.sound_data.start_song_from_title("HAPPY");
						Registry.GAMESTATE.darkness.visible = true;
						DH.enable_menu();
					}
					break;
			}
		}
		private function gu_suburb_blocker():void {
			active_region.x = x - 2;
			active_region.y = y - 2;
			
			FlxG.collide(this, player);
			
			if (ctr == 0) {
				if (parent.state == parent.S_NORMAL) {
					if (Registry.keywatch.JP_ACTION_1 && player.overlaps(active_region) && player.state == player.S_GROUND) {
						player.be_idle();
						EventScripts.face_and_play(player, this, "walk");
						
						if (Registry.Event_Nr_Suburb_Killed < 6) {
							DH.start_dialogue(DH.name_suburb_blocker, DH.scene_suburb_blocker_one, "", 0);
						} else if (Registry.Event_Nr_Suburb_Killed < 9) {
							DH.start_dialogue(DH.name_suburb_blocker, DH.scene_suburb_blocker_one, "", 1);
							
						} else if (Registry.Event_Nr_Suburb_Killed < 10) {
							DH.start_dialogue(DH.name_suburb_blocker, DH.scene_suburb_blocker_one, "", 2);
						} else {
							DH.start_dialogue(DH.name_suburb_blocker, DH.scene_suburb_blocker_one, "", 3);
							ctr = 1;
						}
					}
				} 
			} else if (ctr == 1) {
				flicker(0.5);
				alpha -= 0.01;
				if (alpha == 0) {
					ctr = 2;
				}
			} else if (ctr == 2) {
				xml.@alive = "false";
				exists = false;
			}
			
		}
		private function update_biofilm():void {
			if (!did_init) {
				did_init = true;
				parent.sortables.remove(this, true);
				parent.bg_sprites.add(this);
			}
			if (xml.@alive == "true" && player.state == player.S_ENTER_FALL) {
				ctr = 1;
			}
			
			if (ctr == 0) {
				
			} else if (ctr == 1) {
				if (player.offset.y < 16) {
					Registry.sound_data.broom_hit.play();
					play("break");
					xml.@alive = "false";
					Registry.Event_Biofilm_Broken = true;
					ctr = 0;
				}
			}
		}
		override public function update():void 
		{
			
			if (is_key) {
				big_key_update();
				super.update();
				return;
			} else if (is_generic) {
				generic_update();
				super.update();
				return;
			}
			
			FlxG.collide(player, this);
			active_region.x = x - 2;
			active_region.y = y - 2;
			if (parent.state == parent.S_NORMAL) {
				if (Registry.keywatch.JP_ACTION_1 && player.overlaps(active_region) && player.state == player.S_GROUND) {
					get_dialogue();
					EventScripts.face_and_play(player, this, "idle");
				}
			} 
			super.update();
		}
		
		public function big_key_update():void  {
			my_shadow.x = x;
			my_shadow.y = y;
		
			// Make sparkles
			t += FlxG.elapsed;
			if (t > tm) {
				for each (var sparkle:FlxSprite in sparkles.members) {
					if (sparkle == null) continue;
					if (sparkle.finished) {
						sparkle.visible = true;
						sparkle.x = x  - 2 + (width + 4) * Math.random();
						sparkle.y = y - 3 +  (height + 6) * Math.random() - offset.y;
						sparkle.play("sparkle");
						t = 0;
						// Sparkles  come out faster and faster nad fasters
						if (ctr > 0 && ctr < 4) {
							trace(tm);
							if (tm > 0.15) {
								tm -= 0.06;
							}
							sparkle.velocity.y = 20;
							Registry.sound_data.play_sound_group_randomly(Registry.sound_data.sparkle_group);
						}
						break;
					}
				}
			}
			var sub_ctr:int = 0;
			switch (ctr) {
				case 0:
					// Wait for player to interact
					FlxG.collide(player, this);
					active_region.x = x - 2;
					active_region.y = y - 2;
					if (parent.state == parent.S_NORMAL) {
						if (Registry.keywatch.JP_ACTION_1 && player.overlaps(active_region) && player.state == player.S_GROUND) {
							DH.disable_menu();
							EventScripts.face_and_play(player, this, "idle");
							player.state = player.S_INTERACT;
							ctr++;
							rotate_angle = EventScripts.get_angle(player.x, player.y, x, y);
							radius = EventScripts.distance(new Point(player.x + 5, player.y + 5), this);
							my_shadow.visible = true;
							my_shadow.frame = 0;
							
							// Chang einventory state
							xml.@alive = "false";
							switch (Registry.CURRENT_MAP_NAME) {
								case "BEDROOM":
									Registry.inventory[Registry.IDX_GREEN_KEY] = true;
									break;
								case "REDCAVE":
									Registry.inventory[Registry.IDX_RED_KEY] = true;
									break;
								case "CROWD":
									Registry.inventory[Registry.IDX_BLUE_KEY] = true;
									break;
							}
						}
					} 
					break;
				case 1:
					// rotate
					if (EventScripts.send_property_to(this.offset, "y", 16, 0.3)) sub_ctr++;
					if (EventScripts.send_property_to(this, "radius", 40, 0.2)) sub_ctr++;
					
					EventScripts.rotate_about_center_of_sprite(player, this, radius, rotational_velocity, 0, 0);
					
					if (sub_ctr == 2) {
						my_shadow.frame = 2;
						ctr++;
						rotational_velocity *= 2;
					}
					break;
				case 2:
					//slowly rotate higher/closer
					if (EventScripts.send_property_to(this.offset, "y", 64, 0.3)) sub_ctr++;
					if (EventScripts.send_property_to(this, "radius", 2, 0.14)) sub_ctr++;
					
					EventScripts.rotate_about_center_of_sprite(player, this, radius, rotational_velocity, 0, 0);
					
					if (sub_ctr == 2) {
					//	Play "ding" noise,
						ctr++;
					}
					break;
				case 3:
					//move higher while not rotating
					if (EventScripts.send_property_to(this.offset, "y", 70, 0.05)) sub_ctr++;
					if (sub_ctr == 1) {
						ctr++;
					}
					
					break;
				case 4:
					// fly into player
					if (EventScripts.send_property_to(this.offset, "y", 16, 2.2)) sub_ctr++;
					
					// Flash the screen
					if (sub_ctr == 1) {
						FlxG.flash(0xffffffff, 2.0);
						FlxG.shake(0.02, 0.4);
						
						Registry.sound_data.sun_guy_death_l.play();
						visible = false;
						my_shadow.visible = false;
						ctr++;
					}
					
					break;
				case 5:
					DH.enable_menu();
					parent.player.state = parent.player.S_GROUND;
					xml.@alive = "false";
					exists = false;
					
					break;
			}
			super.update();
		}
		
		private function dialogue_test():void {
			DH.start_dialogue(DH.name_test, DH.scene_test_debug_scene_1);
		}
		
		private function dialogue_statue():void {
			player.be_idle();
			switch (Registry.CURRENT_MAP_NAME) {
				case "OVERWORLD":
					DH.start_dialogue(DH.name_statue, DH.scene_statue_overworld_bedroom_entrance);
					break;
				case "NEXUS":
					DH.start_dialogue(DH.name_statue, DH.scene_statue_nexus_enter_nexus);
					break;
				case "BEDROOM":
					DH.start_dialogue(DH.name_statue, DH.scene_statue_bedroom_after_boss);
					break;
				case "TERMINAL":
					DH.start_dialogue(DH.name_statue, "one");
					break;
				case "REDCAVE":
					DH.start_dialogue(DH.name_statue, "one");
					break;
			}
		}
		
		private function dialogue_rock():void {
			
			var scene:String;
			switch (parseInt(xml.@frame)) {
				case 0:
					scene = DH.scene_rock_one;
					break;
				case 1:
					scene = DH.scene_rock_two;
					break;
				case 2:
					scene = DH.scene_rock_three;
					break;
				case 3:
					scene = DH.scene_rock_four;
					break;
				case 4:
					scene = DH.scene_rock_five;
					break;
				case 5:
					scene = DH.scene_rock_six;
					break;
			}
			
			if (DH.start_dialogue(DH.name_rock, scene)) {
				player.be_idle();
				DH.increment_property(DH.name_rock, "times_talked");
				trace("rock", DH.get_int_property(DH.name_rock, "times_talked"));
				if (DH.get_int_property(DH.name_rock, "times_talked") < 2) {
					//Registry.cur_dialogue =  "There is writing scrawled on this rock:^\n" + Registry.cur_dialogue;
					Registry.cur_dialogue =  DH.lk("rock",0)+"^\n" + Registry.cur_dialogue;
				}
			}
			// Update 
		}
		
		private static function nexus_helper(idx:int,curmap:String):void 
		{
			//Door.is_nexus_door_open(idx);
			Registry.NEXT_MAP_NAME = "NEXUS";
			var a:Array = Registry.DOOR_INFO[idx];
				
			if (Registry.DOOR_INFO[idx][0][2] != curmap) {
				Registry.ENTRANCE_PLAYER_X = Registry.DOOR_INFO[idx][0][0];
				Registry.ENTRANCE_PLAYER_Y = Registry.DOOR_INFO[idx][0][1];
			} else {
				Registry.ENTRANCE_PLAYER_X = Registry.DOOR_INFO[idx][1][0];
				Registry.ENTRANCE_PLAYER_Y = Registry.DOOR_INFO[idx][1][1];
			}
			Registry.ENTRANCE_PLAYER_X += 10;
			Registry.ENTRANCE_PLAYER_Y += 34;
		}
		
		public static function load_nexus_data():void 
		{
			switch (Registry.CURRENT_MAP_NAME) {
				case "WINDMILL":
					nexus_helper(Door.Door_Nexus_Windmill, Registry.CURRENT_MAP_NAME);
					break;
				case "CLIFF":
					nexus_helper(Door.Door_Nexus_Cliff, Registry.CURRENT_MAP_NAME);
					break;
				case "FOREST":
					nexus_helper(Door.Door_Nexus_Forest, Registry.CURRENT_MAP_NAME);
					break;
				case "REDSEA":
					nexus_helper(Door.Door_Nexus_Redsea, Registry.CURRENT_MAP_NAME);
					break;
				case "BEACH":
					nexus_helper(Door.Door_Nexus_Beach, Registry.CURRENT_MAP_NAME);
					break;
				case "GO":
					nexus_helper(Door.Door_Nexus_Go, Registry.CURRENT_MAP_NAME);
					break;
				case "HAPPY":
					nexus_helper(Door.Door_Nexus_Happy, Registry.CURRENT_MAP_NAME);
					break;
				case "BLUE":
					nexus_helper(Door.Door_Nexus_Blue, Registry.CURRENT_MAP_NAME);
					break;
				case "FIELDS":
					nexus_helper(Door.Door_Nexus_Fields, Registry.CURRENT_MAP_NAME);
					break;
				case "BEDROOM":
					nexus_helper(Door.Door_Nexus_Bedroom, Registry.CURRENT_MAP_NAME);
					break;
				case "REDCAVE":
					nexus_helper(Door.Door_Nexus_Redcave, Registry.CURRENT_MAP_NAME);
					break;
				case "CROWD":
					nexus_helper(Door.Door_Nexus_Crowd, Registry.CURRENT_MAP_NAME);
					break;
				case "APARTMENT":
					nexus_helper(Door.Door_Nexus_Apartment, Registry.CURRENT_MAP_NAME);
					break;
				case "HOTEL":
					nexus_helper(Door.Door_Nexus_Hotel, Registry.CURRENT_MAP_NAME);
					break;
				case "CIRCUS":
					nexus_helper(Door.Door_Nexus_Circus, Registry.CURRENT_MAP_NAME);
					break;
				case "TRAIN":
					nexus_helper(Door.Door_Nexus_Cell, Registry.CURRENT_MAP_NAME);
					break;
				case "SUBURB":
					nexus_helper(Door.Door_Nexus_Suburb, Registry.CURRENT_MAP_NAME);
					break;
				case "SPACE":
					nexus_helper(Door.Door_Nexus_Space, Registry.CURRENT_MAP_NAME);
					break;
				case "TERMINAL":
					nexus_helper(Door.Door_Nexus_Terminal, Registry.CURRENT_MAP_NAME);
					break;
				case "OVERWORLD":
					nexus_helper(Door.Door_Nexus_Overworld, Registry.CURRENT_MAP_NAME);
					break;
				case "STREET":
					nexus_helper(Door.Door_Nexus2Street, Registry.CURRENT_MAP_NAME);
					break;
			}
		}
		
		
		override public function destroy():void 
		{
			DH.a_chunk_just_finished();
			sparkles = null;
			active_region = null;
			windmill_blades = null;
			windmill_shell = null;
			super.destroy();
		}
	}

}

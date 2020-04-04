package helper 
{
	import data.Common_Sprites;
	import data.CSV_Data;
	import data.TileData;
	import entity.decoration.Solid_Sprite;
	import entity.interactive.Dungeon_Statue;
	import entity.interactive.Terminal_Gate;
	import flash.geom.Point;
	import global.Registry;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	import states.PushableFlxState;
	public class Cutscene extends PushableFlxState
	{
		/* Cutscene types */
		public static const Red_Cave_Left:int = 0;
		public static const Red_Cave_Right:int = 1;
		public static const Red_Cave_North:int = 2;
		public static const Terminal_Gate_Bedroom:int = 3;
		public static const Terminal_Gate_Redcave:int = 4;
		public static const Terminal_Gate_Crowd:int = 5;
		public static const Windmill_Opening:int = 6;
		
		// pointers to functions for transitioning in and out of the cutscene
		private var transition_in:Function;
		private var transition_out:Function;
		private var step_cutscene:Function;
		
		// parameters you set that will be used in the above functions
		private var tran_in_args:Array = new Array(1, 2);
		private var tran_out_args:Array = new Array(3, 4);
		
		public const s_transition_in:int = -1;
		public const s_in_progress:int = 0;
		public const s_transition_out:int = 2;
		public const s_done:int = 3;
		public var state:int = -1;
		
		public var timer:Number;
		public var timer_max:Number;
		public var pushdown:int = 0;
		public var pushee:FlxSprite;
		
		public var entity_1:FlxSprite;
		public var entity_2:FlxSprite;
		public var entity_3:FlxSprite;
		
		private var ctr_cutscene:int = 0;
		
		private var _parent:*;
		
		
		public var scene_1:FlxTilemap;
		public var scene_2:FlxTilemap;
		public var scene_3:FlxTilemap;
		
		public var fade:FlxSprite;
		
		public function Cutscene(v_parent:*) {
			_parent = v_parent;
			create();
		}
		
		
		/* Initialize the entities with each cutscene */
		override public function create():void 
		{
			transition_in = do_nothing;
			transition_out = do_nothing;
			switch (Registry.CURRENT_CUTSCENE) {
				case Red_Cave_Left:
					transition_in = red_in;
					transition_out = red_out;
					step_cutscene = step_red_cave;
					timer = timer_max = 0.02;
					inst_red_cave_left();
					//Load the sprites and store 'em
					//Pick a section of map to load from the right map and load it
					break;
				case Red_Cave_North:
					transition_in = red_in;
					transition_out = red_out;
					step_cutscene = step_red_cave;
					timer = timer_max = 0.02;
					inst_red_cave_north();
					break;
				case Red_Cave_Right:
					transition_in = red_in;
					transition_out = red_out;
					step_cutscene  = step_red_cave;
					timer = timer_max = 0.02;
					inst_red_cave_right();
					break;
				case Terminal_Gate_Bedroom:
				case Terminal_Gate_Crowd:
				case Terminal_Gate_Redcave:
					transition_in = terminal_gate_in;
					transition_out = terminal_gate_out;
					step_cutscene = step_terminal_gate;
					inst_terminal_gate();
					
					break;
				case Windmill_Opening:
					transition_in = windmill_in;
					transition_out = windmill_out;
					step_cutscene = step_windmill_opening;
					inst_windmill();
					break;
			}
		}
		
		override public function update():void
		{
			if (state == s_transition_in) {
				transition_in.apply(null, tran_in_args);
			} else if (state == s_in_progress) {
				step_cutscene();
			} else if (state == s_transition_out) {
				transition_out.apply(null, tran_out_args);
			} else if (state == s_done) {
				
			}
			super.update();
		}
		
		public function do_nothing():void {
			
		}
		
		private function windmill_in(a:int, b:int):void {
			state = s_in_progress;
		}
		private function windmill_out(a:int, b:int):void {
			state = s_done;
		}
		private function step_windmill_opening():void {
			
			switch (ctr_cutscene) {
				case 0:
					Registry.volume_scale -= 0.01;
					Registry.sound_data.current_song.volume = FlxG.volume * Registry.volume_scale;
					if (Registry.volume_scale <= 0) {
						Registry.volume_scale = 0;
						Registry.sound_data.wb_tap_ground.play();
						ctr_cutscene += 2;
					} else {
						Registry.volume_scale = 0;
					}
					break;
				case 1:
					break;
				case 2:
					ctr_cutscene++;
					fade.exists = true;
					fade.alpha = 0;
					break;
				case 3:
					fade.alpha += 0.01;
					if (fade.alpha == 1) {
						ctr_cutscene++;
						entity_1.exists = scene_1.exists = true;
					}
					break;
				case 4: // Move bedroom satue
					fade.alpha -= 0.01;
					if (fade.alpha <= 0.45 && fade.alpha > 0.43) {
						Registry.sound_data.red_cave_rise.play();
					}
					if (fade.alpha == 0) {
						if (EventScripts.send_property_to(entity_1, "y", 20, 0.2)) {
							Registry.sound_data.wb_hit_ground.play();
							FlxG.shake(0.05, 0.5);
							ctr_cutscene++;
						}
					}
					break;
				case 5:
					fade.alpha += 0.01;
					if (fade.alpha == 1) {
						entity_1.exists = scene_1.exists = false;
						entity_2.exists = scene_2.exists = true;
						ctr_cutscene++;
					}
					break;
				case 6: // move red stat
					fade.alpha -= 0.01;
					if (fade.alpha <= 0.45 && fade.alpha > 0.43) {
						Registry.sound_data.red_cave_rise.play();
					}
					if (fade.alpha == 0) {
						if (EventScripts.send_property_to(entity_2, "x", 4 * 16 + 32, 0.2)) {
							Registry.sound_data.wb_hit_ground.play();
							FlxG.shake(0.05, 0.5);
							ctr_cutscene++;
						}
					}
					break;
				case 7:
					fade.alpha += 0.01;
					if (fade.alpha == 1) {
						entity_2.exists = scene_2.exists = false;
						entity_3.exists = scene_3.exists = true;
						ctr_cutscene++;
					}
					break;
				case 8: // move blue stat
					fade.alpha -= 0.01;
					if (fade.alpha <= 0.45 && fade.alpha > 0.43) {
						Registry.sound_data.red_cave_rise.play();
					}
					if (fade.alpha == 0) {
						if (EventScripts.send_property_to(entity_3, "x", 4 * 16 + 32, 0.2)) {
							Registry.sound_data.wb_hit_ground.play();
							FlxG.shake(0.05, 0.5);
							ctr_cutscene++;
						}
					}
					break;
				case 9:
					fade.alpha += 0.01;
					if (fade.alpha == 1) {
						ctr_cutscene++;
						entity_3.exists = scene_3.exists = false;
					}
					break;
				case 10:
					fade.alpha -= 0.01;
					if (Registry.volume_scale < 1) {
						Registry.volume_scale += 0.01;
					} else {
						Registry.volume_scale = 1;
					}
					Registry.sound_data.current_song.volume = FlxG.volume * Registry.volume_scale;
					if (fade.alpha == 0 && Registry.volume_scale == 1) {
						state = s_transition_out;
						Registry.sound_data.start_song_from_title("WINDMILL");
					}
					break;
				
			}
		}
		
		private function red_out(a:int, b:int):void {
			state = s_done;
			switch (Registry.CURRENT_CUTSCENE) {
				case Cutscene.Red_Cave_Left:
					Registry.CUTSCENES_PLAYED[Cutscene.Red_Cave_Left] = 1; break;
				case Cutscene.Red_Cave_Right:
					Registry.CUTSCENES_PLAYED[Cutscene.Red_Cave_Right] = 1; break;
				case Cutscene.Red_Cave_North:
					Registry.CUTSCENES_PLAYED[Cutscene.Red_Cave_North] = 1; break;
			}
		}
		
		private function red_in(a:int, b:int):void {
			state = s_in_progress;
			Registry.sound_data.red_cave_rise.play();
		}
		
		private function step_red_cave():void {
			//perform the rise effect.
			if (ctr_cutscene == 0) {
				timer -= FlxG.elapsed;
				if (timer < 0) {
					pushdown--;
					pushee.framePixels_y_push = pushdown;
					
					timer = timer_max;
					FlxG.shake(0.05);
					if (pushdown == 0) {
						ctr_cutscene = 1;
						timer = 1.5;
					}
				}
			} else if (ctr_cutscene == 1) {
				timer -= FlxG.elapsed;
				if (timer < 0) {
					ctr_cutscene++;
				}
			} else {
				state = s_transition_out;
			}
		}
		
		
		private function terminal_gate_out(a:int, b:int):void {
			state = s_done;
			switch (Registry.CURRENT_CUTSCENE) {
				case Cutscene.Terminal_Gate_Bedroom:
					Registry.CUTSCENES_PLAYED[Cutscene.Terminal_Gate_Bedroom] = 1; 
					break;
				case Cutscene.Terminal_Gate_Redcave:
					Registry.CUTSCENES_PLAYED[Cutscene.Terminal_Gate_Redcave] = 1; 
					break;
				case Cutscene.Terminal_Gate_Crowd:
					Registry.CUTSCENES_PLAYED[Cutscene.Terminal_Gate_Crowd] = 1; 
					break;
			}
		}
		
		private function terminal_gate_in(a:int, b:int):void {
			state = s_in_progress;
			
		}
		
		private function step_terminal_gate():void {
			var tg:Terminal_Gate = entity_1 as Terminal_Gate;
			switch (Registry.CURRENT_CUTSCENE) {
				case Cutscene.Terminal_Gate_Bedroom:
					tg.gate_bedroom.alpha -= 0.005;
					if (tg.gate_bedroom.alpha == 0) {
						state = s_transition_out;
					}
					break;
				case Cutscene.Terminal_Gate_Redcave:
					tg.gate_redcave.alpha -= 0.005;
					if (tg.gate_redcave.alpha == 0) {
						state = s_transition_out;
					}
					break;
				case Cutscene.Terminal_Gate_Crowd:
					tg.gate_crowd.alpha -= 0.005;
					if (tg.gate_crowd.alpha == 0) {
						state = s_transition_out;
					}
					break;
					
			}
		}
		/**
		 * loads a cutscenes view
		 * @param	map_name The name of the map
		 * @param	tileset the reference to the embedded tileste
		 * @param	gx the top left grid coordinate of the view.
		 * @param	gy see gx
		 * @param	w	width of the view in tiles
		 * @param	h	height ...
		 * @param	off_gx	grid offset for the view to start.
		 * @param	off_gy	 see off_gx
		 * @return 	the requested tilemap for viewin'.
		 */
		public function load_cutscene_view(map_name:String, tileset:Class, gx:int,gy:int, w:int=10,h:int=10,off_gx:int=0,off_gy:int=0):FlxTilemap {	
			var CSV:String = CSV_Data.getMap(map_name);
			var tilemap:FlxTilemap = new FlxTilemap();
			tilemap.loadMap(CSV, tileset, 16, 16);
			var submap_data:Array = new Array();
			for (var i:int = 0; i < w*h; i++) {
				submap_data.push(tilemap.getTile(gx * 10 + (i % w), gy * 10 + (i / h)));
			}
			tilemap.destroy();
			tilemap = new FlxTilemap();
			tilemap.loadMap(FlxTilemap.arrayToCSV(submap_data, 10), tileset, 16, 16);
			tilemap.scrollFactor.x = tilemap.scrollFactor.y = 0;
			tilemap.y = Registry.HEADER_HEIGHT;
			return tilemap;
			
		}
		private function inst_red_cave_left():void {
			add (load_cutscene_view("REDSEA", TileData.Red_Sea_Tiles, 2, 4));
			var ss:Solid_Sprite = new Solid_Sprite(EventScripts.fake_xml("Solid_Sprite","48", "68", "red_cave_r_ss"), true);
			add(ss);
			pushee = ss;
			pushdown = ss.framePixels_y_push = 64;
			var overlay:FlxSprite = new FlxSprite(0, 20, Common_Sprites.redsea_blend);
			overlay.scrollFactor.x = overlay.scrollFactor.y = 0;
			overlay.blend = "hardlight";
			add(overlay);
		}
		
		private function  inst_red_cave_right():void {
			add (load_cutscene_view("REDSEA", TileData.Red_Sea_Tiles, 4, 4));
			var ss:Solid_Sprite = new Solid_Sprite(EventScripts.fake_xml("Solid_Sprite", "48", "68", "red_cave_r_ss"), true);
			add(ss);
			var overlay:FlxSprite = new FlxSprite(0, 20, Common_Sprites.redsea_blend);
			add(overlay);
			overlay.blend = "hardlight";
			overlay.scrollFactor.x = overlay.scrollFactor.y = 0;
			pushee = ss;
			pushdown = ss.framePixels_y_push = 64;
		}
		
		private function  inst_red_cave_north():void {
			add (load_cutscene_view("REDSEA", TileData.Red_Sea_Tiles, 3, 3));
			var ss:Solid_Sprite = new Solid_Sprite(EventScripts.fake_xml("Solid_Sprite", "48", 
		"68", "red_cave_n_ss"), true);
			add(ss);
			pushee = ss;
			
			var overlay:FlxSprite = new FlxSprite(0, 20, Common_Sprites.redsea_blend);
			add(overlay);
			overlay.blend = "hardlight";
			overlay.scrollFactor.x = overlay.scrollFactor.y = 0;
			pushdown = ss.framePixels_y_push = 64;
		}
		
		private function inst_terminal_gate():void {
			add(load_cutscene_view("WINDMILL", TileData.Terminal_Tiles, 0, 2));
			var tg:Terminal_Gate = new Terminal_Gate(EventScripts.fake_xml("Terminal_Gate", "30", "50", "n"), _parent.player, _parent,true);
			var grp:FlxGroup = new FlxGroup();
			grp.add(tg.button);
			grp.add(tg.gate_bedroom);
			grp.add(tg.gate_crowd);
			grp.add(tg.gate_redcave);
			grp.setAll("scrollFactor", new FlxPoint(0, 0));
			add(grp);
			entity_1 = tg;
		}
		
		
		private function inst_windmill():void {
			Registry.CUTSCENES_PLAYED[Cutscene.Windmill_Opening] = 1;
			scene_1 = load_cutscene_view("BEDROOM", TileData._Bedroom_Tiles, 4, 0, 10, 10, 0, 0);
			entity_1 = new FlxSprite(5 * 16, 2 * 16 + 20);
			entity_1.loadGraphic(Dungeon_Statue.statue_bedroom_embed, true, false, 32, 48);
			entity_1.frame = 0;
			
			scene_2 = load_cutscene_view("REDCAVE", TileData.REDCAVE_Tiles, 6, 2, 10, 10, 0, 0);
			entity_2 = new FlxSprite(4 * 16, 4 * 16 + 20);
			entity_2.loadGraphic(Dungeon_Statue.statue_bedroom_embed, true, false, 32, 48);
			entity_2.frame = 1;
			
			scene_3 = load_cutscene_view("CROWD", TileData._Crowd_Tiles, 9, 4, 10, 10);
			entity_3 = new FlxSprite(4 * 16, 2 * 16 + 20);
			entity_3.loadGraphic(Dungeon_Statue.statue_bedroom_embed, true, false, 32, 48);
			entity_3.frame = 2;
			
			fade = new FlxSprite(0, 20);
			fade.makeGraphic(160, 160, 0xff000000);
			fade.alpha = 1;
			
			add(scene_1); add(entity_1);
			add(scene_2); add(entity_2);
			add(scene_3); add(entity_3);
			add(fade);
			
			setAll("scrollFactor", new FlxPoint(0, 0));
			setAll("exists", false);
		}
		
		
		override public function destroy():void 
		
		{
		
			entity_1 = null;
			entity_2 = null;
			entity_3 = null;
			pushee = null;
			tran_in_args = null;
			tran_out_args = null;
			transition_in = null;
			transition_out = null;
			step_cutscene = null;
			scene_1 = null;
			scene_2 = null;
			scene_3 = null;
			
			
			super.destroy();
		}
	}

}

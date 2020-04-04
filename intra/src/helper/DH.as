package helper 
{
	import data.NPC_Data_EN;
	import data.NPC_Data_ES;
	import data.NPC_Data_JP;
	import data.NPC_Data_KR;
	import data.NPC_Data_PT;
	import data.NPC_Data_IT;
	import data.NPC_Data_ZHS;
	import entity.player.Player;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import global.Registry;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import states.DialogueState;
	
	/**
	 * Dialogue Helper (DH)
	 * Contains helper functions to query the Dialogue state object
	 */
	
	public class DH 
	{
		// A copy of the raw dialogue state. Used for updating
		// Dialogue state in patches
		public static var RAW_DIALOGUE_STATE:Object;
		
		public static const name_card:String = "card";
		public static const name_arthur:String = "arthur";
		public static const name_briar:String = "briar";
		public static const name_javiera:String = "javiera";
		public static const name_mitra:String = "mitra";
		public static const name_sage:String = "sage";
		public static const name_statue:String = "statue";
		public static const name_test:String = "test";	
		public static const name_sun_guy:String = "sun_guy";
		public static const name_rock:String = "rock";
		public static const name_sadbro:String = "sadbro";
		public static const name_dungeon_statue:String = "dungeon_statue";
		public static const name_splitboss:String = "splitboss";
		public static const name_wallboss:String = "wallboss";
		public static const name_eyeboss:String = "eyeboss";
		public static const name_redboss:String = "redboss";
		public static const name_circus_folks:String = "circus_folks";
		public static const name_suburb_walker:String = "suburb_walker";
		public static const name_suburb_blocker:String = "suburb_blocker";
		public static const name_cube_king:String = "cube_king";
		public static const name_cliff_dog:String = "cliff_dog";
		public static const name_generic_npc:String = "generic_npc";
		public static const name_forest_npc:String = "forest_npc";
		public static const name_geoms:String = "geoms";
		public static const name_miao:String = "miao";
		public static const name_shopkeeper:String = "shopkeeper";
		public static const name_goldman:String = "goldman";
		public static const name_happy_npc:String = "happy_npc";
		
		// For card popups, treasure dialogs
		public static var area_etc:String = "ETC";
		
		
		
		public static var scene_arthur_circus_alone:String = "alone";
		
		public static var scene_briar_go_before_fight:String = "before_fight";
		public static var scene_briar_go_after_fight:String = "after_fight";
		
		
		public static var scene_card_one:String = "one";
		
		public static var scene_cliff_dog_top_left:String = "top_left";
		
		public static var scene_dungeon_statue_bedroom_one:String = "one";
		public static var scene_dungeon_statue_bedroom_two:String = "two";
		
		public static var scene_forest_npc_bunny:String = "bunny";
		public static var scene_forest_npc_thorax:String = "thorax";
		
		public static var scene_snowman_one:String = "one";
		
		public static var scene_goldman_etc:String = "etc";
		public static var scene_goldman_inside:String = "inside";
		public static var scene_goldman_outside:String = "outside";
		
		public static var scene_generic_npc_any_quest_normal:String =  "quest_normal";
		public static var scene_generic_npc_any_second:String =  "second";
		public static var scene_generic_npc_any_first:String =  "first";
		public static var scene_generic_npc_any_quest_event:String = "quest_event";
		public static var scene_generic_npc_any_easter_egg:String = "easter_egg";
		public static var scene_rank_bush:String = "bush";

		public static var scene_happy_npc_beautiful:String = "beautiful";
		public static var scene_happy_npc_drink:String = "drink";
		public static var scene_happy_npc_hot:String = "hot";
		public static var scene_happy_npc_dump:String = "dump";
		public static var scene_happy_npc_gold:String = "gold";
		public static var scene_happy_npc_briar:String = "briar";
		
		public static var scene_javiera_circus_alone:String = "alone";

		public static var scene_miao_init:String = "init";
		public static var scene_miao_randoms:String = "randoms";
		public static var scene_miao_philosophy:String = "philosophy";
		
		public static var scene_mitra_overworld_initial_overworld:String = "initial_overworld";
		public static var scene_mitra_blue_one:String = "one";
		public static var scene_mitra_fields_init:String = "init";
		public static var scene_mitra_fields_game_hints:String = "game_hints";
		public static var scene_mitra_fields_card_hints:String = "card_hints";
		public static var scene_mitra_fields_general_banter:String = "general_banter";
		public static var scene_mitra_fields_quest_event:String = "quest_event";
		
		public static var scene_rock_one:String = "one";
		public static var scene_rock_two:String = "two";
		public static var scene_rock_three:String = "three";
		public static var scene_rock_four:String = "four";
		public static var scene_rock_five:String = "five";
		public static var scene_rock_six:String = "six";
		
		public static var scene_shopkeeper_init:String = "init";
		
		public static var scene_suburb_walker_words_adult:String = "words_adult";
		public static var scene_suburb_walker_words_teen:String = "words_teen";
		public static var scene_suburb_walker_words_kid:String = "words_kid";
		public static var scene_suburb_walker_family:String = "family";
		public static var scene_suburb_walker_hanged:String = "hanged";
		public static var scene_suburb_walker_festive:String = "festive";
		public static var scene_suburb_walker_paranoid:String = "paranoid";
		public static var scene_suburb_walker_dead:String = "dead";
		public static var scene_suburb_walker_older_kid:String = "older_kid";
		
		public static const scene_suburb_blocker_one:String = "one";
		
		public static var scene_sadbro_overworld_initial_forced:String = "initial_forced";
		public static var scene_sadbro_overworld_bedroom_done:String = "bedroom_done";
		public static var scene_sadbro_overworld_bedroom_not_done:String = "bedroom_not_done";
		
		public static var scene_sage_blank_intro:String = "intro";
		public static var scene_sage_nexus_enter_nexus:String = "enter_nexus";
		public static var scene_sage_nexus_after_ent_str:String = "after_ent_str";
		public static var scene_sage_nexus_after_bed:String = "after_bed";
		public static var scene_sage_nexus_before_windmill:String = "before_windmill";
		public static var scene_sage_nexus_after_windmill:String = "after_windmill";
		public static var scene_sage_nexus_all_card_first:String = "all_card_first";
		public static var scene_sage_overworld_bedroom_entrance:String = "bedroom_entrance";
		public static var scene_sage_bedroom_after_boss:String = "after_boss";
		public static var scene_sage_redcave_one:String = "one";
		public static var scene_sage_crowd_one:String = "one";
		public static var scene_sage_terminal_before_fight:String = "before_fight";
		public static var scene_sage_terminal_after_fight:String = "after_fight";
		public static var scene_sage_terminal_entrance:String = "entrance";
		public static var scene_sage_terminal_etc:String = "etc";
		public static var scene_sage_happy_posthappy_sage:String = "posthappy_sage";
		public static var scene_sage_happy_posthappy_mitra:String = "posthappy_mitra";
		
		public static var scene_splitboss_before_fight:String = "before_fight";
		public static var scene_splitboss_after_fight:String = "after_fight";
		
		public static var scene_redboss_before_fight:String = "before_fight";
		public static var scene_redboss_after_fight:String = "after_fight";
		
		public static var scene_eyeboss_before_fight:String = "before_fight";
		public static var scene_eyeboss_after_fight:String = "after_fight";
		
		public static var scene_wallboss_before_fight:String = "before_fight";
		public static var scene_wallboss_after_fight:String = "after_fight";
		
		public static var scene_circus_folks_before_fight:String = "before_fight";
		public static var scene_circus_folks_after_fight:String = "after_fight";
		
		public static var scene_sun_guy_before_fight:String = "before_fight";
		public static var scene_sun_guy_after_fight:String = "after_fight";
		
		public static var scene_statue_nexus_enter_nexus:String = "enter_nexus";
		public static var scene_statue_bedroom_after_boss:String =  "after_boss";
		public static var scene_statue_overworld_bedroom_entrance:String =  "bedroom_entrance";
		
		public static var scene_cube_king_space_color:String = "color";
		public static var scene_cube_king_space_gray:String = "gray";
		
		public static var scene_geoms_space_color:String = "color";
		public static var scene_geoms_space_gray:String = "gray";
		
		
		public static var scene_test_debug_scene_1:String = "scene_1";
		
		private static var property_resettable:String = "does_reset";
		
		private static var scenes_to_reset_on_map_change:Array = new Array();
		private static var current_active_scene:Object;
		private static var current_active_dialogue:Array;
		/**
		 * Whether or not a chunk of dialogue has finished playing. Reset whenever
		 * a new chunk is fetched.
		 */
		private static var recently_finished_chunk:Boolean = false;
		private static var chunk_is_playing:Boolean = false;
		private static var most_recently_played_chunk_pos:int;
		
		
		/**
		 * Start a dialogue popup given the parameters. Increments the chosen scene's pos parameter, 
		 * or loops it to its loop point. Marks this scene as dirty (i.e., "read at least once").
		 * @param	name	The name of the npc. Use constants in DH.as when you can - DH.name_sage, etc.
		 * @param	scene	The name of the scene. Use constants in DH.as when you can - DH.scene_sage_blank_intro, etc.
		 * @param	area	What map this occurs in. Defaults to current player's map.
		 * @param	pos	 which dialogue to show. If -1, reads the next one and increments the position state. Otherwise returns the requested chunk
		 * @param has_alternate Whether this NPC has altenrate text based on state from helper.S_NPC.as
		 * @return	true on success (read a dialogue chunk), crash the game otherwise
		 */
		public static function start_dialogue(name:String, scene:String, _area:String = "", pos:int = -1,has_alternate:Boolean=false):Boolean {
			if (true == a_chunk_is_playing() || (Registry.GAMESTATE != null && Registry.GAMESTATE.dialogue_latency > 0)) {
				return false;
			}
			recently_finished_chunk = false;
			
			// Maybe get an alternate text.
			if (has_alternate == true) {
				// S_NPC.something...
			}
			// Grab the area of the dialogue to take place
			var area:String = (_area == "") ? Registry.CURRENT_MAP_NAME : _area;
			
			// Grab the scene associated with this area
			var cur_scene_state:Object = Registry.DIALOGUE_STATE[name][area][scene];
			var cur_scene_dialogue:Array = Registry.DIALOGUE[name][area][scene].dialogue;
			cur_scene_state.dirty = true;
			
			// Make the box at top or bottom
			if (cur_scene_state.hasOwnProperty("top")) {
				DialogueState.set_dialogue_box_align(FlxObject.UP);
			} else {
				DialogueState.set_dialogue_box_align(FlxObject.DOWN);
			}
			
			
			// Grab the dialogue chunk, if we hit the end, loop, otherwise increment position counter
			if (pos == -1) {
				most_recently_played_chunk_pos = cur_scene_state.pos;
				Registry.cur_dialogue = cur_scene_dialogue[cur_scene_state.pos];
				if (cur_scene_state.pos == cur_scene_dialogue.length - 1) {
					cur_scene_state.pos = cur_scene_state.loop;
				} else {
					cur_scene_state.pos++;
				}
			} else {
				most_recently_played_chunk_pos = pos;
				Registry.cur_dialogue = cur_scene_dialogue[pos];
			}
			
			
		
			// If resettable, add its reference to list of references to reset dialogue position on map change
			if (Registry.DIALOGUE_STATE[name].hasOwnProperty(property_resettable) && Registry.DIALOGUE_STATE[name][property_resettable]) {
				scenes_to_reset_on_map_change.push(cur_scene_state);
			}
			
			
			if (Registry.GAMESTATE != null) {
				Registry.GAMESTATE.load_dialogue = true;
			}
			current_active_scene = cur_scene_state;
			current_active_dialogue = cur_scene_dialogue;
			chunk_is_playing = true;
			return true;
		}
		
		public static function dialogue_popup_misc_any(scene:String, pos:int):void {
			dialogue_popup(DH.lookup_string("misc", "any", scene, pos));
		}
		/**
		 * Make a dialogue popup with 'words'.
		 * @param	words
		 */
		public static function dialogue_popup(words:String):void {
			Registry.cur_dialogue = words;
			Registry.GAMESTATE.load_dialogue = true;
		
		}
		/**
		 * Get the dialogue position in a given scene.
		 * @param	name
		 * @param	scene
		 * @param	_area
		 * @return an integer >= 0 denoting the position, or -1 if not found
		 */
		public static function get_scene_position(name:String, scene:String, _area:String = ""):int {
			_area = (_area == "") ? Registry.CURRENT_MAP_NAME : _area;
			return Registry.DIALOGUE_STATE[name][_area][scene].pos;	
		}
		
		/**
		 * Check if the scene had any dialogue started at any point in time. Useful if you don't want to add in
		 * another boolean to wherever the dialogue is being played from, and the call originally sits in a block
		 * that is iterated over.
		 * @param	name
		 * @param	scene
		 * @param	_area
		 * @return
		 */
		public static function scene_is_dirty(name:String, scene:String, _area:String = ""):Boolean {
			_area = (_area == "") ? Registry.CURRENT_MAP_NAME : _area;
			return Registry.DIALOGUE_STATE[name][_area][scene].dirty;	
		}
		
		/**
		 * Check if the scene has finished completely. Useful for say, boss intro dialogue which blocks scripting of an intro sequence
		 * @param	name
		 * @param	scene
		 * @param	_area
		 * @return
		 */
		public static function scene_is_finished(name:String, scene:String, _area:String = ""):Boolean {
			_area = (_area == "") ? Registry.CURRENT_MAP_NAME : _area;
			return Registry.DIALOGUE_STATE[name][_area][scene].finished;	
		}
		
		/**
		 * Updates current scene to be "finished" if all dialogue is played from that scene.
		 * Also sets "recently_finished_chunk" to true, and "chunk_is_playing" to false;
		 */
		public static function update_current_scene_on_chunk_finish():void {
			if (current_active_scene == null) return;
			if (most_recently_played_chunk_pos == current_active_dialogue.length - 1) {
				current_active_scene.finished = true;
			}
			current_active_dialogue = null;
			current_active_scene = null;
			recently_finished_chunk = true;
			chunk_is_playing = false;
		}
		
		public static function get_scene_length(name:String, scene:String, _area:String = ""):int {
			_area = (_area == "") ? Registry.CURRENT_MAP_NAME : _area;
			
			return Registry.DIALOGUE[name][_area][scene].dialogue.length;
		}
		/**
		 * Called when transitioning out of a Roam or Playstate.
		 */
		public static function reset_scenes_on_map_change():void {
			while (scenes_to_reset_on_map_change.length > 0) {
				var scene:Object = scenes_to_reset_on_map_change.pop() as Object;
				scene.pos = 0;
			}
		}
		
		public static function a_chunk_just_finished():Boolean {
			if (recently_finished_chunk) {
				recently_finished_chunk = false;
				return true;
			}
			return false;
		}
		public static function dont_need_recently_finished():void {
			recently_finished_chunk = false;
		}
		
		public static function a_chunk_is_playing():Boolean {
			return chunk_is_playing;
		}
		
		/**
		 * Fill Registry.DIALOGUE with all the game's dialogue, make a copy of the initial dialogue state
		 * into Registry.DIALOGUE_STATE
		 */
		public static function init_dialogue_state(only_change_dialogue:Boolean=false):void {
			
			Registry.DIALOGUE = { };
			var varList:XMLList = null;
			if (language_type == LANG_ja) {
				
				varList = describeType(NPC_Data_JP)..variable;
			} else if (language_type == LANG_ko) {
				varList = describeType(NPC_Data_KR)..variable;
			} else if (language_type == LANG_es) {
				varList = describeType(NPC_Data_ES)..variable;
			} else if (language_type == LANG_it) {
				varList = describeType(NPC_Data_IT)..variable;
			} else if (language_type == LANG_pt) {
				varList = describeType(NPC_Data_PT)..variable;
			} else if (language_type == LANG_zhs) {
				varList = describeType(NPC_Data_ZHS)..variable;
			} else {
				varList = describeType(NPC_Data_EN)..variable;
			}
			var d:Object = { };
			for (var i:int = 0; i < varList.length(); i++) {
				if (varList[i].@name.toXMLString().indexOf("_state") == -1) {
					if (language_type == LANG_ja) {
						Registry.DIALOGUE[varList[i].@name] = NPC_Data_JP[varList[i].@name];
					} else if (language_type == LANG_ko) {
						Registry.DIALOGUE[varList[i].@name] = NPC_Data_KR[varList[i].@name];
					} else if (language_type == LANG_es) {
						Registry.DIALOGUE[varList[i].@name] = NPC_Data_ES[varList[i].@name];
					} else if (language_type == LANG_it) {
						Registry.DIALOGUE[varList[i].@name] = NPC_Data_IT[varList[i].@name];
					} else if (language_type == LANG_pt) {
						Registry.DIALOGUE[varList[i].@name] = NPC_Data_PT[varList[i].@name];
					} else if (language_type == LANG_zhs) {
						Registry.DIALOGUE[varList[i].@name] = NPC_Data_ZHS[varList[i].@name];
					} else {
						Registry.DIALOGUE[varList[i].@name] = NPC_Data_EN[varList[i].@name];
					}
				} else { // Add the bob npc object state, with all of its areas and scenes
					if (language_type == LANG_ja) {
						d[varList[i].@name.toXMLString().split("_state")[0]] = NPC_Data_JP[varList[i].@name];
					} else if (language_type == LANG_ko) {
						d[varList[i].@name.toXMLString().split("_state")[0]] = NPC_Data_KR[varList[i].@name];
					} else if (language_type == LANG_pt) {
						d[varList[i].@name.toXMLString().split("_state")[0]] = NPC_Data_PT[varList[i].@name];
					} else if (language_type == LANG_es) {
						d[varList[i].@name.toXMLString().split("_state")[0]] = NPC_Data_ES[varList[i].@name];
					} else if (language_type == LANG_it) {
						d[varList[i].@name.toXMLString().split("_state")[0]] = NPC_Data_IT[varList[i].@name];
					} else if (language_type == LANG_zhs) {
						d[varList[i].@name.toXMLString().split("_state")[0]] = NPC_Data_ZHS[varList[i].@name];
					} else {
						d[varList[i].@name.toXMLString().split("_state")[0]] = NPC_Data_EN[varList[i].@name];
					}
				}
			}
			
			if (false == only_change_dialogue) {
				var myBA:ByteArray = new ByteArray();
				myBA.writeObject(d);
				myBA.position = 0;
				// dialogue state doesnt hold any "dialogue" just state
				Registry.DIALOGUE_STATE = myBA.readObject();
				myBA.position = 0;
				RAW_DIALOGUE_STATE = myBA.readObject();
			}
			
		}
		
		public static function isZH():Boolean {
			if (language_type == LANG_zhs) return true;
			return false;
		}
		
		public static var language_type:String = "en";
		public static const LANG_en:String = "en";
		public static const LANG_ja:String = "ja";
		public static const LANG_ko:String = "ko";
		public static const LANG_es:String = "es";
		public static const LANG_pt:String = "pt";
		public static const LANG_zhs:String = "zh-CN";
		public static const LANG_it:String = "it";
		public static function set_language(lang_string:String):void {
			if (lang_string == LANG_ja) {
				trace("Japanese Language set.");
					DialogueState.Max_Line_Size = 18;
				language_type = LANG_ja;
			} else if (lang_string == LANG_ko) {
				trace("Korean language set.");
				DialogueState.Max_Line_Size = 18;
				language_type = LANG_ko;
			} else if (lang_string == LANG_es) {
				trace("Spanish language set.");
				DialogueState.Max_Line_Size = 24;
				language_type = LANG_es;
			} else if (lang_string == LANG_it) {
				trace("Italian language set.");
				DialogueState.Max_Line_Size = 24;
				language_type = LANG_it;
			} else if (lang_string == LANG_pt) {
				trace("pt-br language set.");
				DialogueState.Max_Line_Size = 24;
				language_type = LANG_pt;
			} else if (lang_string == LANG_zhs || lang_string == "zh" || lang_string == "zh-TW") {
				trace("zh-CN langage set.");
				DialogueState.Max_Line_Size = 13;
				language_type = LANG_zhs;
			} else {
				trace("English Language set.");
				language_type = LANG_en;
					DialogueState.Max_Line_Size = 21;
			}
			// When called a 2nd time in game or after loading or whatever
			if (Registry.PLAYSTATE != null && Registry.PLAYSTATE.dialogue_state != null) {
				Registry.PLAYSTATE.dialogue_state.create_bitmap_text();
			}
			
			// Change the pointer to the new object but don't update the state.
			init_dialogue_state(true);
			
			// Update these strings after re-initializing dialogue state
			if (Registry.PLAYSTATE != null && Registry.PLAYSTATE.pause_state != null) {
				Registry.PLAYSTATE.pause_state.set_pausemenu_labels();
			}
			
		}
		// Patches the save file's dialogue state
		// with the raw dialogue state.
		// Useful if we add an NPC or somethin' .
		public static function patch_dialogue_state():void {
			var debug:Boolean = false;
			var npc_ctr:int = 0;
			var area_ctr:int = 0;
			var scene_ctr:int = 0;			
			if (debug) trace("Patching dialogue state.");

			for (var npc:String in RAW_DIALOGUE_STATE) {
				npc_ctr++;
				// If the save file already has this NPC then we need to check its areas
				if (Registry.DIALOGUE_STATE.hasOwnProperty(npc)) {
					// Check the NPC's areas.
					for (var area:String in RAW_DIALOGUE_STATE[npc]) {
						area_ctr++;
						if (area == "does_reset") continue;
						// Check its scenes.
						if (Registry.DIALOGUE_STATE[npc].hasOwnProperty(area)) {
							for (var scene:String in RAW_DIALOGUE_STATE[npc][area]) {
								scene_ctr++;
								// If this scene exists, just update its loop property
								if (Registry.DIALOGUE_STATE[npc][area].hasOwnProperty(scene)) {
									Registry.DIALOGUE_STATE[npc][area][scene]["loop"] = RAW_DIALOGUE_STATE[npc][area][scene]["loop"] 
									if (RAW_DIALOGUE_STATE[npc][area][scene].hasOwnProperty("top")) {
										Registry.DIALOGUE_STATE[npc][area][scene]["top"] = true;
									}
								} else {
									if (debug)  trace("New scene: " + scene + " , " + area + " , " + npc)
									Registry.DIALOGUE_STATE[npc][area][scene] = RAW_DIALOGUE_STATE[npc][area][scene];
								}
							}
						} else {
							if (debug) trace("New Area: " + area+" , "+npc);
							Registry.DIALOGUE_STATE[npc][area] = RAW_DIALOGUE_STATE[npc][area];
						}
					}
				// Otherwise just add it in!
				} else {
					if (debug)  trace("New NPC: " + npc);
					Registry.DIALOGUE_STATE[npc] = RAW_DIALOGUE_STATE[npc];
				}
			}
			
			if (debug) trace("And now for # of things we had to check...");
			if (debug) trace("NPCs: " + npc_ctr.toString() + " Areas: " + area_ctr.toString() + " scenes: " + scene_ctr.toString());
		}
		
		/**
		 * Increments an integer property on this ENTIRE NPC by one 
		 * Creates the property if it doesn't exist, inits to 1.
		 * @return 1 if property exists, 0 otherswise
		 */
		public static function increment_property(name:String,property:String):int {
			if (!Registry.DIALOGUE_STATE[name].hasOwnProperty(property)) {
				Registry.DIALOGUE_STATE[name][property] = 1;
				
			} else {
				Registry.DIALOGUE_STATE[name][property]++;
				return 1;
			}
			return 0;
		}
		
		/**
		 * Get an integer property of the NPC ENTIRE NPC
		 * @param	name
		 * @param	property
		 * @return
		 */
		public static function get_int_property(name:String, property:String):int {
			if (Registry.DIALOGUE_STATE[name].hasOwnProperty(property)) {
				return Registry.DIALOGUE_STATE[name][property];
			} 
			return -1;
			
		}
		
		public static function enable_menu():void {
			Registry.disable_menu = false;
		}
		public static function disable_menu():void {
			Registry.disable_menu = true;
		}
		
		/**
		 * Specify what chunk of dialogue to play next, by the "pos" var
		 * @param	pos
		 * @return the new position in this scene, or -1 if current scene null
		 */
		  
		public static function set_scene_to_pos(name:String,scene:String,pos:int):int {
			if (Registry.DIALOGUE_STATE[name][Registry.CURRENT_MAP_NAME][scene] == null) return -1;
			
			Registry.DIALOGUE_STATE[name][Registry.CURRENT_MAP_NAME][scene].pos = pos;
			return pos;
		}
		
		/**
		 * Set pos to the last chunk of dialogue.
		 * @param	pos
		 * @return the new position in this scene, or  or -1 if current scene null
		 */
		public static function set_scene_to_end(name:String,scene:String):int {
			if (Registry.DIALOGUE_STATE[name][Registry.CURRENT_MAP_NAME][scene] == null) return -1;
			
			var new_pos:int =  Registry.DIALOGUE[name][Registry.CURRENT_MAP_NAME][scene].dialogue.length - 1; 
			Registry.DIALOGUE_STATE[name][Registry.CURRENT_MAP_NAME][scene].pos = new_pos;
			return new_pos;
		}
		
		/**
		 * Macro: "Normal Condition" Does the conditional checks for entering a dialogue, covers 95% of cases
		 * @param	p - player reference
		 * @param	ar - active region of the sprites talking to
		 * @return whether to talk or not
		 */
		public static function nc(player:Player, active_region:FlxObject):Boolean {
			if (player.overlaps(active_region) && DH.a_chunk_is_playing() == false && player.state == player.S_GROUND && Registry.keywatch.JP_ACTION_1) {
				player.be_idle();
				return true;
			}
			return false;
		}
		
		public static function lookup_string(name:String, map:String, scene:String, pos:int):String {
			var retval:String = Registry.DIALOGUE[name][map][scene].dialogue[pos];
			return retval;
		}
		
		public static function lk(scene:String, pos:int):String {
			var retval:String = Registry.DIALOGUE["misc"]["any"][scene].dialogue[pos];
			return retval;
		}
	}

}
package  
{
	import entity.gadget.Door;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import helper.DH;
	import helper.S_NPC;
	import org.flixel.FlxG;
	import org.flixel.FlxSave;
    import global.Registry;
	import states.MinimapState;
    
    public class Save {
        
        private static var _save:FlxSave;
        private static var _load:FlxSave;
        
		/**
		 * Copy source to destination
		 * @param	source
		 * @param	destination
		 */
		private static function copy(source:Object, destination:Object):void {
			var ba:ByteArray = new ByteArray();
			ba.writeObject(source);
			ba.position = 0;
			destination = ba.readObject();
		}
        public static function save():Boolean {
            _save = new FlxSave();
            var canSave:Boolean = _save.bind(Registry.SAVE_NAME);
            if (canSave) {
                _save.data.valid = "yes";
				_save.data.READ_THIS_IF_MODIFYING = "HEY! Be careful modifying this! Don't say I didn't warn you...";
				/* I 'new' these because otherwise we store references, it's possible the
				 * player saves the game, does stuff, quits, and the stuff done after
				 * the save is still reflected in the save...*/
                _save.data.stateful =  new XML(Registry.statefulXML);
                _save.data.stateless = new XML(Registry.statelessXML);
				_save.data.controls = duplicate_array(new Array(), Registry.controls);
				//respawn point for reloading the game
				_save.data.bowlofcereal = Registry.death_count;
				_save.data.squirrel = Registry.nr_growths;
				_save.data.applegouda = duplicate_array(new Array(), Registry.inventory);
				_save.data.spam = duplicate_array(new Array(), Registry.nr_keys);
				_save.data.fffeeffe = Registry.bound_item_1;
				_save.data.fkkekee = Registry.bound_item_2;
				_save.data.effect = Registry.bound_effect;
				_save.data.booklesporf = Registry.MAX_HEALTH;
				_save.data.conga = Registry.CUR_HEALTH;
				_save.data.playtime = Registry.playtime;
				_save.data.fjfjejfwe = duplicate_array(new Array(), Registry.CUTSCENES_PLAYED);
				_save.data.papertowel = Registry.Event_Nr_Red_Pillars_Broken;
				//what "general events" have happened
				_save.data.hooooops = duplicate_array(new Array(), Registry.GE_States);
				//what "big doors" are open
				_save.data.Big_Door_State = duplicate_array(new Array(), Registry.Big_Door_State);
				_save.data.flamingo = duplicate_array(new Array(), Registry.Nexus_Door_State);
				_save.data.minimap_strings = duplicate_array(new Array(), MinimapState.minimap_strings);
				_save.data.autosave_on = Registry.autosave_on;
				_save.data.rosemary = duplicate_array(new Array(), Registry.card_states);
				_save.data.s_npc_states = duplicate_array(new Array(), S_NPC.states);
				_save.data.scale_factor = Intra.scale_factor;
				_save.data.scale_ctr = Intra.scale_ctr;
				
				_save.data.dirty = "y";
				_save.data.frame_x_px = Intra.frame_x_px;
				_save.data.frame_y_px = Intra.frame_y_px;
				
				var ba:ByteArray = new ByteArray();
				ba.writeObject(Registry.checkpoint);
				ba.position = 0;
				_save.data.aaaaaaaaaaa = ba.readObject();
				
				trace("Saving checkpoint: ",_save.data.aaaaaaaaaaa.x, _save.data.aaaaaaaaaaa.y, _save.data.aaaaaaaaaaa.area);
				
				//var o:Object = Registry.checkpoint;
				//var o1:Object = _save.data.checkpoint;
				// Copy current dialogue state into the save file
				ba.clear();
				ba.writeObject(Registry.DIALOGUE_STATE);
				ba.position = 0;
			
				_save.data.aaaaaaaaaaaaaaaaaaaa = ba.readObject();
            }
			if (canSave) {
				canSave = _save.close(500000);
				trace("Writing to disk...success:", canSave);
				if (canSave == false) {
					canSave = _save.close(500000);
					trace("Trying again after request...",canSave);
				}
				
				
				// Make backup
				if (false == Intra.is_web) {
					//var f:File;
					//var of:File;
					//var fs:FileStream = new FileStream(); 
					//var ofs:FileStream = new FileStream(); 
					//f = new File(File.applicationStorageDirectory.nativePath + File.separator + "#SharedObjects" + File.separator + "Anodyne.swf" + File.separator + Registry.SAVE_NAME + ".sol");
					//var fr:FileReference = new FileReference;
					//try {
						//f.copyTo(new File(File.userDirectory.nativePath + File.separator + "Anodyne" + File.separator + Registry.SAVE_NAME + ".sol"), true); 
					//} catch (error:IOErrorEvent) {
						//trace ( " Error copying file");
					//}
					//
					
					
			
					//trace(f.nativePath);
					//fs.open(f, FileMode.READ);
					//
					//of = new File(File.userDirectory.nativePath + File.separator + "Anodyne" + File.separator + Registry.SAVE_NAME+".sol");
					//ofs.open(of, FileMode.WRITE);
					//var mysave:Object = 
					//
					//ba.position = 0;
					//var nrtowrite:int = fs.bytesAvailable - fs.position;
					//fs.readBytes(ba, 0, fs.bytesAvailable - fs.position);
					//ba.position = 0;
					//ofs.writeBytes(ba, 0, nrtowrite);
					//
					//ofs.close();
					//fs.close();
					
					
					//f = new File(File.userDirectory.nativePath + File.separator + "Anodyne" + File.separator + "README.txt");
					//try {
						//fs.open(f, FileMode.WRITE);
						//fs.writeObject("Hey, this is a backup save file because saves are loaded from temporary storage, possibly cleared by a browser. It gets copied to where saves are read from automatically, so you shouldn't have to worry about anything!");
						//fs.close();
					//} catch (error:IOErrorEvent) {
						//trace (" Error opening or closing or writing README file");
					//} catch (sec_error:SecurityError) {
						//trace ( "eror with file permssions sry");
					//}
					
				}	
				
			} else {
				trace("saving failed");
			}
			return canSave;
			
        }
        
		public static function duplicate_array(next:Array, old:Array, ref:Array = null):Array {
			if (ref != null && old != null) {
				if (ref[0] === false) {
					if (old.length < ref.length) {
						trace("Array with falses in save was shorter than in disk");
						for (var j:int = old.length; j < ref.length; j++) {
							old.push(false);
						}
					}
				} else if (ref[0] === 0 || ref[0] === 1) {
					if (old.length < ref.length) {
						trace("Array with 0sr in save was shorter than in disk");
						for (j = old.length; j < ref.length; j++) {
							old.push(0);
						}
					}
				} else {
					
				}
			}
			if (old == null) return new Array(false, false, false, false);
			for (var i:int = 0; i < old.length; i++) {
				next.push(old[i]);
			}
			return next;
		}
		
		
        public static function load(only_for_dirty:Boolean=false):Boolean {
            _load = new FlxSave();
			trace("Loading save file \"", Registry.SAVE_NAME,"\"");
            var canLoad:Boolean = _load.bind(Registry.SAVE_NAME);
			
			if (_load.data.dirty == "y") {
				Intra.did_window_config = true;
				Intra.frame_x_px = _load.data.frame_x_px;
				Intra.frame_y_px = _load.data.	frame_y_px;
				Registry.GE_States[Registry.GE_MOBILE_IS_RHAND] = _load.data.hooooops[Registry.GE_MOBILE_IS_RHAND];
				Registry.GE_States[Registry.GE_MOBILE_IS_XC] = _load.data.hooooops[Registry.GE_MOBILE_IS_XC];
				if (only_for_dirty) return true;
			}
			
			// If the load is not dirty then check if it was deleted and
			//thus we have the save in the backup dir
			
			//if (_load.data.dirty != "y") {
				//var f:File = new File(File.userDirectory.nativePath + File.separator + "Anodyne" + File.separator + Registry.SAVE_NAME + ".sol");
				//if (f.exists == true) {
					//trace("Restoring backup...");
					//f.copyTo(new File(File.applicationStorageDirectory.nativePath + File.separator + "#SharedObjects" + File.separator + "Anodyne.swf" + File.separator + Registry.SAVE_NAME + ".sol"), true);
					//
					//_load = new FlxSave();
					//_load.bind(Registry.SAVE_NAME);
					//_load.close(500000);
					//_load.bind(Registry.SAVE_NAME);
				//}
			//}
			//
            if (_load.data.valid == "yes") {
				Registry.patch_xml(_load);
				Registry.death_count = _load.data.bowlofcereal;
				Registry.bound_effect = _load.data.effect;
                Registry.statefulXML = new XML(_load.data.stateful);
                Registry.statelessXML = new XML(_load.data.stateless);
				Registry.playtime = _load.data.playtime;
				Registry.controls = duplicate_array(new Array(), _load.data.controls);
				Registry.nr_growths = _load.data.squirrel;
				Registry.inventory = duplicate_array(new Array(), _load.data.applegouda,Registry.inventory);
				Registry.nr_keys = duplicate_array(new Array(), _load.data.spam);
				Registry.bound_item_1 = _load.data.fffeeffe;
				Registry.bound_item_2 = _load.data.fkkekee;
				Registry.CUR_HEALTH = _load.data.conga;
				Registry.MAX_HEALTH = _load.data.booklesporf;
				Registry.CUTSCENES_PLAYED = duplicate_array(new Array(), _load.data.fjfjejfwe,Registry.CUTSCENES_PLAYED);
				Registry.Event_Nr_Red_Pillars_Broken = _load.data.papertowel;
				Registry.GE_States = duplicate_array(new Array(), _load.data.hooooops,Registry.GE_States);
				Registry.Big_Door_State = duplicate_array(new Array(), _load.data.Big_Door_State);
				Registry.Nexus_Door_State = duplicate_array(new Array(), _load.data.flamingo);
				Registry.Nexus_Door_State[1] = true;
				Registry.autosave_on = _load.data.autosave_on;
				S_NPC.states = duplicate_array(new Array(), _load.data.s_npc_states,S_NPC.states);
				
				MinimapState.minimap_strings = duplicate_array(new Array(), _load.data.minimap_strings);
				Registry.card_states = duplicate_array(new Array(), _load.data.rosemary,Registry.card_states);
				
				Intra.scale_ctr = (_load.data.scale_ctr - 1) % 3;
				Intra.scale_factor = _load.data.scale_factor;
				if (Intra.scale_factor <= 0) Intra.scale_factor = 3;
				Intra.force_scale = true;
			
				//copy(_load.data.checkpoint, Registry.checkpoint);
				//var o1:Object = _load.data.checkpoint;
				//var o:Object = Registry.checkpoint;
				
				// Copy dialogue from save file into current dialogue state
				var ba:ByteArray = new ByteArray();
				ba.writeObject(_load.data.aaaaaaaaaaa);
				ba.position = 0;
				Registry.checkpoint = ba.readObject();
				trace("Loading checkpoint from disk:", Registry.checkpoint.x, Registry.checkpoint.y, Registry.checkpoint.area);
				ba.clear();
				ba.writeObject(_load.data.aaaaaaaaaaaaaaaaaaaa);
				ba.position = 0;
				Registry.DIALOGUE_STATE = ba.readObject();
				// If the game has new dialogue states, add them to the save file's.
				DH.patch_dialogue_state(); 
				
            }
			else { canLoad = false; }
			if (canLoad) {
				canLoad = _load.close(500000);
				trace("Closing loaded file...", canLoad);
			} else {
				trace("loading failed");
			}
			return canLoad;
        }
        
        public static function delete_save():Boolean {
            _save = new FlxSave();
            var canDelete:Boolean = _save.bind(Registry.SAVE_NAME);
            if (canDelete) {
				trace("Deleting data");
                _save.data.valid = "no";
				_save.data.scale_factor = 0;
				_save.data.scale_ctr = 0;
				
				Registry.death_count = 0;
				Registry.controls = Registry.default_controls;
				Registry.nr_growths = 0;
				Registry.bound_effect = "none";
				Registry.bound_item_1 = "";
				Registry.bound_item_2 = "";
				Registry.playtime = 0;
				Registry.nr_keys = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0);
				Registry.inventory = new Array(false, false, false, false, false, false,false,false,false,false,false,false, false,false,false,false,false,false,false); 
				Registry.GE_States = new Array(
				false, false, false, false, false, false, false, false, false, false,
				false, false, false, false, false, false, false, false, false, false,
				false, false, false, false, false, false, false, false, false, false,
				false, false, false, false, false, false, false, false, false, false);
				Registry.CUTSCENES_PLAYED = new Array(0, 0, 0, 0, 0, 0,0,0,0,0,0);
				Registry.Event_Nr_Red_Pillars_Broken =  0;
				Registry.CUR_HEALTH = Registry.MAX_HEALTH = 6;
				Registry.Big_Door_State = new Array(false, false, false, false, false, false, false, false, false, false);
				Registry.Nexus_Door_State = new Array(false, true, false, false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false);
				Registry.autosave_on = true;
				Registry.card_states = new Array(
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 0, 0, 0);
				
				S_NPC.states = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				// Reset the current dialogue state
				DH.init_dialogue_state();
				// Delete visited array and current minimap state
				MinimapState.save_delete_routine();
				
				
            }
			if (canDelete) {
				canDelete = _save.close(500000);
				trace("Writing to disk...", canDelete);
			} else {
				trace("Reading save failed");
			}
            return canDelete;
        }
		
    }

}
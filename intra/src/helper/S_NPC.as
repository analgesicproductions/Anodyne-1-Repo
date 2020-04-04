package helper 
{
	import global.Registry;
	/**
	 * Helper functions for stateful npcs.
	 * @author Melos Han-Tani
	 */
	public class S_NPC 
	{
		
		public static var states:Array = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		
		public static const IDX_TEST:int = 0;
		public static const IDX_LOBSTER:int = 1;
		public static const IDX_HAIR:int = 2;
		public static const IDX_BEAR:int = 3;
		public static const IDX_GOLEM:int = 4;
		
		private static const BIT_DIRTY:uint = 1 << 9;
		private static const BIT_SECOND_PLAYED:uint = 1 << 8;
		private static const BIT_BEDROOM_BOSS:uint = 1 << 7;
		private static const BIT_REDCAVE_BOSS:uint = 1 << 6;
		private static const BIT_CROWD_BOSS:uint = 1 << 5;
		private static const BIT_APARTMENT_BOSS:uint = 1 << 4;
		private static const BIT_HOTEL_BOSS:uint = 1 << 3;
		private static const BIT_CIRCUS_BOSS:uint = 1 << 2;
		private static const MAX_STATE:uint = 0xfc;
		
		//Dirty bit, read_second bit, bits on bosses.

		
		// Set state, based on index into state and current Boss states.
		
		public static function test():void {
			// WOOO INCOMPREHENSIBLE TESTS!!!
			trace(check_to_play_second(DH.name_test), "FALSE!"); // Playing when clean plays first
			trace(check_to_play_second(DH.name_test), "FALSE!"); // Playing when dirty but no state change doesnt play 2nd
			Registry.GE_States[Registry.GE_Bedroom_Boss_Dead_Idx] = true;
			trace(check_to_play_second(DH.name_test), "TRUE!"); // Make sure state changing plays the 2nd
			Registry.GE_States[Registry.GE_Redcave_Boss_Dead_Idx] = true;
			trace(check_to_play_second(DH.name_test), "TRUE!"); // Make sure playing the 2nd once makes any further play the 2nd
			
			states[IDX_TEST] = 0;
			trace(check_to_play_second(DH.name_test), "FALSE!"); // Check that starting clean but with state plays 1st
			trace(check_to_play_second(DH.name_test), "FALSE!"); // Dirty and state plays 1st (state donst change)
			Registry.GE_States[Registry.GE_Crowd_Boss_Dead_Idx] = true;
			trace(check_to_play_second(DH.name_test), "TRUE!"); 
			
			states[IDX_TEST] = 0;
			
			Registry.GE_States[Registry.GE_Bedroom_Boss_Dead_Idx] = true;
			Registry.GE_States[Registry.GE_Redcave_Boss_Dead_Idx] = true;
			Registry.GE_States[Registry.GE_Crowd_Boss_Dead_Idx] = true;
			Registry.GE_States[Registry.GE_Apartment_Boss_Dead_Idx] = true;
			Registry.GE_States[Registry.GE_Hotel_Boss_Dead_Idx] = true;
			Registry.GE_States[Registry.GE_Circus_Boss_Dead_Idx] = true;
			trace(check_to_play_second(DH.name_test), "FALSE!"); // PLaying hwen clena plays first 
			trace(check_to_play_second(DH.name_test), "TRUE!"); // play with all state set plays 2nd
			
			
		}
		
		/**
		 * check if you need to play the 2nd dialogue choice.
		 * if you leave 'scene' blank, then the functiond only relies on
		 * the stored state of the npc rather than the state of the scene too
		 * @param	name
		 * @param	scene
		 * @param	map
		 * @return
		 */
		public static function check_to_play_second(name:String, scene:String = "", map:String = ""):Boolean {
			var res:Boolean = false;
			if (name == DH.name_test) {
				res = update(IDX_TEST);
			} else if (name == DH.name_generic_npc && map == "BEACH") { // Lobster
				res = update(IDX_LOBSTER);
			} else if (name == DH.name_generic_npc && map == "REDSEA") {
				res = update(IDX_HAIR);
			} else if (name == DH.name_generic_npc && map == "FOREST") {
				res = update(IDX_BEAR);
			} else if (name == DH.name_generic_npc && map == "CLIFF") {
				res = update(IDX_GOLEM);
			}
			if (scene != "" && DH.scene_is_finished(name, scene, map) == false) return false; // We want all of the first set of dialogue to play at least once
			// Put the call after the update because we 
			// always want to record state
			return res;
		}
		
		// Returns true if: All event-bits set, or new result greater than current and dirty is set
		private static function update(idx:int):Boolean {
			if (states[idx] & BIT_DIRTY) {
				var s_new:uint = get_current_states() | states[idx];
				// i.e., if we've done all the events and talked to the NPC once, then play its second dialogue set
				// OR if the new state is newer then try to play the 2nd
				//  or if we've tried to play the 2nd.
				var sidx:uint = states[idx];
				//trace("S_NPC.update: New: ", s_new, " Old: ", states[idx]);
				if ((sidx & MAX_STATE) == MAX_STATE || s_new > sidx || s_new & BIT_SECOND_PLAYED) {
					states[idx] = s_new;
					states[idx] |= BIT_SECOND_PLAYED;
					return true;
				}
			} else {
				states[idx] |= BIT_DIRTY;
				states[idx] |= get_current_states();
				return false;
			}
			return false; 
		}
		
		static private function get_current_states():uint 
		{
			var s_new:uint = 0;
			Registry.GE_States[Registry.GE_Bedroom_Boss_Dead_Idx] ? s_new |= BIT_BEDROOM_BOSS : 1;
			Registry.GE_States[Registry.GE_Redcave_Boss_Dead_Idx] ? s_new |= BIT_REDCAVE_BOSS : 1;
			Registry.GE_States[Registry.GE_Crowd_Boss_Dead_Idx] ? s_new |= BIT_CROWD_BOSS : 1;
			Registry.GE_States[Registry.GE_Apartment_Boss_Dead_Idx] ? s_new |= BIT_APARTMENT_BOSS: 1;
			Registry.GE_States[Registry.GE_Hotel_Boss_Dead_Idx] ? s_new |= BIT_HOTEL_BOSS : 1;
			Registry.GE_States[Registry.GE_Circus_Boss_Dead_Idx] ? s_new |= BIT_CIRCUS_BOSS : 1;
			//trace("S_NPC.get_current_states returns ", s_new);
			return s_new;
		}
		
	}

}
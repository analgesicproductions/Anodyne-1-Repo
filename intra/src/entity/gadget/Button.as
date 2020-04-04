package entity.gadget 
{
	import data.CLASS_ID;
	import global.Registry;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Button extends FlxSprite
	{
		
		public var xml:XML;
		public var pressed:Boolean  = false;
		public var type:int = 0;
		public var UP_FRAME:int = 0;
		public var DOWN_FRAME:int = 1;
		private var INCREMENTED_REGISTRY:Boolean = false;
		[Embed (source = "../../res/sprites/gadgets/buttons.png")] public static var S_BUTTON:Class;
		
		private static var TYPE_PERMANENT:int = 0;
		private static var TYPE_TEMPORARY:int = 1;
		public var cid:int = CLASS_ID.BUTTON;
		private var parent:*;
		
		private var overlappable_cids:Array = new Array(CLASS_ID.PLAYER, CLASS_ID.SINGLEPUSHBLOCK, CLASS_ID.SILVERFISH, CLASS_ID.SHIELDY, CLASS_ID.MOVER,CLASS_ID.RAT,CLASS_ID.MITRA);
		
		public function Button(x:int,y:int,_xml:XML,_parent:*) 
		{
				super(x, y);
				xml = _xml;
				immovable = true;
				solid = false;
				type = parseInt(_xml.@frame);
				loadGraphic(S_BUTTON, true, false, 16, 16);
				
				if (Registry.CURRENT_MAP_NAME == "STREET") {
					UP_FRAME = 6;
					DOWN_FRAME = 7;
				} else if (Registry.CURRENT_MAP_NAME == "BEDROOM") {
					UP_FRAME = 0;
					DOWN_FRAME = 1;
				} else if (Registry.CURRENT_MAP_NAME == "REDCAVE") {
					UP_FRAME = 4;
					DOWN_FRAME = 5;
				} else if (Registry.CURRENT_MAP_NAME == "TRAIN") {
					UP_FRAME = 8;
					DOWN_FRAME = 9;
				}else {
					UP_FRAME =  2;
					DOWN_FRAME = 3;
				}
				parent = _parent;
				frame = UP_FRAME;
		}
		
		
		override public function update():void {
			
			
			if (overlaps(parent.player) && parent.player.state != parent.player.S_AIR) {
				overlap_callback(parent.player, this);
			}
			for each (var o:* in parent.sortables.members) {
				if (o != null && o is FlxSprite) {
					if (overlaps(o)) {
						overlap_callback(o, this);
					}
				}
			}
			
			

			if (type == TYPE_PERMANENT) return;
			
			if (INCREMENTED_REGISTRY && !pressed) {
				Registry.sound_data.button_up.play();
				if (Registry.GRID_PUZZLES_DONE > 0)
					Registry.GRID_PUZZLES_DONE --;
				INCREMENTED_REGISTRY = false;
				frame = UP_FRAME;
			}
			pressed = false;
			super.update();
		}
		
		
		public function overlap_callback(s:*, x:*):void {
			if (s is FlxGroup) {
				s = s.draw_root;
				if (s == null) return;
			}
			if (s.exists && s.hasOwnProperty("cid") && overlappable_cids.indexOf(s.cid) != -1) {
				pressed = true;
				
				if (!INCREMENTED_REGISTRY) {
					Registry.sound_data.button_down.play();
					frame = DOWN_FRAME;
					Registry.GRID_PUZZLES_DONE++;
					INCREMENTED_REGISTRY = true;
				}
			}
		}
	}

}
package entity.gadget 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import global.Registry;
	import org.flixel.FlxSprite;
	/**
	 * OH COME ON WHAT DO YOU THINK THIS IS.
	 * @author Seagaia
	 */
	public class Key extends FlxSprite
	{
		public var type:String = "Key";
		
		[Embed (source = "../../res/sprites/gadgets/key.png")] public static var C_KEY_SPRITE:Class;
		public var xml:XML;
		public var cid:int = CLASS_ID.KEY;
		
		private var player:Player;
		private var parent:*;
		public function Key(_x:int, _y:int,  _player:Player, _parent:*,_xml:XML = null)  
		{
			super(_x, _y);
			loadGraphic(C_KEY_SPRITE, false, false, 16, 16);
			if(_xml == null) {
				xml = <Key />;
				xml.@["x"] = _x.toString();
				xml.@["y"] = _y.toString();
				xml.@["p"] = "2"; //Keys only get collected once
				xml.@["alive"] = "true"; //Presumably, uh. 
			} else {
				xml = _xml;
				if (xml.@alive == "false") {
					visible = false;
				}
				y -= 20;
			}
			
			player = _player;
			parent = _parent;
		}
		
		override public function update():void {
			
			if (player.overlaps(this) && visible) {
				Registry.change_nr_keys(1);
				Registry.sound_data.get_key.play();
				xml.@alive = "false";
				visible = false;
				parent.bg_sprites.remove(this, true);
			}
				
			super.update();
		}
		
	}

}
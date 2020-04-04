package entity.gadget 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import global.Registry;
	import org.flixel.FlxSprite;
	
	/**
	 * Gate that only opens with the required number of growths
	 * DAME PARAMS:
		 * type : # of growths to open door
		 * p: 2
		 * alive: t/f, whether it should spawn
	 */
	public class Growth_Gate extends FlxSprite 
	{
		[Embed (source = "../../res/sprites/gadgets/growth_gate.png")] public static var sprite_growth_gate:Class;
		
		public var growth_requirement:int;
		public var xml:XML;
		public var active_region:FlxSprite;
		public var cid:int = CLASS_ID.GROWTH_GATE;
		public function Growth_Gate(_xml:XML) 
		{
			super(parseInt(_xml.@x), parseInt(_xml.@y));
			xml = _xml;
			growth_requirement = parseInt(xml.@type);
			
			loadGraphic(sprite_growth_gate, true, false, 16, 32);
			addAnimation('disappear', [0, 1, 2, 3,4], 4, false);
			immovable = true;
			frame = 0;
			active_region = new FlxSprite(x, y + height);
			active_region.makeGraphic(width, 4, 0xff00ffff);
			
			if (xml.@alive == "false") {
				visible = false;
			}
		}
		
		override public function update():void 
		{
			if (frame == 4) {
				xml.@alive = "false";
			}
			super.update();
		}
		public function check_open(f:FlxSprite):void {
			
			if (f.overlaps(active_region)) {
				if (xml.@alive == "false") return;
				if (Registry.nr_growths >= growth_requirement && frame == 0) {
					play('disappear');
				}
			}
		}
		
	}

}
package entity.gadget 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import org.flixel.FlxSprite;
	
	/**
	 * Gate that only opens when you have enough energy
	 * DAME PARAMS:
		 * p : 2
		 * alive: t/f, whether it should spawn
	 */
	public class Challenge_Gate extends FlxSprite 
	{
		
		[Embed (source = "../../res/sprites/gadgets/challenge_gate.png")] public static var sprite_challenge_gate:Class;
		
		public var cid:int = CLASS_ID.CHALLENGE_GATE;		
		public var xml:XML;
		public var active_region:FlxSprite;
		
		public function Challenge_Gate(_xml:XML) 
		{
			super(parseInt(_xml.@x), parseInt(_xml.@y));
			xml = _xml;
			
			loadGraphic(sprite_challenge_gate, true, false, 16, 16);
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
		
		public function check_open(p:Player):void {
			
			if (p.overlaps(active_region)) {
				if (xml.@alive == "false") return;
				if (p.health_bar.cur_health == p.health_bar.max_health && frame == 0) { //change for energy
					play('disappear');
				}
			}
		}
		
	}

}
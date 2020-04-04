package entity.gadget 
{
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	
	public class Dash_Pad extends FlxSprite 
	{
	
		[Embed (source = "../../res/sprites/gadgets/dash_pads.png")] public static var dash_pad_sprite:Class;	
		
		public var xml:XML;
		public var parent:*;
		public var player:Player;
		public var player_tracker:FlxSprite = new FlxSprite();
		
		private var type:int;
		
		
		private var disabled:Boolean = false;
		private var t_disabled:Number = 0;
		private var tm_disabled:Number = 1.0;
		
		
		
		public function Dash_Pad(_xml:XML, _player:Player, _parent:*)
		{
			xml = _xml;
			parent = _parent;
			player = _player;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			type = parseInt(xml.@frame);
			
			loadGraphic(dash_pad_sprite, true, false, 16, 16);
			if (Registry.CURRENT_MAP_NAME == "DEBUG" || 1) {
				if (type == 0) {
					frame = 4;
					type = UP;
				} else if (type == 2) {//down 
					frame = 6;
					type = DOWN;
				} else if (type == 1) {//right
					frame = 5;
					type = RIGHT;
				} else if (type == 3) {
					frame = 7;
					type = LEFT;
				}
				
			
			}
			
			player_tracker.makeGraphic(1, 1, 0x00123123);
			
		}
		
		override public function update():void 
		{
			player_tracker.x = player.midpoint.x;
			player_tracker.y = player.midpoint.y;
			
			if (!disabled && (player.state == player.S_GROUND) && player_tracker.overlaps(this)) {
				player.SIG_DASH = true;
				player.SIG_DASH_TYPE = type;
				
				alpha = 0.5;
				disabled = true;
				trace("Sending SIG DASH (DURL) ", type.toString(16));
			} else {
				t_disabled += FlxG.elapsed;
				if (t_disabled > tm_disabled) {
					t_disabled = 0;
					alpha = 1;
					disabled = false;
				}
			}
			super.update();
		}
		
	}

}
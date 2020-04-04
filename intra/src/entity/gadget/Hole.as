package entity.gadget 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Hole extends FlxSprite
	{
		
		[Embed (source = "../../res/sprites/gadgets/hole.png")] public var C_HOLE_SPRITE:Class;
		public var type:String = "Hole";
		public var xml:XML;
		public var active_region:FlxSprite;
		public var cid:int = CLASS_ID.HOLE;
		
		private var player:Player;
		public function Hole(_x:int, _y:int, _xml:XML, _player:Player, _frame:int = 0) 
		{
			super(_x, _y);
			
			immovable = true; solid = true;
			loadGraphic(C_HOLE_SPRITE, true, false, 16, 16);
			width = 4;
			height = 4;	
			offset.x = 6;
			offset.y = 5;
			x += 6;
			y += 5;
			if (_xml != null) {
				xml = _xml;
				frame = parseInt(xml.@frame); 
			} else {
				xml =<Hole />
				frame = _frame;
			}
			player = _player;
		
		}
		
		override public function update():void {
			if (player.state != player.S_AIR && player.overlaps(this)) {
				if (visible){
					player.isFalling = true;
					player.fall_pt.x = x;
					player.fall_pt.y = y;
				}
			} 
			super.update();
		}
	}

}
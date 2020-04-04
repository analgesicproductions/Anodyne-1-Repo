package entity.gadget 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import global.Registry;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Seagaia
	 */
	public class CrackedTile extends FlxSprite
	{
		
		[Embed (source = "../../res/sprites/gadgets/crackedtiles.png")] public var C_CRACKED_TILES:Class;
		
		public var xml:XML;
		public var on:Boolean = false;
		public var broken:Boolean = false;
		public var TIMER_DEFAULT:Number = 1.0;
		public var timer:Number = TIMER_DEFAULT;
		public var hole:Hole;
		public var type:String = "CrackedTile";
		
		private var player:Player;
		
		public var cid:int = CLASS_ID.CRACKEDTILE;
		
		public function CrackedTile(_x:int, _y:int, _xml:XML, _player:Player) 
		{
			super(_x, _y);
			xml = _xml;
			immovable = true;
			solid = false;
			loadGraphic(C_CRACKED_TILES, false, false, 16, 16);
			frame = parseInt(xml.@frame);
			if (Registry.CURRENT_MAP_NAME == "BEDROOM") frame = 0;
			hole = new Hole(x, y, null, _player,frame);
			hole.visible = false;
			
			player = _player;
		}
		
		override public function update():void {
			
			if (player.state != player.S_AIR && player.overlaps(this)) {
				on = true;
			}
			if (broken) {
				return;
			}
			if (on) {
				timer -= FlxG.elapsed;
				if (timer < 0) {
					Registry.sound_data.floor_crack.play();
					broken = true;
					visible = false;
					hole.visible = true;
				}
			}
			on = false;
			super.update();
		}
	}

}
package entity.interactive 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Fisherman extends FlxSprite 
	{
		
		public var player:Player;
		public var xml:XML;
		public var cid:int = CLASS_ID.FISHERMAN;
		
		private var state:int = 0;
		private var s_normal:int = 0;
		private var s_dying:int = 1;
		private var s_dead:int = 2;
		
		public static var fisherman_dead:Boolean = false;
		public function Fisherman(_xml:XML, _player:Player)
		{
			super(parseInt(_xml.@x), parseInt(_xml.@y));
			xml = _xml;
			loadGraphic(NPC.embed_beach_npcs, true, false, 16, 16);
			immovable = true;
			health = 2;
			player = _player;
			addAnimation("idle", [10,11], 3, true);
			addAnimation("dead", [12], 3, true);
			play("idle");
			if (xml.@alive == "false") {
				fisherman_dead = true;
				x -= 5000; //fuck it
				exists = false;
			}
		}
		
		override public function update():void 
		{
			FlxG.collide(player, this);
			switch (state) {
				case s_normal:
				if (!flickering && player.broom.overlaps(this) && player.broom.visible) {
					flicker(0.5);
					health--;
				}
				if (health <= 0) {
					state = s_dying;
					play("dead");
				}
				break;
			case s_dying:
				player.state = player.S_INTERACT;
				if (EventScripts.send_property_to(this, "y", parseInt(xml.@y) + 44, 0.3)) {
					state = s_dead;
					fisherman_dead = true;
				player.state = player.S_GROUND;
				
				}
				break;
			case s_dead:
				xml.@alive = "false";
				if (framePixels_y_push < 16) {
					framePixels_y_push ++;
				}
				if (scale.x > 0 && scale.y > 0) {
					scale.x -= 0.01;
					scale.y -= 0.01;
				}
				break;
			}
			super.update();
		}
		
	}

}
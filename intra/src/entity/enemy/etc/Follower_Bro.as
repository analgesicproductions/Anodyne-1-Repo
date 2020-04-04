package entity.enemy.etc 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Follower_Bro extends FlxSprite 
	{
		[Embed (source = "../../../res/sprites/npcs/follower_bro.png")] public static var sprite_follower:Class;
		public var player_ref:Player;
		public var cid:int = CLASS_ID.FOLLOWER_BRO;
		public var xml:XML;
		
		private var state:int = 0;
		private var s_hidden:int = 0;
		private var s_walk:int = 1;
		private var s_gone:int = 2;
		private var s_disappearing:int = 3;
		public function Follower_Bro(_xml:XML,p:Player) 
		{
			super(parseInt(_xml.@x), parseInt(_xml.@y));
			player_ref = p;
			xml = _xml;
			loadGraphic(sprite_follower, true, false, 16, 24);
			addAnimation("walk", [1, 2, 1, 0], 4, true);
			alpha = 0;
			immovable = true;
			trace("makin bro");
			if (xml.@alive == "false") {
				state = s_gone;
				visible = solid = false;
			}
		}
		override public function update():void 
		{
			
			switch (state) {
				case s_hidden:
					solid = false;
					if (player_ref.y - y < -20) {
						player_ref.dontMove = true;
						alpha += 0.02;
					}
					if (alpha > 0.96) {
						player_ref.dontMove = false;
						state = s_walk;
					}
					break;
				case s_walk:
					if (FlxG.overlap(player_ref, this)) state = s_disappearing;
					solid = true;
					if (player_ref.y > y) {
						velocity.y = velocity.x = 0;
						frame = 1;
					} else {
						velocity.y = -10;
						velocity.x = (player_ref.x > x) ? 10 : -10;
						play("walk");
					}
					break;
				case s_gone:
					return;
				case s_disappearing:
					alpha -= 0.02;
					if (alpha <= 0) {
						visible = solid = false;
					}
					break;
			}
			super.update();
		}
		
		override public function destroy():void 
		{
			xml.@alive = "false";
			super.destroy();
		}
		
	}

}
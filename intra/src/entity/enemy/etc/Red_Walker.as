package entity.enemy.etc 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Red_Walker extends FlxSprite 
	{
		[Embed (source = "../../../res/sprites/enemies/redwalker.png")] public static var sprite_redwalker:Class;
		public var xml:XML;
		public var cid:int = CLASS_ID.RED_WALKER;
		public var tl:Point;
		
		public var player:Player;
		public function Red_Walker(_xml:XML,_player:Player) 
		{
			super(parseInt(_xml.@x), parseInt(_xml.@y));
			xml = _xml;
			loadGraphic(sprite_redwalker, true, false, 32, 48);
			addAnimation("walk", [0, 1, 2, 3, 4], 5, true);
			play("walk");
			
			velocity.x = 5 + 15 * Math.random();
			_curFrame = int(5 * Math.random());
			player = _player;
			immovable = true;
			
			width = 20;
			height = 8;
			offset.x = 4;
			x += 4;
			offset.y = 40;
			y += 40;
			
			tl = new Point(Registry.CURRENT_GRID_X * 160, Registry.CURRENT_GRID_Y * 160 + Registry.HEADER_HEIGHT);
			
		}
		
		override public function update():void 
		{	
			
			FlxG.collide(this, player);
			
			if (velocity.x > 0 && x + width > tl.x + 160) {
				velocity.x *= -1;
				scale.x *= -1;
			} else if (velocity.x < 0 && x < tl.x) {
				velocity.x *= -1;
				scale.x *= -1;
			}
			
			
			super.update();
		}
	}

}
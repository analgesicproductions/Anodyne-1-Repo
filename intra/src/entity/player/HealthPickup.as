package entity.player 
{
	import global.Registry;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import states.PlayState;
	
	/**
	 * +1, +3 health things, and the extenderzzz
	 * @author Seagaia
	 */
	public class HealthPickup extends FlxSprite 
	{
		
		public static var HP_1:int = 1;
		public static var HP_3:int = 3;
		public static var HP_EXTEND:int = 0;
		public var pickup_type:int;
		public var xml:XML;
		public var parent:*;
		public var LATENCY:Number = 0.5; // Timeout for broom touching
		[Embed (source = "../../res/sprites/inventory/small_health_pickup.png")] public static const S_SMALL_HEALTH:Class;
		[Embed(source = "../../res/sprites/inventory/big_health_pickup.png")] public static const embed_Big_health:Class;
		
		public function HealthPickup(x:int,y:int,_pickup_type:int,_parent:*,_xml:XML = null):void 
		{
			super(x, y);
			solid = false;
			pickup_type = _pickup_type;
			has_tile_callbacks = false;
			parent = _parent;
			switch(pickup_type) {
				case HP_1:
					loadGraphic(S_SMALL_HEALTH, true, false, 10, 16);
					addAnimation("float", [0, 1, 2, 3], 5, true);
					play("float");
					break;
				case HP_3:
					loadGraphic(embed_Big_health, true, false, 16, 16);
					addAnimation("float", [0, 1, 2, 3], 5, true);
					play("float");
					break;
					//makeGraphic(12, 12, 0xffff0000); break;
				case HP_EXTEND:
					makeGraphic(16, 16, 0xffff2200); break;
			}
			
			xml = _xml;
			if (xml == null) { // Usually when a health-pickup is dropped by an enemy
				xml = <HealthPickup/>;
			} else {
				if (xml.@alive == "false") {
					exists = false;
				}
			}
		}
		
		override public function update():void 
		{
			if (LATENCY > 0) {
				LATENCY -= FlxG.elapsed;
			} else {
				if (parent.player.overlaps(this) || 
					(parent.player.broom.visible && parent.player.broom.overlaps(this))) {
						picked_up(parent.player);
					}
			}
			super.update();
		}
		/**
		 * Given a reference to the player, heal it or trigger the events
		 * to increase health bar
		 * @param	player
		 */
		public function picked_up(player:Player):void {
			switch (pickup_type) {
				case HP_1:
					Registry.sound_data.get_small_health.play();
					player.health_bar.modify_health(1); break;
				case HP_3:
					Registry.sound_data.get_small_health.play();
					player.health_bar.modify_health(3); break;
				case HP_EXTEND:
					xml.@alive = "false";
					Registry.EVENT_EXTEND_HEALTH = true;
					break;
			}
			visible = solid = false; 
			exists = false;
		}
		
		override public function destroy():void {
			//shouldget cleaned up in delete_otherobjecs
			super.destroy();
		}
		
	}

}
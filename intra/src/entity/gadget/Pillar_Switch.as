package entity.gadget 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import global.Registry;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * Hitting this flips the global pillar_switch_state value.
	 * @author Seagaia
	 */
	public class Pillar_Switch extends FlxSprite 
	{
		[Embed(source = "../../res/sprites/gadgets/pillar_switch.png")] public var pillar_switch_sprite:Class;
		
		
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		
		public var t_hit:Number = 1.0;
		public var tm_hit:Number = 1.0;
		
		public var cid:int = CLASS_ID.PILLAR_SWITCH;
		
		public function Pillar_Switch(_xml:XML,_player:Player,_parent:*) 
		{
			
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			
			loadGraphic(pillar_switch_sprite, true, false, 16, 16);
			addAnimation("a", [0]);
			addAnimation("b", [1]);
			addAnimation("hit", [2, 3], 12);
			immovable = true;
			
			if (Registry.pillar_switch_state) {
				play("a");
			} else {
				play("b");
			}
			
			
		}
		
		override public function update():void 
		{
			FlxG.collide(player, this);
			if (t_hit > tm_hit) {
				if (_curAnim.name == "hit") {
					if (Registry.pillar_switch_state) {
						play("b");
					} else {
						play("a");
					}
				}
				if (player.broom.visible && player.broom.overlaps(this)) {
					play("hit");
					Registry.pillar_switch_state = !Registry.pillar_switch_state;
					t_hit = 0;
				}
			} else {
				t_hit += FlxG.elapsed;
			}
		
			if (_curAnim.name == "a" && !Registry.pillar_switch_state) {
				play("b");
			} else if (_curAnim.name == "b" && Registry.pillar_switch_state) {
				play("a");
			}
			
			
			
			super.update();
		}
	}

}
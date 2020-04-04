package entity.gadget 
{
	import entity.player.Player;
	import flash.media.Video;
	import global.Registry;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Switch_Pillar extends FlxSprite 
	{
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		
		public var up_frame:int;
		public var down_frame:int;
		
		private var original_state:Boolean = false;
		
		[Embed(source = "../../res/sprites/dame/dame-switch-pillar.png")] public var switch_pillar_sprite:Class;
		
		public function Switch_Pillar(_xml:XML,_player:Player,_parent:*) 
		{
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			loadGraphic(switch_pillar_sprite, true, false, 16, 16);
			
			var dame_frame:int = parseInt(xml.@frame);
			if (dame_frame < 2) {
				up_frame  = 0;
				down_frame = 1;
			}
			
			if (dame_frame % 2) {
				if (Registry.pillar_switch_state) {
					frame = down_frame;
				} else {
					frame = up_frame;
				}
			} else {
				if (!Registry.pillar_switch_state) {
					frame = down_frame;
				} else {
					frame = up_frame;
				}
			}
			addAnimation("dissolve", [0, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 1], 15,false);
			
			addAnimation("solidify", [1,14,13,12,11,10,9,8,7,6,5,4,0], 15,false);
			original_state = Registry.pillar_switch_state;
			Registry.subgroup_switch_pillars.push(this);
			immovable = true;
		}
		
		override public function update():void {
			if (frame == up_frame) {
				FlxG.collide(this, player);
			}
			
			if (original_state != Registry.pillar_switch_state) {
				
				play_sfx(HURT_SOUND_NAME);
				if (frame == up_frame) {
					Registry.sound_data.dash_pad_1.play();
					play("dissolve");
				} else {
					Registry.sound_data.dash_pad_2.play();
					play("solidify");
				}
				original_state = Registry.pillar_switch_state;
			}
			super.update();
		}
	}

}
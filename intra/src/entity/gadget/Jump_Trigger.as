package entity.gadget 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import global.Registry;
	import org.flixel.FlxSprite;
	
	/*
	 * dame props:
		 * frame - how many tiles this makes the player jump 
		 * past the next tile - 0 => 1, 1 => 2. 
		 * */
	public class Jump_Trigger extends FlxSprite 
	{
		
		[Embed (source = "../../res/sprites/gadgets/spring_pad.png")] public static var spring_pad_sprite:Class;
		
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		public var distance:int;
		public var time:Number;
		public var cid:int = CLASS_ID.JUMP_TRIGGER;
		private var active_region:FlxSprite = new FlxSprite(0, 0);
		
		private var dame_type:int = 0;
		private var T_NORMAL:int = 0;
		private var T_SPRING:int = 1;
		private var frame_down:int = 1;
		private var frame_mid:int = 0;
		private var activated:Boolean = false;
		
		private var did_init:Boolean = false;
		
		public function Jump_Trigger(_xml:XML, _player:Player,_parent:*)
		{
			super(parseInt(_xml.@x), parseInt(_xml.@y));
			xml = _xml;
			player = _player;
			parent = _parent;
			dame_type = parseInt(xml.@type);
			
			if (dame_type == T_SPRING) {
				loadGraphic(spring_pad_sprite, true, false, 16, 16);
				addAnimation("still", [0], 0, false);
				addAnimation("wobble", [0,2,0,1,0,2,0,1,0,0], 10, false);
				play("still");
				
				active_region = this;
			} else {
				makeGraphic(16, 2, 0x00000000);
				immovable = true;
				solid = false;
				y += 12;	
				active_region.makeGraphic(6, 4, 0x000000);
			}
			
			
			switch (parseInt(xml.@frame)) {
				case 0:
					distance = 32;
					time = 0.3;
					break;
				case 1:
					distance = 48;
					time = 0.5;
					break;
				case 2:
					distance = 64;
					time = 0.7;
					break;
			}
			
			
			
		}
		
		override public function update():void 
		{
			
			if (!did_init) {
				did_init = true;
				parent.sortables.remove(this, true);
				parent.bg_sprites.add(this);
			}
			if (dame_type == T_NORMAL) {
				active_region.x = x + 5;
				active_region.y = y;
			
				if (player.overlaps(active_region) && (player.state == player.S_LADDER || (player.state == player.S_GROUND && player.facing & DOWN))) {
					make_player_jump();
				}
			} else {
				active_region.x = x;
				active_region.y = y;
				if (player.overlaps(active_region)) {
					if (player.just_landed) {
						if (!activated) {
							activated = true;
							player.is_spring_jump = true;
							Registry.sound_data.spring_bounce.play();
							make_player_jump();
							play("wobble");
						}
					} else {
						if (!activated && player.state == player.S_GROUND) {
							frame = frame_down;
						} else if (player.state == player.S_AIR) {
							frame = frame_mid;
						}
					}
				} else {
					if (!activated) {
						frame = frame_mid;
					}
					if (_curAnim != null && _curAnim.name == "wobble" && _curAnim.frames.length - 1 == _curFrame) {
						frame = frame_mid;
						activated = false;
					}
				}
			}
			
			super.update();
		}
		
		private function make_player_jump():void 
		{
			player.auto_jump_period = time;
			player.auto_jump_distance = distance;
			player.auto_jump_base_y = player.y;
			player.state = player.S_AUTO_JUMP;
		}
		
	}

}
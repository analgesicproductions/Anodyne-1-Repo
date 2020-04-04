package entity.enemy.redcave 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import global.Registry;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * DAME PROPS:
		 * frame - direction of the laser (URDL)
		 * 		note, row determines period
	 * 
	 */
	public class On_Off_Laser extends FlxSprite 
	{
	
		public var cid:int = CLASS_ID.ON_OFF_LASER;
		public var xml:XML;	
		private var LASER_WIDTH:int = 12;
		private var OFFSET:int = 0;//2;
		
		
		public var laser:FlxSprite;
		public var laser_active:Boolean = false;
		private var played_sound:Boolean = false;
		
		private var player:Player;
		
		public var state:int = 0;
		private var s_idle:int = 0;
		private var s_emerging:int = 1;
		public var s_hurting:int = 2;
		private var s_receding:int = 3;
		
		private var t:Number = 0;
		private var tm_idle:Number = 0;
		private var tm_hurting:Number = 0;
		
		private var did_move_offset:Boolean = false;
		// up, left
		[Embed (source = "../../../res/sprites/enemies/redcave/f_on_off_h.png")] public var h_on_off_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/redcave/f_on_off_v.png")] public var v_on_off_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/redcave/on_off_shooter.png")] public static var on_off_shooter_sprite:Class;
		
		public function On_Off_Laser(_xml:XML,_player:Player) 
		{
			super(parseInt(_xml.@x), parseInt(_xml.@y));
			xml = _xml;
			immovable = true;
			var dame_frame:int = parseInt(xml.@frame);
			switch (dame_frame) {
				case 0: //up
					laser = new FlxSprite(x + OFFSET, y - 144);
					laser.loadGraphic(v_on_off_sprite, true, true, 16, 144);
					laser.height = 112;
					laser.scale.y = -1;
					laser.width = 8;
					laser.offset.x = 4;
					laser.x += 4;
					laser.y += 32;
					laser.offset.y += 32;
					
					break;
				case 1: //r
					laser = new FlxSprite(x + width, y + OFFSET);
					laser.loadGraphic(h_on_off_sprite, true, true, 144, 16);
					laser.scale.x = -1;
					laser.offset.x =  16;
					laser.width = 128;
					laser.offset.x = 16;
					laser.height = 8;
					laser.offset.y = 4;
					laser.y += 4;
					break;
				case 2: //down
					laser = new FlxSprite(x + OFFSET, y  + 16); //+height );
					laser.loadGraphic(v_on_off_sprite, true, false, 16, 144);
					laser.height = 112;
					laser.offset.y = 16;
					laser.width = 8;
					laser.offset.x = 4;
					laser.x += 4;
					break;
				case 3:
					laser = new FlxSprite(x - 144, y + OFFSET);
					laser.loadGraphic(h_on_off_sprite, true, false, 144, 16);
					laser.offset.x =  -16;
					laser.width = 112;
					laser.height = 8;
					laser.offset.x = 16;
					laser.x += 32;
					laser.offset.y = 4;
					laser.y += 4;
					break;
			}
			/* Shooter/node's animations */
			//urdl
			
			loadGraphic(on_off_shooter_sprite, true, false, 16, 16);
			switch (dame_frame) {
				case 2: // If pointing down
					addAnimation("shooter_closed", [0,1], 2);
					addAnimation("shooter_open", [2]);
					break;
				case 1: //pointing right
				case 0: // ...down
				case 3: //left
					if (dame_frame == 1) {
						angle = 90;
					} else if (dame_frame == 3) {
						angle = -90;
					}
					addAnimation("shooter_closed", [3,4], 2);
					addAnimation("shooter_open", [5]);
					break;
			}
			play("shooter_closed");
			
			/* Steam's animations */
			laser.addAnimation("steam_is_harmful", [3, 4, 5, 6], 15, true);
			/* for these non-looping anims, keep the extra frame index at the end because I use the animation
			 * index to tell the steam to change to the next state */
			laser.addAnimation("recede", [0, 1, 2, 2], 5, false); 
			laser.addAnimation("emerge", [2, 1, 0, 0], 5, false); 
			laser.addAnimation("idle_invisible", [0], 2,true);
			laser.visible = false;
			switch (parseInt(xml.@frame)) {
				case 0: case 1: case 2: case 3:
					tm_hurting = tm_idle = 2;
					break;
			}
			laser.play("idle_invisible");
			laser.visible = false;
			
			player = _player;
			Registry.subgroup_on_off_lasers.push(this);
			// anims: steam from  head, head opening
			// sfx: steam blowing
			add_sfx("shoot", Registry.sound_data.on_off_laser_shoot);
			
		}
		
		override public function update():void 
		{
			
			if (!did_move_offset) {
				//urdl
				did_move_offset = true;
				switch (parseInt(xml.@frame)) {
					case 0:
						laser.offset.y -= 16;
						break;
					case 1:
						break;
					case 2:
						break;
					case 3:
						break;
				}
			}
		
			switch (state) {
				case s_idle:
					t += FlxG.elapsed;
					if (t > tm_idle) {
						t = 0;
						laser.visible = true;
						state = s_emerging;
						play("shooter_open");
						play_sfx("shoot");
						laser.play("emerge");
					}
					break;
				case s_emerging:
					laser.flicker(0.05);
					if (laser._curFrame == (laser._curAnim.frames.length - 1)) {
						laser.play("steam_is_harmful");
						state = s_hurting;
					}
					break;
				case s_hurting:
					t += FlxG.elapsed;
					if (t > tm_hurting) {
						laser.play("recede");
						t = 0;
						state = s_receding;
					}
					if (player.overlaps(laser)) {
						player.touchDamage(1);
					}
					
					break;
				case s_receding:
					laser.flicker(0.05);
					if (laser._curFrame == (laser._curAnim.frames.length - 1)) {
						laser.play("idle_invisible");
						laser.visible = false;
						state = s_idle;
						play("shooter_closed");
					}
					break;
			}
			super.update();
		}
		
	}

}
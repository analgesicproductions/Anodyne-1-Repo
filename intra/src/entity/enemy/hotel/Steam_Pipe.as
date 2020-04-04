package entity.enemy.hotel 
{
	import entity.gadget.Dust;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	public class Steam_Pipe extends FlxSprite 
	{
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		private var dame_frame:int;
		private var added_to_parent:Boolean = false;

		private var eject_pt:Point;
		private var eject_vel:int = 50;
		public var steam_clouds:FlxGroup = new FlxGroup(6);
		public var timers:Array;
		private var PUSH_VEL:int = 50;

		
		private var active_region:FlxSprite = new FlxSprite();
		private var disabled:Boolean = false;
		
		
		//dame frames - DRUL
		
		[Embed(source = "../../../res/sprites/enemies/hotel/steam_pipe.png")] public static var steam_pipe_sprite:Class;
		[Embed(source = "../../../res/sprites/enemies/hotel/steam.png")] public static var steam_sprite:Class;
		
		public function Steam_Pipe(_xml:XML,_player:Player,_parent:*) 
		{
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			loadGraphic(steam_pipe_sprite, true, false, 16, 16);
			dame_frame = parseInt(xml.@frame);
			
			// Set directions and active regions (where you are pushed), and ejection points for the steam clouds
			/* ADD ANIMATIONS FOR STEAM PIPE (if any) */
			switch(dame_frame) {
				case 0:
					eject_pt = new Point(x + 2, y + Registry.HEADER_HEIGHT + 10);
					active_region = new FlxSprite(x + 3, y + 16 + Registry.HEADER_HEIGHT);
					active_region.makeGraphic(10, 16, 0xff123123);
					frame = 0; facing = DOWN; 
					break;
				case 1:
					eject_pt = new Point(x + 14, y + 5 + Registry.HEADER_HEIGHT);
					active_region = new FlxSprite(x + 16, y + Registry.HEADER_HEIGHT + 3);
					active_region.makeGraphic(16, 10, 0xff123123);
					addAnimation("do_something", [1], 12);
					frame = 1; facing = RIGHT; 
					break;
				case 2:
					eject_pt = new Point(x + 3, y - 2 + Registry.HEADER_HEIGHT);
					frame = 2; facing = UP; 
					active_region = new FlxSprite(x + 3, y + Registry.HEADER_HEIGHT - 16);
					active_region.makeGraphic(10, 16, 0xff123123);
					addAnimation("do_something", [2], 12);
					break;
				case 3:
					eject_pt = new Point(x - 6, y + 3 + Registry.HEADER_HEIGHT);
					frame = 3; facing = LEFT; 
					active_region = new FlxSprite(x - 16, y + Registry.HEADER_HEIGHT + 3);
					active_region.makeGraphic(16, 10, 0xff123123);
					addAnimation("do_something", [3], 12);
					break;
			}
			play("do_something");
			
			active_region.visible = false;
			
			timers = new Array(steam_clouds.maxSize);
			
		
			//Randomize the size of the clouds a little
			/* ADD ANIMATIONS FOR STEAM CLOU */
			for (var i:int = 0; i < steam_clouds.maxSize; i++) {
				var steam_cloud:FlxSprite = new FlxSprite();
				steam_cloud.loadGraphic(steam_sprite, true, false, 16, 16);
				steam_cloud.addAnimation("s", [0, 1], 10);
				steam_cloud.play("s");
				//steam_cloud.flicker( -1);
				steam_clouds.add(steam_cloud);
				steam_cloud.x = eject_pt.x;
				steam_cloud.y = eject_pt.y;
				steam_cloud.scale.x = steam_cloud.scale.y = 0.8 + 0.2 * Math.random();
				steam_cloud.width = steam_cloud.height = width * steam_cloud.scale.x;
				//steam_cloud.angle = 360 * Math.random();
				timers[i] = 30 + int(20 * Math.random()); //Timeouts for steam clouds to reset
				set_vel(steam_cloud);
			}
			
			add_sfx("pew", Registry.sound_data.fireball_group);
		
		}
		
		override public function update():void 
		{
			if (!added_to_parent) {
				added_to_parent = true;
				parent.bg_sprites.add(active_region);
				parent.fg_sprites.add(steam_clouds);
			}
			
			// dust on the active region disables the pushing effect
			disabled = false;
			for each (var dust:Dust in Registry.subgroup_dust) {
				if (dust != null) {
					if (dust.overlaps(active_region) && (dust.frame != Dust.EMPTY_FRAME) && (dust != player.raft)) {
						disabled = true;
					}
				}
			}
			
			for each (var gas:FlxSprite in Registry.subgroup_gas) {
				if (gas != null) {
					for each (var steam_cloud:FlxSprite in steam_clouds.members) {
						if (steam_cloud != null) {
							if (gas.overlaps(steam_cloud)) {
								gas.velocity.x += 0.01 * steam_cloud.velocity.x;
								gas.velocity.y += 0.01 * steam_cloud.velocity.y;
							}
						}
					}
				}
			}
			
			var ctr:int = 0;
			//Change timers for the visual effect of steam spewing forth, or being held by the dust
			for each (var steam:FlxSprite in steam_clouds.members) {
				timers[ctr]--;
				if (timers[ctr] == 0) {
					if (!disabled) {
						timers[ctr] = 30 + int(20 * Math.random());
					} else {
						timers[ctr] = 3 + int(2 * Math.random());
					}
					steam.x = eject_pt.x;
					steam.y = eject_pt.y;
					set_vel(steam);
					play_sfx("pew");
				}
				ctr++;
				
				if (disabled == false) {
					if (steam.overlaps(player)) {
						pushplayer();
					}
				}
			}
			
			// Push the player if the pipe isn't disabled, and player touches active region
			if (!disabled) {
				if (player.overlaps(active_region)) {
					pushplayer();
				}
			}
			
			super.update();
		}
		
		//randomize velocity of clouds within certain ranges
		private function set_vel(steam_cloud:FlxSprite):void 
		{
			switch (facing) {
				case DOWN:
					steam_cloud.velocity.y = eject_vel + 20 * Math.random();
					steam_cloud.velocity.x = -30 + 60 * Math.random();
					break;
				case UP:
					steam_cloud.velocity.y = -eject_vel - 20 * Math.random();
					steam_cloud.velocity.x = -30 + 60 * Math.random();
					break;
				case LEFT:
					steam_cloud.velocity.x = -eject_vel - 20 * Math.random();
					steam_cloud.velocity.y = -30 + 60 * Math.random();
					break;
				case RIGHT:
					steam_cloud.velocity.x = eject_vel + 20 * Math.random();
					steam_cloud.velocity.y = -30 + 60 * Math.random();
					break;
			}
		}
		
		private function pushplayer():void 
		{
			switch(facing) {
				case DOWN:
					player.additional_y_vel = PUSH_VEL; break;
				case UP:
					player.additional_y_vel = -PUSH_VEL;  break;
				case LEFT:
					player.additional_x_vel = -PUSH_VEL; break;
				case RIGHT:
					player.additional_x_vel = PUSH_VEL;  break;
					
			}
		}
		
		
	}

}
package entity.interactive 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import global.Registry;
	import helper.Cutscene;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Red_Pillar extends FlxSprite 
	{
		/* dame props:
			 * alive - whether this appears as broken or not etc
			 * p = 2
			 * frame: what event it triggers when destroyed 
			 * 	 	L R C1 C2    <-- the triggers (1 to 4) WHERE THEY ARE LOCATED */
		public var xml:XML;
		public var cid:int = CLASS_ID.RED_PILLAR;
		
		public var state:int = 0;
		public var s_disappearing:int = 3;
		public var s_dead:int  = 2;
		public var s_dying:int = 1;
		public var s_alive:int = 0;
		
		public var player:Player;
		public var parent:*;
		
		public var active_region:FlxSprite;
		public var ripple:FlxSprite;
		public var pixel_push:Number = 0;
		public var retract_speed:Number = 0.4;
		
		[Embed (source = "../../res/sprites/enemies/redcave/red_pillar.png")] public static var red_pillar_sprite:Class;
		[Embed (source = "../../res/sprites/enemies/redcave/red_pillar_ripple.png")] public static var red_pillar_ripple_sprite:Class;
		
		public function Red_Pillar(_xml:XML, _p:Player, _parent:* )
		{
			super(parseInt(_xml.@x), parseInt(_xml.@y));
			xml = _xml;
			
			/* AD DANIMS */
			loadGraphic(red_pillar_sprite, true, false, 16, 80);
			addAnimation("move", [1, 2], 8);
			addAnimation("stuck", [0]);
			retract_speed = 0.7;
			play("stuck");
			
			// need to add
			ripple = new FlxSprite;
			ripple.loadGraphic(red_pillar_ripple_sprite, true, false, 16, 16);
			ripple.addAnimation("move", [0, 1], 8, true);
			ripple.play("move");
			ripple.visible = false;
			ripple.x = x;
			ripple.y = y + height + Registry.HEADER_HEIGHT - ripple.height + 1;
			
			if (xml.@alive == "false") {
				exists = false;
			}
			immovable = true;
			
			player = _p;
			
			active_region = new FlxSprite(x, y + Registry.HEADER_HEIGHT + 16);
			active_region.makeGraphic(16, 16, 0x000000);
			
			parent = _parent;
			_parent.sortables.add(ripple);
		}
		
		
		override public function update():void 
		{
			if (state == s_dying) {
				if (!flickering) {
					Registry.Event_Nr_Red_Pillars_Broken++;
					switch (parseInt(xml.@frame)) {
						case 1:
						case 2:
							if (Registry.Event_Nr_Red_Pillars_Broken == 4) {
								Registry.E_Load_Cutscene = true;
								Registry.CURRENT_CUTSCENE = Cutscene.Red_Cave_North;
								
							}
							xml.@alive = "false";
							break;
						case 3:
							Registry.E_Load_Cutscene = true;
							Registry.CURRENT_CUTSCENE = Cutscene.Red_Cave_Left;
							xml.@alive = "false";
							break;
						case 4:
							Registry.E_Load_Cutscene = true;
							Registry.CURRENT_CUTSCENE = Cutscene.Red_Cave_Right;
							xml.@alive = "false";
							break;
					}
					player.state = player.S_GROUND;
					exists = false;
				}
			} 
			
			if (state == s_alive && player.broom.overlaps(active_region) && player.broom.visible) {
				hit();
				play_sfx(HURT_SOUND_NAME);
				play("hit");
			}
			
			if (state == s_disappearing) {
				
				player.invincible = true;
				if (player.broom.visible == false) {
					player.state = player.S_INTERACT;
					player.be_idle();
				}
				pixel_push += retract_speed;
				framePixels_y_push  = pixel_push;
				if (framePixels_y_push == height) {
					state = s_dying;
					ripple.exists = false;
				}
			} else {
				FlxG.collide(this, player);
			}
			
			super.update();
		}
		
		public function hit():void {
			flicker(1.5);
			play("move");
			state = s_disappearing;
			ripple.visible = true;
			
		}
		
		override public function destroy():void 
		{
			parent.sortables.remove(ripple, true);
			active_region = ripple = null;
			super.destroy();
		}
		
	}

}
package entity.enemy.circus 
{
	import entity.enemy.crowd.Spike_Roller;
	import entity.gadget.Dust;
	import entity.player.Player;
	import flash.display.InterpolationMethod;
	import global.Registry;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	public class Fire_Pillar extends FlxSprite	{
		[Embed (source = "../../../res/sprites/enemies/circus/fire_pillar.png")] public static var fire_pillar_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/circus/fire_pillar_base.png")] public static var fire_pillar_base_sprite:Class;
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		private var added_to_parent:Boolean = false;
		
		public var hitbox:FlxSprite = new FlxSprite;
		public var base:FlxSprite = new FlxSprite;
		
		private var t:Number = 0;
		private var tm_idle:Number = 0.74;
		private var tm_emerge:Number = 0.3;
		private var tm_flame:Number = 1.0;
		private var tm_recede:Number = 0.3;
		
		private var ctr:int = 0;
		
		public function Fire_Pillar(_xml:XML, _player:Player, _parent:*) {
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			loadGraphic(fire_pillar_sprite, true, false, 16, 32);
			
			hitbox.makeGraphic(16, 9, 0x00112332);
			base.loadGraphic(fire_pillar_base_sprite, true, false, 16, 16);
			base.addAnimation("dormant", [0, 1], 6);
			base.play("dormant");
			
			addAnimation("idle", [0], 15);
			addAnimation("emerge", [1, 2, 3, 4], 8, false);
			addAnimation("flame", [3, 4], 10);
			addAnimation("recede", [5, 6, 0], 8, false);
			play("idle");
			
			add_sfx("shoot", Registry.sound_data.flame_pillar_group);
		
			
		}
		
		override public function update():void 
		{
			if (!added_to_parent) {
				added_to_parent = true;
				height = 23;
				base.x = hitbox.x = x
				base.y = hitbox.y = y + 16;
				
				parent.bg_sprites.members.splice(0, 0, base);
				parent.bg_sprites.length++;
			}
			
			for each (var dust:Dust in Registry.subgroup_dust) {
				if (dust == null) continue;
				if (dust.visible && dust.overlaps(hitbox)) {
					ctr = 0;
					play("idle");
				}
			}
			
			for each (var spike_roller:Spike_Roller in Registry.subgroup_spike_rollers) {
				if (spike_roller == null) continue;
				if (spike_roller.visible && spike_roller.overlaps(hitbox)) {
					ctr = 0;
					play("idle");
				}
			}
			
			if (ctr == 0) {
				t += FlxG.elapsed;
				if (t > tm_idle) {
					t = 0;
					ctr++;
					play("emerge");
					flicker(.25);
				}
			} else if (ctr == 1) {
				t += FlxG.elapsed;
				if (t > tm_emerge) {
					t = 0;
					ctr++;
					play_sfx("shoot");
					play("flame");
				}
			} else if (ctr == 2) {
				t += FlxG.elapsed;
				if (t > tm_flame) {
					t = 0;
					ctr++;
					play("recede");
					flicker(.25)
				}
				if (player.overlaps(hitbox)) {
					player.touchDamage(1);
				}
			} else if (ctr == 3) {
				t += FlxG.elapsed;
				if (t > tm_recede) {
					t = 0;
					ctr = 0;
					play("idle");
				}
			}
			
			
			super.update();
		}
		
		override public function destroy():void 
		{	
			super.destroy();
		}
	}
}
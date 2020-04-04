package entity.enemy.apartment 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class Gasguy extends FlxSprite 
	{
		[Embed (source = "../../../res/sprites/enemies/apartment/gas_guy.png")] public static var gas_guy_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/apartment/gas_guy_cloud.png")] public static var gas_guy_cloud_sprite:Class;
		
		public var xml:XML;
		private var player:Player;
		private var parent:*;
		private var gas_group:FlxGroup = new FlxGroup(3);
		
		private var state:int = 1;
		private var s_normal:int = 0;
		
		private var s_shoot:int = 1;
		private var t:Number = 4;
		private var tm:Number = 5.0;
		private var initial_latency:Number = 1.5;
		private var tm_shoot_latency:Number = 1.2;
		
		private var s_dying:int = 2;
		private var s_dead:int = 3;
		
		private var s_shoot_latency:int = 4;
		
		private var tm_move_sound:Number;
		private var t_move_sound:Number = 0;
		
		
		private var just_hit:Boolean = false;
		
		public var cid:int = CLASS_ID.GASGUY;
		
		public function Gasguy(_x:XML, _p:Player, _pa:*)
		{
			
			xml = _x;
			player = _p;
			parent = _pa;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			/* add gas guy anims */
			loadGraphic(gas_guy_sprite, true, false, 16, 24);
			addAnimation("float", [0, 1], 2, true);
			addAnimation("release_gas", [2], 20, true);
			play("float");
			
			/* Make gas and add adnimations for gas*/
			for (var i:int = 0; i < gas_group.maxSize; i++ ) {
				var gas:FlxSprite = new FlxSprite();
				gas.loadGraphic(gas_guy_cloud_sprite, true, false, 24, 24);
				gas.addAnimation("gas_move", [0, 1], 3);
				gas.width = gas.height = 16;
				gas.offset.x = 4;
				gas.offset.y = 4;
				gas.centerOffsets(true);
				gas.play("gas_move");
				gas.flicker( -1);
				
				gas_group.add(gas);
				gas.x = x;
				gas.visible = false;
				gas.y = y;
				Registry.subgroup_gas.push(gas);	
			}
			
			parent.fg_sprites.add(gas_group);
			
			
			drag.x = drag.y = 30;
			has_tile_callbacks = false;
			health = 3;
			state = s_normal;
			
			add_sfx("move", Registry.sound_data.gasguy_move);
			add_sfx("shoot", Registry.sound_data.gasguy_shoot);
			
			tm_move_sound = 1.5 + Math.random();
		}
		
		private var ticks:int = 0;
		override public function update():void 
		{
			
			t_move_sound += FlxG.elapsed;
			if (t_move_sound > tm_move_sound && visible) {
				t_move_sound = 0;
				play_sfx("move");
			}
			
			if (initial_latency > 0) {
				initial_latency -= FlxG.elapsed;
				return;
			}
			
			if (Registry.is_playstate) {
				if (parent.state != parent.S_TRANSITION) {
					EventScripts.prevent_leaving_map(parent, this);
				}
			}
			
			var gas:FlxSprite;
			
			ticks += 1;
			for each (gas in gas_group.members) {
				
				//broom reduces gas lifepan
				if (ticks == 3) {
					if (player.broom.visible && player.broom.overlaps(gas)) {
						gas.alpha -= 0.025;
					}
					gas.alpha -= 0.003;
				}
				//use sin table or dont dum
			//	gas.scale.x = 1 + 0.25*Math.sin(12 * (t / tm));
			//	gas.scale.y = 1 + 0.25*Math.sin(6 * (t / tm));
				if (gas.alpha > 0.3 && gas.visible && gas.overlaps(player)) {
					player.sig_reverse = true;
				}
			}
			if (ticks == 3) ticks = 0;
			
			if (state == s_dead) return;
			
			EventScripts.send_property_to(this, "x", player.x, 0.2);
			EventScripts.send_property_to(this, "y", player.y, 0.2);
			
			if (!flickering && player.broom.visible && player.broom.overlaps(this)) {
				health--;
				play_sfx(HURT_SOUND_NAME);
				flicker(0.5);
				if (health <= 0) state = s_dying;
				var p:Point = new Point(player.x, player.y);
				var _p:Point = new Point(x, y);
				EventScripts.scale_vector(p, _p, velocity, 100);
			} 
			
			if (player.overlaps(this)) {
				if (state != s_dead) {
					player.touchDamage(1);
				}
			}
			
			
			
			//wait a bit befoore shooting again
			if (state == s_normal) {
				t += FlxG.elapsed;
			
				if (t > tm) {
					state = s_shoot_latency;
					play("release_gas");
					t = 0;
				}
			} else if (state == s_shoot) {
				var p1:Point = new Point(player.x, player.y);
				var _p1:Point = new Point(x, y);
				for each (gas in gas_group.members) {
					EventScripts.scale_vector(_p1, p1, gas.velocity, 30);
					gas.visible = true;
					gas.x = x;
					gas.y = y;
					play_sfx("shoot");
					gas.velocity.x += ( -10 + 20 * Math.random());
					gas.velocity.y += ( -10 + 20 * Math.random());
					gas.alpha = 0.8;
				}
				state = s_normal;
				play("float");
				
			} else if (state == s_shoot_latency) {
				t += FlxG.elapsed;
				if (t > tm_shoot_latency) {
					t = 0;
					state = s_shoot;
				}
			} else if (state == s_dying) {
				Registry.GRID_ENEMIES_DEAD++;

				EventScripts.drop_big_health(x, y, 0.6);
				EventScripts.make_explosion_and_sound(this);

				xml.@alive = "false";
				state = s_dead;
				alive = false;
				visible = false;
			} 
			
			super.update();
		}
		
	}

}
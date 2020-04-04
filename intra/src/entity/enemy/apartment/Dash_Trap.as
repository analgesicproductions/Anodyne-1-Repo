package entity.enemy.apartment 
{
	import data.CLASS_ID;
	import entity.gadget.Dust;
	import entity.gadget.Switch_Pillar;
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
	public class Dash_Trap extends FlxSprite 
	{
		
		[Embed (source = "../../../res/sprites/enemies/apartment/dash_trap.png")] public static var dash_trap_sprite:Class;
		private var xml:XML;
		private var player:Player;
		private var parent:*;
		
		public var state:int = 0;
		private var s_idle:int = 0;
		private var s_moving:int = 1;
		private var s_retracting:int = 2;
		
		private var idle_pt:Point = new Point;
		private var dash_vel:int = 80;
		private var h_sight:FlxSprite = new FlxSprite();
		private var v_sight:FlxSprite = new FlxSprite();
		
		private var retract_vel:Point = new Point();
		
		public var cid:int = CLASS_ID.DASHTRAP;
		
		private var frame_type:int = 0;
		private var t_normal:int = 0;
		private var t_bounce_v:int = 2;
		private var t_bounce_h:int = 1;
		
		private var ctr:int = 0;
		
		private var did_init:Boolean = false;
		
		public function Dash_Trap(_x:XML, _p:Player, _pa:*)
		{
			
			xml = _x;
			player = _p;
			parent = _pa;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			/* Dash Trap anims */
			makeGraphic(16, 16, 0xff594312);
			if (Registry.BOI && Registry.CURRENT_MAP_NAME == "REDCAVE") {
				addAnimation("idle", [6], 12); //when still
				addAnimation("dash", [6], 12, false); //when beginning to move 
				addAnimation("bounce", [6], 12, false); //when hitting anything
			} else {
				addAnimation("idle", [4], 12); //when still
				addAnimation("dash", [5], 12, false); //when beginning to move 
				addAnimation("bounce", [4, 5], 12, false); //when hitting anything
			}
			play("idle");
			loadGraphic(dash_trap_sprite, true, false, 16, 16);
			
			
			h_sight.makeGraphic(320, 10, 0xff114411);
			h_sight.x = x - 160;
			h_sight.y = y + 3 + Registry.HEADER_HEIGHT;
			v_sight.makeGraphic(14, 320, 0xff441144);
			v_sight.x = x + 1;
			v_sight.y = y - 160 + Registry.HEADER_HEIGHT;
			
			Registry.subgroup_dash_traps.push(this);
			
			width = height = 14;
			centerOffsets(true);
			idle_pt.x = x;
			idle_pt.y = y + Registry.HEADER_HEIGHT;
			
			parent.bg_sprites.add(h_sight);
			parent.bg_sprites.add(v_sight);
			h_sight.visible = v_sight.visible = false;
			
			add_sfx("dash", Registry.sound_data.slasher_atk);
			add_sfx("hit", Registry.sound_data.shieldy_ineffective);
			
		}
		
		private var ticker:int = 0;
		override public function preUpdate():void 
		{
			ticker += 1;
			if (ticker == 3) {
				FlxG.collide(this, parent.curMapBuf);
				ticker = 0;
			}
			super.preUpdate();
		}
			
		override public function update():void 
		{
			
			
			if (Registry.is_playstate) {
				if (parent.state != parent.S_TRANSITION) {
					if (!did_init) {
						did_init = true;
						if (parseInt(xml.@frame) > 0) {
							play("dash");
							frame_type = parseInt(xml.@frame);
							switch (frame_type) {
								case t_bounce_h:
									state = s_moving;
									velocity.x = dash_vel;
									break;
								case t_bounce_v:
									state = s_moving;
									velocity.y = dash_vel;
									break;
								case 6:
									frame_type = 0;
									break;
							}
						}
					} 					
					//EventScripts.prevent_leaving_map(parent, this);
				} else {
					velocity.x = velocity.y = 0;
					return;
				}
			}
			
			if (maybe_bounce()) return;
			
			if (state == s_idle) {
				if (player.overlaps(h_sight)) {
					if (player.x >= x) {
						velocity.x = dash_vel;
						retract_vel.x = -dash_vel / 2;
					} else {
						velocity.x = -dash_vel;
						retract_vel.x = dash_vel / 2;
					}
					play_sfx("dash");
					state = s_moving;
					play("dash");
				} else if (player.overlaps(v_sight)) {
					if (player.y <= y) {
						velocity.y = -dash_vel;
						retract_vel.y = dash_vel / 2;
					} else {
						velocity.y = dash_vel;
						retract_vel.y = -dash_vel / 2;
					}
					state = s_moving;
					play_sfx("dash");
					play("dash");
				}
				if ( player.overlaps(this)) {
					player.touchDamage(1);
				}
			} else if (state == s_moving) {
				if (touching != NONE) {
					play_sfx("hit");
					state = s_retracting;
				}
				
				if (player.state != player.S_AIR && player.overlaps(this)) {
					player.touchDamage(1);
					state = s_retracting;
					play_sfx("hit");
				}
				
				for each (var dashtrap:Dash_Trap in Registry.subgroup_dash_traps) {
					if (dashtrap == null) continue;
					if (dashtrap != this && dashtrap.overlaps(this)) {
						state = s_retracting;
						play_sfx("hit");
					}
				}
				
				for each (var dust:Dust in Registry.subgroup_dust) {
					if (dust == null) continue;
					if (dust.overlaps(this)) {
						play_sfx("hit");
						state = s_retracting;
					}
				}
				
				for each (var sp:Switch_Pillar in Registry.subgroup_switch_pillars) {
					if (sp == null) continue;
					if (sp.overlaps(this) && sp.up_frame == sp.frame) {
						play_sfx("hit");
						state = s_retracting;
					}
				}
				
				if (y > Registry.CURRENT_GRID_Y * 160 + 16 * 9 + 20) {
					play_sfx("hit");
					state = s_retracting;
				}
				
				if (state == s_retracting) {
					
					play("bounce", true);
					velocity.x = retract_vel.x;
					velocity.y = retract_vel.y;
				}
			} else if (state == s_retracting) {
				if (Math.abs(x - idle_pt.x) < 2 && Math.abs(y - idle_pt.y) < 2) {
					state = s_idle;
					play("idle");
					x = idle_pt.x;
					y = idle_pt.y;
					retract_vel.x = retract_vel.y = velocity.y = velocity.x = 0;
				}
				if (player.state != player.S_AIR &&  player.overlaps(this)) {
					player.touchDamage(1);
				}
			}
			super.update();
		}
		
		/** 
		 * Logic for dash traps that bounce back and forth
		 * */
		private function maybe_bounce():Boolean
		{
			if (frame_type > 0) {
				if (!player.invincible && player.overlaps(this) && player.state != player.S_AIR) {
					player.touchDamage(1);
				}
				if (Registry.is_playstate) {
					if (x + width > parent.rightBorder) {
						touching = RIGHT;
					} else if (x < parent.leftBorder) {
						touching = LEFT;
					} else if (y < parent.upperBorder) {
						touching = UP;
					} else if (y + height > parent.lowerBorder) {
						touching = DOWN;
					}
				}
				if (frame_type == t_bounce_h) {
					if (ctr == 0) {
							if (touching == RIGHT) {
								velocity.x = -dash_vel;
								ctr = 1;
								play_sfx("hit");
								play("bounce", true);
							}
					} else {
							if (touching == LEFT) {
								velocity.x =  dash_vel;
								ctr = 0;
								play_sfx("hit");
								play("bounce", true);
							}
					}
				} else if (frame_type == t_bounce_v) {
					if (ctr == 0) {
						if (touching == DOWN) {
							velocity.y = -dash_vel;
							ctr = 1;
								play_sfx("hit");
							play("bounce", true);
						}
					} else {
						if (touching == UP) {
							velocity.y = dash_vel;
							ctr = 0;
								play_sfx("hit");
							play("bounce", true);
						}
					}
				}
				return true;
			} 
			return false;
		}
	}

}
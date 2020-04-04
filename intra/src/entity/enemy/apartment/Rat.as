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
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import org.flixel.system.FlxTile;
	
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Rat extends FlxSprite 
	{
		[Embed (source = "../../../res/sprites/enemies/apartment/rat.png")] public static var rat_sprite:Class;
		
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		
		private var move_vel:int = 40;
		private var lookahead:FlxSprite = new FlxSprite();
		private var pp_off:Point = new Point(0, 0); //pin point for lookahead
		
		public var cid:int = CLASS_ID.RAT;
		
		private var state:int = 0;
		private var s_normal:int = 0;
		private var s_dying:int = 1;
		private var s_dead:int = 2;
		
		private var do_rotations:Boolean = false;
		
		private var hurt_box:FlxSprite = new FlxSprite;
		
		public function Rat(_xml:XML,_player:Player,_parent:*) 
		{
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			solid = false;
			
			loadGraphic(rat_sprite, true, false, 16, 16);
			var o:int = (Registry.CURRENT_MAP_NAME == "TRAIN") ? 6 : 0;
			addAnimation("up", [o+4, o+5], 5);
			addAnimation("down", [o+0, o+1], 5);
			addAnimation("r", [o+2, o+3], 5); //DEFAULT: RIGHT
			addAnimation("l", [o+2, o+3], 5);
			/* Flip this boolean if you want rotations instead of separate right/down/up sprites */
			/* If so, rotations assume that the spritesheet is originally facing DOWN */
			do_rotations = false;
			
			addAnimation("die", [0, 1], 30);
			play("down");
			
			if (parseInt(xml.@frame) == 0) {
				play("down");
				facing = DOWN;
				velocity.y = move_vel;
				
				pp_off.x = 7;
				pp_off.y = 18;
				y -= 20;
			}
			
			width = height = 12;
			centerOffsets(true);
			x += 2;
			y += 2;
			lookahead.makeGraphic(1, 1, 0x00000000);
			lookahead.x = x + pp_off.x;
			lookahead.y = y + Registry.HEADER_HEIGHT + pp_off.y;
			parent.bg_sprites.add(lookahead);
			
			hurt_box.makeGraphic(8, 8, 0xff00000);
			
			add_sfx("move", Registry.sound_data.rat_move);
		}
		
		
		/* Rotate, scale the sprite, change the velocity, and set the right anim */
		private function switch_dir(a:FlxTile, b:Object):void {
			if (do_rotations) {
				angle = (angle + 90) % 360;
			}
			play_sfx("move");
			scale.x = 1;
			switch (facing) {
					case DOWN:
						play("l");
						
						scale.x = -1;
						facing = LEFT;
						pp_off.x = 0;
						pp_off.y = 8; 
						velocity.x = -move_vel;
						velocity.y = 0;
						break;
					case LEFT:
						play("up");
						facing = UP;
						pp_off.x = 8;
						pp_off.y = -2;
						velocity.x = 0;
						velocity.y = -move_vel;
						break;
					case UP:
						play("r");
						facing = RIGHT;
						pp_off.x = 12;
						pp_off.y = 8;
						velocity.x = move_vel;
						velocity.y = 0;
						break;
					case RIGHT:
						play("down");
						facing = DOWN;
						pp_off.x = 8;
						pp_off.y = 15;
						velocity.x = 0;
						velocity.y = move_vel;
						break;
				}
		}
		
		override public function preUpdate():void 
		{
			if (!exists) return;
			
			if (Registry.is_playstate) {
				
				/* Check running into switch pillars */
				for each (var sp:Switch_Pillar in Registry.subgroup_switch_pillars) {
					if (sp == null) continue;
					if (sp.frame == sp.up_frame && sp.overlaps(lookahead)) {
						switch_dir(null, null);
						
					}
				
				}
				
				for each (var dust:Dust in Registry.subgroup_dust) {
					if (dust == null) continue;
				
					if (dust.frame != Dust.EMPTY_FRAME && dust.overlaps(lookahead)) {
						switch_dir(null, null);
					}
				}
				
				for each (var dash_trap:Dash_Trap in Registry.subgroup_dash_traps) {
					if (dash_trap == null) continue;
					if (dash_trap.overlaps(this)) {
						state = s_dying;
					}
				}
				
				/* Check for touching a solid tile to turn right */
				var t:FlxTilemap = parent.curMapBuf;
				var _x:int = (lookahead.x % 160) / 16; //FCK IT
				var _y:int = ((lookahead.y - 20) % 160) / 16; 
				var tile_idx:int = t.getTileByIndex(_y * 10 + _x);
				var tile:FlxTile = t._tileObjects[tile_idx];
				if (tile.callback != null || tile.allowCollisions != NONE) {
					switch_dir(null, null);
				}
			}
			super.preUpdate();
		}
		
		
		override public function update():void 
		{
			lookahead.x = x + pp_off.x;
			lookahead.y = y + pp_off.y;
			if (state == s_normal) {
				if (player.broom.visible && player.broom.overlaps(this)) {
					state = s_dying;
				}
			}  else if (state == s_dying) {
				//play("die");
				//alpha -= 0.025;
				alpha = 0;
				if (alpha == 0) {
					state = s_dead;
					if (parent.state != parent.S_TRANSITION) {
						Registry.GRID_ENEMIES_DEAD++;
						EventScripts.make_explosion_and_sound(this);
						EventScripts.drop_small_health(x, y, 0.5);
					}
				}
				
			}
			
			if (state == s_dead) {
				exists = false;
			}
			
			hurt_box.x = x + 4;
			hurt_box.y = y + 4;
			if (!player.invincible && player.overlaps(hurt_box) && player.state == player.S_GROUND) {
				player.touchDamage(1);
			}
			super.update();
		}
	}

}
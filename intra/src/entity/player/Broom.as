package entity.player 
{
	import entity.gadget.Dust;
    import org.flixel.FlxSprite;
	import org.flixel.FlxG;
    import global.Registry;
    public class Broom  extends FlxSprite
    {
        
        
        /* 
         * @param   root: Who this broom is attached to.
         **/
         
        public var root:Player;
        
        public var horizontal_broom:FlxSprite;
        public var vertical_broom:FlxSprite;
		public var has_dust:Boolean = false;
		public var dust:Dust;
		public var just_released_dust:Boolean = false;
		
		public var is_wide:Boolean = false;
		public var is_long:Boolean = false;
		
		public var long_attack_v:FlxSprite = new FlxSprite();
		public var wide_attack_v:FlxSprite = new FlxSprite();
		public var long_attack_h:FlxSprite = new FlxSprite();
		public var wide_attack_h:FlxSprite = new FlxSprite();
		
		private var WATK_W:int = 24;
		private var WATK_H:int = 12;
		private var LATK_W:int = 12;
		private var LATK_H:int = 22;
		
		public var visible_timer:Number = 0;
		
		private var is_behind_player:Boolean = false;
		
		private var just_played_extra_anim:Boolean = false;
		
		
		public var locked:Boolean; //When the player is holding attack, broom should not switch directions.
        [Embed(source = "../../res/sprites/inventory/broom.png")] public static var Broom_Sprite:Class;
        [Embed(source = "../../res/sprites/inventory/knife.png")] public static var Knife_Sprite:Class;
		[Embed(source = "../../res/sprites/broom_cell.png")] public static var Cell_Sprite:Class;
		[Embed (source = "../../res/sprites/inventory/broom-icon.png")] public static var Icon_Broom_Sprite:Class;
		[Embed (source = "../../res/sprites/inventory/wide_attack_h.png")] public static var Wide_Attack_h:Class;
		[Embed (source = "../../res/sprites/inventory/long_attack_h.png")] public static var Long_Attack_h:Class;
		[Embed (source = "../../res/sprites/inventory/wide_attack_v.png")] public static var Wide_Attack_v:Class;
		[Embed (source = "../../res/sprites/inventory/long_attack_v.png")] public static var Long_Attack_v:Class;
        public function Broom(_root:Player, _x:int, _y:int) {
            root = _root;
            x = root.x- 10;
            y = root.y;
			loadGraphic(Broom_Sprite, true, true, 16, 16);
		
			addAnimation("stab", [1, 2,2,1,0,0], 20, false);
			addAnimation("stab2", [4, 5,5,4,3,9], 20, false);
			addAnimation("stab3", [7 , 8, 8, 7, 6, 9], 20, false);
			
			wide_attack_h.loadGraphic(Wide_Attack_h, true, false, WATK_W,WATK_H);
			wide_attack_v.loadGraphic(Wide_Attack_v, true, false, WATK_H,WATK_W);
			long_attack_h.loadGraphic(Long_Attack_h, true, false, LATK_H,LATK_W);
			long_attack_v.loadGraphic(Long_Attack_v, true, false, LATK_W, LATK_H);
			
			// Add lots of blank frames to the end of the animation. It is a hack to
			// avoid complexity in the code.
			
			//ASSUMES THAT LONG ATTACK FACES LEFT/UP BY DEFAULT
			//ASSUMES THAT WIDE ATTACK FACES LEFT/UP BY DEFAULT
			wide_attack_h.addAnimation("a", [0,1,2,3,4], 14, false);
			wide_attack_v.addAnimation("a", [0,1,2,3,4], 14, false);
			long_attack_h.addAnimation("a", [0,1,2,3,4], 14, false);
			long_attack_v.addAnimation("a", [0,1,2,3,4], 14, false);
        }
        
		public function is_active():Boolean {
			if (frame == 0) {
				return false;
			} 
			return true;
		}
		
		override public function draw():void 
		{
			super.draw();
		}
		override public function update():void {
			
				if (!has_dust && dust != null) {
					dust = null;
				}
				if (finished) {
					visible = false;
				} 
				/* Hack to get around bug where broom gets "stuck" visible,
				 * I can't reprodue.... */
				if (visible) {	
					visible_timer += FlxG.elapsed;
					// needs to be long enough to ensure the broom makes a full anim
					if (visible_timer > 0.4) {
						long_attack_h.visible = long_attack_v.visible = visible = false;
						wide_attack_h.visible = wide_attack_v.visible = false;
					}
				} else {
					visible_timer = 0;
				}
				
				
				if (Registry.bound_effect == Registry.item_names[Registry.IDX_WIDEN]) {
					is_wide = true;
					is_long = false;
				} else if (Registry.bound_effect == Registry.item_names[Registry.IDX_LENGTHEN]) {
					is_wide = false;
					is_long = true;
				} else {
					is_wide = is_long = false;
				}
				if (Registry.CURRENT_MAP_NAME == "TRAIN" || Registry.CURRENT_MAP_NAME == "SUBURB") {
					is_wide = is_long = false;
				}
				
				wide_attack_h.visible = false;
				long_attack_h.visible = false;
				wide_attack_v.visible = false;
				long_attack_v.visible = false;
				offset.y = offset.x = 0;
				offset.y = -root.framePixels_y_push;
				width = height = 16;
				
				
				if (!finished) {
					wide_attack_v.scale.x = 1;
					wide_attack_h.scale.y = 1;
					long_attack_h.scale.x = 1;
					long_attack_v.scale.y = 1;
					
					
					
					if (root.facing == LEFT) {
						angle = 0;
						x = root.x - 14; y = root.y ;
						
						if (is_wide && visible) {
							y -= 6;
							offset.y = -6;
							if (!just_played_extra_anim) {
								wide_attack_v.play("a", true);
							}
							wide_attack_v.visible  = true;
							wide_attack_v.x = x;
							wide_attack_v.y = y;
							this.width = WATK_H;
							this.height = WATK_W;
							
							
						} else if (is_long && visible) { 
							x -= 11;
							offset.x = -11;
							if (!just_played_extra_anim) long_attack_h.play("a",true);
							long_attack_h.visible = true;
							long_attack_h.x = x;
							long_attack_h.y = y;
							this.width = LATK_H;
							this.height = LATK_W;
						}
				
						switch (frame) {
							case 0: x += 10; break;
							case 1: x += 6; break;
							case 2: x -= 1; break;
						}
					} else if (root.facing == RIGHT) {
						angle = 180;
						x = root.x + root.width; y = root.y - 2;
						if (is_wide && visible) {
							x += 4;
							y -= 6;
							offset.x = 4;
							offset.y = -6;
							wide_attack_v.scale.x = -1;
							if (!just_played_extra_anim) wide_attack_v.play("a",true);
							wide_attack_v.x = x;
							wide_attack_v.y = y + 2;
							wide_attack_v.visible = true;
							this.width = WATK_H;
							this.height = WATK_W;
						} else if (is_long && visible) {
							x += 6;
							offset.x = 6;
							long_attack_h.scale.x = -1;
							if (!just_played_extra_anim) long_attack_h.play("a",true);
							long_attack_h.visible = true;
							long_attack_h.x = x;
							long_attack_h.y = y + 2;
							this.width = LATK_H;
							this.height = LATK_W;
							
						}
						
						switch (frame) {
							case 0: x -= 12; break;
							case 1: x -= 8; break;
							case 2: x -= 1; break;
						}
					} else if (root.facing == UP) {
						angle = 90;
						x = root.x - 2; y = root.y - 16;
						x = int(x);
						y = int(y);
						if (is_wide && visible) {
							x -= 2;
							offset.x = -2;
							if (!just_played_extra_anim) wide_attack_h.play("a",true);
							wide_attack_h.x = x - 1;
							wide_attack_h.y = y;
							wide_attack_h.visible = true;
							this.width = WATK_W;
							this.height = WATK_H;
							
						} else if (is_long && visible) {
							y -= 9;
							offset.y = -9;
							x += 3;
							offset.x = 3;
							if (!just_played_extra_anim) long_attack_v.play("a",true);
							long_attack_v.x = x;
							long_attack_v.y = y;
							long_attack_v.visible = true;
							width = LATK_W;
							height = LATK_H;
						}
						switch (frame) {
							case 0: y += 12; break;
							case 1: y += 6; break;
							case 2: y += 2; break;
						}
					} else if (root.facing == DOWN) {
						angle = 270;
						x = root.x - 6; y  = root.y + root.height;
						if (is_wide && visible) {
							x -= 2;
							y += 4;
							offset.y = 4;
							offset.x = -2;
							wide_attack_h.scale.y = -1;
							if (!just_played_extra_anim) wide_attack_h.play("a",true);
							wide_attack_h.x = x -2;	
							wide_attack_h.y = y;
							wide_attack_h.visible = true;
							this.width = WATK_W;
							this.height = WATK_H;
						} else if (is_long && visible) {
							long_attack_v.scale.y = -1;
							if (!just_played_extra_anim) long_attack_v.play("a",true);
							long_attack_v.x = x;
							long_attack_v.y = y;
							long_attack_v.visible = true;
							width = LATK_W;
							height = LATK_H;
						}
						switch (frame) {
							case 0: y -= 8; break;
							case 1: y -= 5; break;
							case 2: y -= 2; break;
						}
					}
					
					
					if (!just_played_extra_anim && visible && (is_long || is_wide)) {
						just_played_extra_anim = true;
					}
				} else {
					just_played_extra_anim = false;
				}
				
				switch (root.facing) {
					case LEFT: case UP:
						if (! is_behind_player) { 
							flip_player_broom_draw_order(ANY);
						}
						break;
					default:
						if (is_behind_player) {
							flip_player_broom_draw_order(NONE);
						}
						break;
				}
                   
				
            super.update();
        }
		
		/**
		 * Moves the broom upgrades to right above the broom ased on bidx
		 * @param	bidx
		 */
		private function move_upgrades():void {
			var pgm:Array = Registry.GAMESTATE.player_group.members;
			var idx:int = pgm.indexOf(wide_attack_h);
			pgm.splice(idx, 4); // Delete thingy
			var bidx:int = pgm.indexOf(this);
			pgm.splice(bidx + 1, 0, wide_attack_h, wide_attack_v, long_attack_h, long_attack_v);
		}
		private function flip_player_broom_draw_order(dir:uint):void {
			// player  		 Broom
			// foot   <->    player
			// Broom   			foot
			is_behind_player = !is_behind_player;
			var player_group_members:Array = Registry.GAMESTATE.player_group.members;
			var player_idx:int = player_group_members.indexOf(root);
			var broom_idx:int = player_group_members.indexOf(this);
			var foot_overlay_idx:int = player_group_members.indexOf(root.foot_overlay);
			if (dir == ANY) { // left, up
				player_group_members[player_idx] = this;
				player_group_members[broom_idx] = root.foot_overlay;
				player_group_members[foot_overlay_idx] = root;
				move_upgrades();
			} else { // right, down
				player_group_members[broom_idx] = root;
				player_group_members[player_idx] = root.foot_overlay;
				player_group_members[foot_overlay_idx] = this;
				move_upgrades();
			}
			
			// flip reflections too!
			if (root.reflection.exists) {
				var reflect_broom_idx:int = Registry.GAMESTATE.members.indexOf(root.reflection_broom);
				var reflect_idx:int = Registry.GAMESTATE.members.indexOf(root.reflection);
				
					Registry.GAMESTATE.members[reflect_broom_idx] = root.reflection;
					Registry.GAMESTATE.members[reflect_idx] = root.reflection_broom;
			}
			
		}
    }

}
package entity.enemy.suburb 
{
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.AnoSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	

	public class Suburb_Walker extends AnoSprite 
	{
		[Embed(source = "../../../res/sprites/enemies/suburb/suburb_walker.png")] public static var embed_suburb_walker:Class;
		[Embed(source = "../../../res/sprites/npcs/suburb_walkers.png")] public static var embed_suburb_folk:Class;
		[Embed(source = "../../../res/sprites/npcs/suburb_killers.png")] public static var embed_suburb_killer:Class;
		
		
		private var s_alive:int = 0;
		private var s_dead:int = 1;
		
		private var t_walk:Number = 0;
		private var tm_walk:Number = 1.0;
		private var walk_vel:int = 20;
		
		public var active_region:FlxObject;
		
		private var dialogue_choices:int;
		private var blood:FlxSprite;
		private var dialogue_scene_name:String;
		private var ropes:FlxGroup;
		
		private var is_talker:Boolean = false;
		private var talker_nr:int = 1;
		public function Suburb_Walker(args:Array)
		{
			super(args);
			
			// MARINA_ANIMS
			// will add gender sprite later
			loadGraphic(embed_suburb_folk, true, false, 16, 16);
			var off:int = parseInt(xml.@frame);
			var w:int = 9;
			off *= w;
			state = s_alive;
			immovable = true;
			tm_walk = 1.0 + Math.random();
			
			active_region = new FlxObject(0, 0, 22, 22);
			
			if (xml.@alive == "false") {
				play("dead");
				state = s_dead;
				
				
				Registry.subgroup_interactives.push(this);
			}
			
			blood = new FlxSprite;
			blood.loadGraphic(embed_suburb_folk, true, false, 16, 16);
			blood.addAnimation("a", [63,64,65,66], 3, false);
			blood.visible = false;
			
			if (state == s_dead) {
				blood.x = x - 3 + 6 * Math.random();
				blood.y = y - 3 + 6 * Math.random();
				blood.play("a");
				blood.visible = true;
			}
			
			parent.bg_sprites.add(blood);
			
			gx = Registry.CURRENT_GRID_X;
			gy = Registry.CURRENT_GRID_Y;
			if (parseInt(xml.@frame) == 12) {
				Registry.subgroup_interactives.push(this);
				is_talker = true;
				talker_nr = 1;
				var first_anim:String = "walk_d";
				if (gx == 1 && gy == 5) { // Paranoid Guy (74)
					off = 0;
				} else if (gx == 3 && gy == 5) { // Younger kid in family house
					off = 4 * w;
				} else if (gx == 4 && gy == 5 ) { // Older kid in family house
					off = 2 * w;
				} else if (gx == 0 && gy == 7) { // dead mom
					off = w;
					first_anim = "dead";
				} else if (gx == 1 && gy == 7) { // dead dad
					off = 0;
					first_anim = "dead";
				} else if (gx == 1 && gy == 6) { // Hanged guy
					// Do weird stuff with the rope
					ropes = new FlxGroup(3);
					for (var r:int = 0; r < 3; r++) {
						var rope:FlxSprite = new FlxSprite(x, y - 16 * (r + 1));
						rope.loadGraphic(embed_suburb_folk, true, false, 16, 16);
						rope.frame = 55;
						ropes.add(rope);
					}
					parent.fg_sprites.add(ropes);
					addAnimation("hang", [54], 2);
					off = 0;
					first_anim = "hang";
				} else if (gx == 0 && gy == 6) { // festive person
					off = 0;
					frame = 4; 
				}
				add_the_anims(off,false);
				play(first_anim);
			} else if (parseInt(xml.@frame) == 14) {
				Registry.subgroup_interactives.push(this);
				is_talker = true;
				talker_nr = 2;
				if (gx == 3 && gy == 5) { // prarent in family house
					frame = 4;
					off = w;
					add_the_anims(off,false);
					play("walk_d");
				}
			} else {
				add_the_anims(off);
				play("walk_d");
			}
			
			if (state == s_dead) {
				play("dead");
			}
			
			
			if (off/w < 2) {
				dialogue_scene_name = DH.scene_suburb_walker_words_adult;
			} else if (off / w < 4) {
				dialogue_scene_name = DH.scene_suburb_walker_words_teen;
			} else {
				dialogue_scene_name = DH.scene_suburb_walker_words_kid;
			}
			dialogue_choices = DH.get_scene_length(DH.name_suburb_walker, dialogue_scene_name);
			
			
		}
		override public function preUpdate():void 
		{
			if (state != s_dead) {
				FlxG.collide(player, this);
				immovable = false;
				FlxG.collide(parent.curMapBuf, this);
				immovable = true;
			}
			super.preUpdate();
		}
		override public function update():void 
		{
			active_region.x = x - 3;
			active_region.y = y - 3;
			
			if (is_talker) {
				update_talker();
				super.update();
				return;
			}
			if (state == s_alive) {
				if (player.broom.visible && player.broom.overlaps(this)) {
					play("die");
					Registry.sound_data.broom_hit.play();
					Registry.Event_Nr_Suburb_Killed++;
					state = s_dead; 
					Registry.sound_data.fall_in_hole.play();
					velocity.x = velocity.y = 0;
					xml.@alive = "false";
					Registry.subgroup_interactives.push(this);
					return;
				}		
				
				t_walk += FlxG.elapsed;
				
				if (x + width > tl.x + 155 || x < tl.x + 5 || y + height > tl.y + 155 || y < tl.y + 5) {
					t_walk = tm_walk + 1;
					if (x + width > tl.x + 155) x = tl.x + 155 - width;
					if (x < tl.x + 5) x = tl.x + 6;
					if (y + height > tl.y + 155) y = tl.y + 155 - height;
					if (y < tl.y + 5) y = tl.y + 6;
				}
				if (t_walk > tm_walk) {
					t_walk = 0;
					if (facing & DOWN) {
						play("walk_r");
					} else if (facing & RIGHT) {
						play ("walk_u");
					} else if (facing & LEFT) {
						play("walk_d");
					} else {
						play("walk_l");
					}
					
				}
				if (touching && player.touching == NONE) {
					t_walk = tm_walk + 1;
				}
			} else if (state == s_dead) {
				velocity.x = velocity.y = 0;
				if (blood.frame == 66 && player.overlaps(active_region) && Registry.keywatch.JP_ACTION_1) {
					DH.start_dialogue(DH.name_suburb_walker, dialogue_scene_name, "", int(Math.random() * dialogue_choices));
					player.be_idle();
					
				}
				if (finished) {
					if (_curAnim.name == "die" && _curAnim.frames.length - 1 == _curFrame) {
						Registry.sound_data.player_hit_1.play();
						play("dead");
						blood.x = x - 3 + 6 * Math.random();
						blood.y = y - 3 + 6 * Math.random();
						blood.play("a");
						blood.visible = true;
					}
				}
			}
			super.update();
		}
		
		private var talker_state:int = 0;
		private function update_talker():void {
			if (talker_state == 0) {
				if (DH.a_chunk_is_playing() == false) {
					talker_state = 1;
				}
			} else if (talker_state == 1) {
				if (player.state == player.S_GROUND && player.overlaps(active_region) && Registry.keywatch.JP_ACTION_1) {
					talker_state = 0;
					
					if (talker_nr == 2) {
						if (gx == 3 && gy == 5) { // Mom in family
							EventScripts.face_and_play(this, player, "walk");
							DH.start_dialogue(DH.name_suburb_walker, DH.scene_suburb_walker_family, "", 0);
						}
					} else if (talker_nr  == 1) {
						if (gx == 1 && gy == 5) { // Paranoid Guy (74)
							EventScripts.face_and_play(this, player, "walk");
							DH.start_dialogue(DH.name_suburb_walker, DH.scene_suburb_walker_paranoid);
						} else if (gx == 3 && gy == 5) { // Younger kid in family house 73
							EventScripts.face_and_play(this, player, "walk");
							DH.start_dialogue(DH.name_suburb_walker, DH.scene_suburb_walker_family, "", 1);
						} else if (gx == 4 && gy == 5 ) { // Older kid in family house 73
							EventScripts.face_and_play(this, player, "walk");
							DH.start_dialogue(DH.name_suburb_walker, DH.scene_suburb_walker_older_kid);
						} else if (gx == 0 && gy == 7) { // dead mom 76
							DH.start_dialogue(DH.name_suburb_walker, DH.scene_suburb_walker_dead, "", 0);
						} else if (gx == 1 && gy == 7) { // dead dad 76
							DH.start_dialogue(DH.name_suburb_walker, DH.scene_suburb_walker_dead, "", 1);
						} else if (gx == 1 && gy == 6) { // Hanged guy 78
							DH.start_dialogue(DH.name_suburb_walker, DH.scene_suburb_walker_hanged);
						} else if (gx == 0 && gy == 6) { // festive person 75							
							EventScripts.face_and_play(this, player, "walk");
							DH.start_dialogue(DH.name_suburb_walker, DH.scene_suburb_walker_festive);
						}
					}
					player.be_idle();
					
				}
			}
		}
		private function on_anim_change(name:String, frame:int, index:int):void {
			velocity.x = velocity.y = 0;
			if (name == "walk_d") {
				facing = DOWN;
				velocity.y = walk_vel;
			} else if (name == "walk_u") {
				facing = UP;
				velocity.y = -walk_vel;
			} else if (name == "walk_r") {
				facing = RIGHT;	
				velocity.x = walk_vel;
			} else if (name == "walk_l") {
				facing = LEFT;
				velocity.x = -walk_vel;
			}
			
		}
		
		private function add_the_anims(off:int,doeswalk:Boolean=true):void 
		{
			addAnimation("walk_d", [0 + off, 1 + off], 4);
			addAnimation("walk_r", [2 + off, 3 + off], 4);
			addAnimation("walk_u", [4 + off, 5 + off], 4);
			addAnimation("walk_l", [6 + off, 7 + off], 4);
			addAnimation("die", [0+off,2+off,4+off,6+off,0+off,2+off,4+off,6+off,8+off], 8,false);
			addAnimation("dead", [8 + off]);
			if (true == doeswalk) {
				addAnimationCallback(on_anim_change);
			}
		}
		
		override public function destroy():void 
		{
			active_region.destroy();
			active_region = null;
			super.destroy();
		}
		
	}

}
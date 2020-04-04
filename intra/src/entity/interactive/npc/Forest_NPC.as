package entity.interactive.npc 
{
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.AnoSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	/**
	 * Behaviors of forest sprites, minus mr. bear who is in NPC as a Quest_npc
	 * @author Melos Han-Tani
	 */
	
	
	public class Forest_NPC extends AnoSprite 
	{
		
		private var type:int;
		private var T_LORAX:int = 0;
		private var T_MUSHROOM:int = 1;
		private var T_BUNNY:int = 2;
		private var T_BUNNY_RUN:int = 3;
		public var active_region:FlxSprite;
		
	[Embed(source = "../../../res/sprites/npcs/forest_npcs.png")] public static const embed_forest_npcs:Class;
		
		public function Forest_NPC(a:Array)
		{
			super(a);
			
			loadGraphic(embed_forest_npcs,true,false,16,16);
			
			switch (parseInt(xml.@frame)) {
				case 0:  //Lorax
					type = T_LORAX;
					addAnimation("move", [0, 1], 4);
					addAnimation("stand", [1], 0);
					addAnimation("squat", [0], 0);
					play("move");
					Registry.subgroup_interactives.push(this);
					break;
				case 20: // mushroom
					type = T_MUSHROOM;
					addAnimation("idle", [20], 4);
					addAnimation("move", [20, 21, 20,22,20,21,20,22,20], 8,false);
					play("idle");
					break;
				case 30: // rabbit
					type = T_BUNNY;
					add_bunny_anims(this);
					Registry.subgroup_interactives.push(this);
					break;
				case 34: // Random bunny swap
					type = T_BUNNY_RUN;
					add_bunny_anims(this);
					if (Math.random() < 0.25) {
						var r:Number = Math.random();
						if (r < 0.25) {
							play("walk_d");
						} else if (r < 0.5) {
							play("walk_r");
						} else if (r < 0.75) {
							play("walk_u");
						} else {
							play("walk_l");
						}
					} else {
						exists = false;
					}
					break;
			}
			active_region = new FlxSprite(x - 2, y - 2);
			active_region.makeGraphic(20, 20, 0x00ffffff);
		}
		override public function destroy():void 
		{
			active_region.destroy();
			active_region = null;
			super.destroy();
		}
		override public function update():void 
		{
			active_region.x = x - 2;
			active_region.y = y - 2;
			if (type == T_LORAX) {
				immovable = true;
				FlxG.collide(this, player);
				wait_to_talk(DH.name_forest_npc, DH.scene_forest_npc_thorax);
			} else if (type == T_BUNNY) {
				immovable = true;
				FlxG.collide(this, player);
				wait_to_talk(DH.name_forest_npc, DH.scene_forest_npc_bunny, "walk");
			} else if (type == T_MUSHROOM) {
				immovable = true;
				FlxG.collide(this, player);
				if (player.broom.visible && player.broom.overlaps(this) && _curAnim.name != "move") {
					play("move");
					Registry.sound_data.play_sound_group_randomly(Registry.sound_data.mushroom_sound_group);
				} else if (_curAnim.name == "move") {
					if (finished) {
						play("idle");
					}
				}
			} else if (type == T_BUNNY_RUN) {
				if (state == 0) {
					if (EventScripts.distance(this, player) < 48) {
						Registry.sound_data.play_sound_group(Registry.sound_data.rat_move);
						state = 1;
						var run_spd:int = 100;
						_curAnim.delay = 1.0 / 14.0;
						if (_curAnim.name == "walk_d") {
							velocity.y = run_spd;
						} else if (_curAnim.name == "walk_r") {
							velocity.x = run_spd;
						} else if (_curAnim.name == "walk_u") {
							velocity.y = -run_spd;
						} else if (_curAnim.name == "walk_l") {
							velocity.x = -run_spd;
						}
					}
				} else {
					if (x < tl.x - 16 || x > tl.x + 160 || y > tl.y + 160 || y < tl.y - 16) {
						exists = false;
					}
				}
			}
			super.update();
		}
		
		private function wait_to_talk(name:String, scene:String,anim_stem:String="",area:String="",pos:int=-1):void {
			if (DH.a_chunk_is_playing() == false && player.overlaps(active_region) && player.state == player.S_GROUND && Registry.keywatch.JP_ACTION_1) {
				DH.start_dialogue(name, scene, area, pos);
				player.be_idle();
				if (anim_stem != "") {
					EventScripts.face_and_play(this, player, anim_stem);
				}
			}
		}
		
		private function add_bunny_anims(s:FlxSprite):void 
		{
			s.addAnimation("walk_d", [30,31], 4, true);
			s.addAnimation("walk_r", [32,33], 4, true);
			s.addAnimation("walk_u", [34,35], 4, true);
			s.addAnimation("walk_l", [36, 37], 4, true);
			s.play("walk_d");
		}
	}

}
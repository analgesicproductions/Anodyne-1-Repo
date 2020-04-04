package entity.interactive.npc 
{
	import entity.decoration.Water_Anim;
	import entity.interactive.NPC;
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.AnoSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	/**
	 * ...
	 * @author Melos Han-Tani
	 */
	public class Happy_NPC extends AnoSprite 
	{
		[Embed(source = "../../../res/sprites/npcs/happy_npcs.png")] public static const embed_happy_npcs:Class;
		private var type:int;
		public var active_region:FlxObject;
		
		private static const T_HOT:int = 0;
		private static const T_DUMP:int = 1;
		private static const T_GOLD:int = 2;
		private static const T_DRINK:int = 3;
		private static const T_BEAUTIFUL:int = 4;
		
		public function Happy_NPC(a:Array)
		{
			super(a);
			loadGraphic(embed_happy_npcs, true, false, 16, 16);
			type = parseInt(xml.@frame);
			
			if (type == 2 || type == 4) { //woman
				addAnimation("walk_d", [0, 1], 4);
				addAnimation("walk_r", [2,3], 4);
				addAnimation("walk_u", [4,5], 4);
				addAnimation("walk_l", [6,7], 4);
				addAnimation("idle_d", [0], 4);
				addAnimation("idle_r", [2], 4);
				addAnimation("idle_u", [4], 4);
				addAnimation("idle_l", [6], 4);
			} else if (type == 18) { // dam like hoover dam DAMN
				if (xml.@alive == "false") {
					exists = false;
				}
				if (Registry.CURRENT_MAP_NAME == "BLUE") {
					loadGraphic(NPC.embed_blue_npcs, true, false, 16, 16);
					addAnimation("fall", [10, 11, 12, 13, 14], 7, false);
					frame = 10;
				} else {
					addAnimation("fall", [18, 19, 20, 21, 22], 7,false);
					frame = 18;
				}
			} else {
				addAnimation("walk_d", [9,10], 4);
				addAnimation("walk_r", [11,12], 4);
				addAnimation("walk_u", [13,14], 4);
				addAnimation("walk_l", [15,16], 4);
				addAnimation("idle_d", [9], 4);
				addAnimation("idle_r", [11], 4);
				addAnimation("idle_u", [13], 4);
				addAnimation("idle_l", [15], 4);
			}
			if (type != 18) {
				play("idle_d");
			}
			active_region = new FlxObject(0, 0, 20, 20);
			Registry.subgroup_interactives.push(this);
		}
		
		override public function update():void 
		{
			if (type == 18) {
				if (alive == false) {
					super.update();
					return;
				}
				if (Registry.CURRENT_MAP_NAME == "HAPPY") {
					 if (Registry.GRID_PUZZLES_DONE >= 1) {
						 play("fall");
						 alive = false;
						 xml.@alive = "false";
						 xml.@p = "2";
					 }
				} else if (Registry.CURRENT_MAP_NAME == "BLUE") {
					if (Registry.GRID_PUZZLES_DONE >= 3) {
						play("fall");
						alive = false;
						 xml.@p = "2";
						xml.@alive = "false";
					}
				}
				super.update();
				return;
			}
			active_region.x = x - 2;
			active_region.y = y - 2;
			
			immovable = true;
			player.solid = true;
			FlxG.collide(parent.curMapBuf,this);
			FlxG.collide(this, player);
			if (DH.nc(player, active_region)) {
				velocity.x = velocity.y = 0;
				EventScripts.face_and_play(this, player, "idle");
				if (type == T_HOT) DH.start_dialogue(DH.name_happy_npc, DH.scene_happy_npc_hot);
				if (type == T_DUMP) DH.start_dialogue(DH.name_happy_npc, DH.scene_happy_npc_dump);
				if (type == T_GOLD) DH.start_dialogue(DH.name_happy_npc, DH.scene_happy_npc_gold);
				if (type == T_DRINK) DH.start_dialogue(DH.name_happy_npc, DH.scene_happy_npc_drink);
				if (type == T_BEAUTIFUL) DH.start_dialogue(DH.name_happy_npc, DH.scene_happy_npc_beautiful);
			}
			
			// Behaviors
			
			if (DH.a_chunk_is_playing() == false) {
				if (type == T_HOT) {
					pace();
				} else if (type == T_DUMP) {
					run();
				} else if (type == T_GOLD) {
					run();
				} else if (type == T_DRINK) {
					run();
				} else if (type == T_BEAUTIFUL) {
					pace();
				}
			} else {
				
				velocity.x = velocity.y = 0;
			}

			super.update();
		}
		
		private var t:Number = 0;
		private var tm:Number = 1.0;
		private var ctr:int = 0;
		private function pace():void {
			t += FlxG.elapsed;
			if (t > tm) {
				t = 0;
				if (ctr == 0) {
					if (Math.random() < 0.5) {
						ctr = 1;
						velocity.x = 20;
						play("walk_r");
					} else { 
						velocity.x = 0;
						random_idle();
					}
					
				} else if (ctr == 1) {
					velocity.x = 0;
					if (Math.random() < 0.5) {
						ctr = 0;
						play("walk_l");
						velocity.x = -20;
					} else {
						random_idle();
						velocity.x = 0;
					}
				}
			}
		}
		
		private function run():void {
			t += FlxG.elapsed;
			if (t > tm) {
				t = 0;
				if (ctr == 0) {
					play("walk_r");
					velocity.x = 40;
					ctr = 1;
				} else {
					play("walk_l");
					velocity.x = -40;
					ctr = 0;
				}
			}
		}
		
		private function random_idle():void {
			var r:Number = Math.random();
			
			if (r < 0.25) {
				play("idle_d");
			} else if (r < 0.5) {
				play("idle_r");
			} else if (r < 0.75) {
				play("idle_u");
			} else {
				play("idle_l");
			}
		}
		
	}

}
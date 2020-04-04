package entity.interactive.npc 
{
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import helper.S_NPC;
	import org.flixel.AnoSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	/**
	 * ...
	 * @author Melos Han-Tani
	 */
	public class Redsea_NPC extends AnoSprite 
	{
		
		private var type:int;
		
		private static const T_HAIR:int = 0;
		private static const T_BOMB:int = 1;
		
		public var active_region:FlxObject;
		
		[Embed(source = "../../../res/sprites/npcs/redsea_npcs.png")] public static const embed_redsea_npcs:Class;
		
		public function Redsea_NPC(a:Array) 
		{
			super(a);
			
			loadGraphic(embed_redsea_npcs, true, false, 16, 16);
			switch (parseInt(xml.@frame)) {
				// ...
				case 0: //hair
					type = T_HAIR;
					addAnimation("walk_d", [0, 1], 4);
					addAnimation("walk_r", [2,3], 4);
					addAnimation("walk_u", [4,5], 4);
					addAnimation("walk_l", [6, 7], 4);
					play("walk_d");
					break;
				case 10: // bomb
					xml.@p = "2";
					if (xml.@alive == "false" ) {
						exists = false;
					}
					type = T_BOMB;
					addAnimation("walk", [10, 11], 4);
					play("walk");
					DH.set_scene_to_pos(DH.name_generic_npc, "bomb", 0);
					break;
			}
			active_region = new FlxObject(0, 0, 20, 20);
			Registry.subgroup_interactives.push(this);
		}
		
		
		private var S_exploding:int = 1;
		private var s_exploded:int = 2;
		private var t:Number = 0;
		private var tm:Number = 1;
		override public function update():void 
		{
			active_region.x = x - 2;
			active_region.y = y - 2;
			immovable = true;
			FlxG.collide(this, player);
			if (type == T_HAIR) {
				EventScripts.face_and_play(this, player, "walk");
				if (DH.nc(player, active_region)) {
					if (S_NPC.check_to_play_second(DH.name_generic_npc, DH.scene_generic_npc_any_first, "REDSEA")) {
						DH.start_dialogue(DH.name_generic_npc, DH.scene_generic_npc_any_second, "REDSEA");
					} else {
						DH.start_dialogue(DH.name_generic_npc, DH.scene_generic_npc_any_first, "REDSEA");
					}
				}
			} else if (type == T_BOMB) {
				
				if (state == s_exploded) {
					visible = false;
					x -= 160;
					y -= 160;
				} else if (state == S_exploding) {
					if (DH.nc(player, active_region)) {
						
						EventScripts.make_explosion_and_sound(this);
						if (player.overlaps(active_region)) {
							player.touchDamage(1);
						}
						state = s_exploded;
						DH.set_scene_to_pos(DH.name_generic_npc, "bomb", 0);
					}
				} else {
					if (DH.scene_is_finished(DH.name_generic_npc, "bomb") ){
						state = S_exploding;
						xml.@alive = "false";
					}
					if (DH.nc(player, active_region)) {
						if (DH.scene_is_finished(DH.name_generic_npc, "bomb")) {
							// Explode
						} else {
							DH.start_dialogue(DH.name_generic_npc, "bomb");
						}
					}
				}
			}
			super.update();
		}
		
	}

}
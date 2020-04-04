package entity.interactive.npc 
{
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
	
	public class Space_NPC extends AnoSprite 
	{
		[Embed(source = "../../../res/sprites/npcs/space_npcs.png")] public static var embed_space_npc:Class;
		private var type:int;
		public var active_region:FlxObject;
		private const T_COLOR_DEAD:int = 0;
		private const T_GREY_DEAD:int = 1;
		private const T_GREY_SPIN:int = 2;
		private const T_COLOR1:int = 3;
		private const T_COLOR2:int = 4;
		private const T_COLOR3:int = 5;
		private const T_GRAY1:int = 6;
		private const T_GRAY2:int = 7;
		private const T_GRAY3:int = 8;
		
		
		public function Space_NPC(a:Array) 
		{
			super(a);
			
			active_region = new FlxObject(0, 0, 20, 20);
			Registry.subgroup_interactives.push(this);
			loadGraphic(embed_space_npc, true, false, 16, 16);
			var f:int = parseInt(xml.@frame);
			switch (f) {
				case 0: //gray geom
				case 1:
				case 3:
					if (f == 0) {
						type = T_GRAY1;
					} else if (f == 3) {
						type = T_GRAY3;
					} else {
						type = T_GRAY2;
					}
					addAnimation("walk_d", [0, 1], 4);
					addAnimation("walk_r", [2,3], 4);
					addAnimation("walk_u", [4,5], 4);
					addAnimation("walk_l", [6, 7], 4);
					play("walk_d");
					break;
				case 2:
					addAnimation("spin", [0, 2, 4, 6], 10);
					play("spin");
					type = T_GREY_SPIN;
					break;
					
				case 8: // sleeping/dead geom
					alive = false;
					type = T_COLOR_DEAD;
					
					addAnimation("dead", [8], 4);
					play("dead");
					
					break;
				case 10: //color geom
				case 11:
				case 12:
					if (f == 10) {
						type = T_COLOR1;
					} else if (f == 11) {
						type = T_COLOR2;
					} else if (f == 12) {
						type = T_COLOR3;
					}
					addAnimation("walk_d", [10,11], 4);
					addAnimation("walk_r", [12,13], 4);
					addAnimation("walk_u", [14,15], 4);
					addAnimation("walk_l", [16,17], 4);
					play("walk_d");
					break;
				case 18: // sleep color geom
					alive = false;
					type = T_GREY_DEAD;
					addAnimation("dead", [18], 4);
					play("dead");
					break;
			}
		}
		
		override public function update():void 
		{
			immovable = true;
			active_region.x = x - 2;
			active_region.y = y - 2;
			FlxG.collide(this, player);
			
			if (alive) {
				if (type == T_GREY_SPIN) {
					if (DH.nc(player, active_region)) {
						DH.start_dialogue(DH.name_geoms, "grayspin");
					}
				} else if (type == T_GRAY1) {
					if (DH.nc(player, active_region)) DH.start_dialogue(DH.name_geoms,"gray1");
				} else if (type == T_GRAY2) {
					if (DH.nc(player, active_region)) DH.start_dialogue(DH.name_geoms,"gray2");
				} else if (type == T_GRAY3) {
					if (DH.nc(player, active_region)) DH.start_dialogue(DH.name_geoms,"gray3");
				} else if (type == T_COLOR1) {
					if (DH.nc(player, active_region)) DH.start_dialogue(DH.name_geoms,"color1");
				} else if (type == T_COLOR2) {
					if (DH.nc(player, active_region)) DH.start_dialogue(DH.name_geoms,"color2");
				} else if (type == T_COLOR3) {
					if (DH.nc(player, active_region)) DH.start_dialogue(DH.name_geoms,"color3");
				} 
				
				if (type != T_GREY_SPIN) {
					EventScripts.face_and_play(this, player, "walk");
				}
			} else {
				if (DH.nc(player, active_region)) {
					if (type == T_GREY_DEAD) {
						DH.start_dialogue(DH.name_geoms, "graydead");
					} else {
						DH.start_dialogue(DH.name_geoms, "colordead");
					}
				}
			}
			
			super.update();
		}
	}

}
package entity.enemy.etc 
{
	import entity.player.Player;
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Sadbro extends FlxSprite 
	{
		
		public var xml:XML;
		public var p:Player;
		[Embed (source = "../../../res/sprites/npcs/sadman.png")] public static var sadman_sprite:Class;
		
		public var active_region:FlxObject;
		public function Sadbro(_xml:XML,player:Player)
		{
			super(parseInt(_xml.@x), parseInt(_xml.@y));
			xml = _xml;
			loadGraphic(sadman_sprite,true, false, 16, 16);
			addAnimation("a", [0, 1], 2, true);
			play("a");
			immovable = true;
			p = player;
			
			active_region = new FlxObject(x, y, 20, 20);
			
			Registry.subgroup_interactives.push(this);
		}
		
		override public function update():void 
		{
			FlxG.collide(p, this);
			
			active_region.x = x - 2;
			active_region.y = y - 2;
			
			if (p.overlaps(active_region) && p.state == p.S_GROUND) {
				// Don't let player attack/jump
				if (Registry.keywatch.JP_ACTION_1 && Registry.GAMESTATE.state == Registry.GAMESTATE.S_NORMAL ) {
					EventScripts.face_and_play(Registry.GAMESTATE.player, this, "idle");
					// don't let player logic register an attack if player updated after
					Registry.keywatch.JP_ACTION_1 = false;
					//Make sure first things is said
					if (DH.scene_is_dirty(DH.name_sadbro, DH.scene_sadbro_overworld_initial_forced)) {
						// check if visited the bedroom
						if (Registry.GE_States[Registry.GE_Bedroom_Visited]) {
							//If boss dead...
							if (Registry.GE_States[Registry.GE_Bedroom_Boss_Dead_Idx]) {
								DH.start_dialogue(DH.name_sadbro, DH.scene_sadbro_overworld_bedroom_done)
								
							//otherwise...
							} else {
								DH.start_dialogue(DH.name_sadbro, DH.scene_sadbro_overworld_bedroom_not_done);
							}
						} else {
							DH.start_dialogue(DH.name_sadbro, DH.scene_sadbro_overworld_initial_forced);
						}
					} else {
						DH.start_dialogue(DH.name_sadbro, DH.scene_sadbro_overworld_initial_forced);
					}
				}
			}
		
			super.update();
		}
	}

}
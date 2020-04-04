package entity.interactive 
{
	import entity.player.Player;
	import global.Registry;
	import helper.Cutscene;
	import helper.DH;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	/**
	 * Statues that block the ways out of the first 3 dungeons.
	 * If key not picked up, also spawns a key that does a little flashy nimation
	 */
	public class Dungeon_Statue extends FlxSprite 
	{
		
		[Embed (source = "../../res/sprites/npcs/big_statue.png")] public static var statue_bedroom_embed:Class;
		
		public var xml:XML;
		public var parent:*;
		public var player:Player;
		public var active_region:FlxObject;
		public function Dungeon_Statue(_p:Player,_pa:*,_xml:XML) 
		{
			xml = _xml;
			parent = _pa;
			player = _p;
			super(parseInt(xml.@x), parseInt(xml.@y));
			immovable = true;
			active_region = new FlxObject(x, y, 34, 20);
			switch (Registry.CURRENT_MAP_NAME) {
				case "BEDROOM":
					loadGraphic(statue_bedroom_embed, false, false, 32, 48);
					if (Registry.CUTSCENES_PLAYED[Cutscene.Windmill_Opening]) {
						y -= 32;
					}
					break;
				case "REDCAVE":
					loadGraphic(statue_bedroom_embed, false, false, 32, 48);
					frame = 1;
					if (Registry.CUTSCENES_PLAYED[Cutscene.Windmill_Opening]) {
						x += 32;
					}
					break;
					
				case "CROWD":
					loadGraphic(statue_bedroom_embed, false, false, 32, 48);
					frame = 2;
					if (Registry.CUTSCENES_PLAYED[Cutscene.Windmill_Opening]) {
						x += 32;
					}
					break;
			} 
			
			width = 30;
			height = 16;
			offset.x = 1;
			x += 1;
			offset.y = 32;
			y += 32;
			Registry.subgroup_interactives.push(this);
			
		}
		
		override public function update():void 
		{
			active_region.x = x - 2;
			active_region.y = y - 2;
			FlxG.collide(this, player);
			if (player.overlaps(active_region) && Registry.keywatch.JP_ACTION_1) {
				player.be_idle();
				if (Registry.CUTSCENES_PLAYED[Cutscene.Windmill_Opening] == 1) {
					DH.start_dialogue(DH.name_dungeon_statue, DH.scene_dungeon_statue_bedroom_two);
				} else {
					DH.start_dialogue(DH.name_dungeon_statue, DH.scene_dungeon_statue_bedroom_one);
				}
			}
			super.update();
		}
		
		override public function destroy():void 
		{
		
			super.destroy();
		}
		
	}

}
package entity.decoration 
{
	import org.flixel.FlxSprite;
	
	public class Nonsolid extends FlxSprite 
	{
		
		// embed the sprite file into the code.
		[Embed (source = "../../res/sprites/decoration/grass_1.png")] public static var grass_1_sprite:Class;
		[Embed (source = "../../res/sprites/decoration/grass_REDSEA.png")] public static var grass_REDSEA_sprite:Class;
		[Embed (source = "../../res/sprites/decoration/rail.png")] public static var rail_sprite:Class;
		[Embed (source = "../../res/sprites/decoration/rail_NEXUS.png")] public static var rail_NEXUS_sprite:Class;
		[Embed (source = "../../res/sprites/decoration/rail_CROWD.png")] public static var rail_CROWD_sprite:Class;
		
		public function Nonsolid(_xml:XML)
		{
			// When adding one of these to DAME, supply it the image file,
			// the size of one frame, and add the "type" property to the DAME sprite
			// where "type" is some identifier.
			// There's a "Grass_1" sprite in there for an example.
			
			super(parseInt(_xml.@x), parseInt(_xml.@y));
			switch (_xml.@type.toString()) {
				// The word after "case" will be whatever  you put in for "Type" in the DAME file.
				case "Grass_1":
					loadGraphic(grass_1_sprite, true, false, 16, 6); 
					addAnimation("whatever", [0, 1], 10);  //Add animations if you need to.
					play("whatever");
					break; //Don't forget this so the code exits the switch block. one for every case.
				case "Grass_REDSEA":
					loadGraphic(grass_REDSEA_sprite, true, false, 16, 16); 
					play("whatever");
					break;
				case "Rail_1":
					loadGraphic(rail_sprite, true, false, 16, 16); 
					break;
				case "Rail_NEXUS":
					loadGraphic(rail_NEXUS_sprite, true, false, 16, 17); 
					break;
				case "Rail_CROWD":
					loadGraphic(rail_CROWD_sprite, true, false, 16, 22); 
					break;
			}
			
		}
		
		
	}

}
package entity.interactive.npc 
{
	import org.flixel.AnoSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Melos Han-Tani
	 */
	public class Huge_Fucking_Stag extends AnoSprite 
	{
		[Embed(source = "../../../res/sprites/npcs/forest_stag.png")] public static const embed_stag:Class;
		public function Huge_Fucking_Stag(a:Array)
		{
			super(a);
			
			loadGraphic(embed_stag, true, false, 64, 80);
			addAnimation("a", [0, 1, 2], 4);
			play("a");
			if (Math.random() < 0.01 || (FlxG.keys.Q && FlxG.keys.W && FlxG.keys.E)) {
				
			} else {
				exists = false;
			}
		}
		
		override public function update():void 
		{
			super.update();
		}
		
	}

}
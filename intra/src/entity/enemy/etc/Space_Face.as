package entity.enemy.etc 
{
	import entity.interactive.npc.Space_NPC;
	import flash.display.InterpolationMethod;
	import flash.geom.Point;
	import helper.EventScripts;
	import org.flixel.AnoSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Space_Face extends AnoSprite 
	{
		
		
		public var t_dash:Number = 0;
		public var tm_dash:Number;
		
		public var t_calc_angle:Number = 0;
		public var tm_calc_angle:Number = 0.2;
		
		
		public function Space_Face(args:Array) 
		{
			super(args);
			
			loadGraphic(Space_NPC.embed_space_npc,true,false,16,16);
			
			
			dame_frame = parseInt(xml.@frame);
			
			// MARINA_ANIMS (face)
			// Happy
			if (dame_frame == 0) {
				addAnimation("a", [22,23], 6, true);
			// Sad
			} else if (dame_frame == 1) {
				addAnimation("a", [20,21], 6);
			}
			play("a");
			
			tm_dash = 0.5 + 1.5 * Math.random();
		}
		
		override public function update():void 
		{
			if (!did_init) {
				did_init = true;
				parent.sortables.remove(this, true);
				parent.bg_sprites.add(this);
			}
			
			if (EventScripts.time_cond(this,"t_dash","tm_dash")) {
				EventScripts.scale_vector(this, player, velocity, 55); // dash vel
				drag.x = drag.y = 15 + 10 * Math.random();
			}
			
			
			super.update();
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
	}

	
	
}
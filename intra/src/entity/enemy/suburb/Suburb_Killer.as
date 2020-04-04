package entity.enemy.suburb 
{
	import helper.EventScripts;
	import org.flixel.AnoSprite;
	import org.flixel.FlxG;
	public class Suburb_Killer extends AnoSprite 
	{
		
		private const s_idle:int = 0;
		private const s_move:int = 1;
		
		private var t_flip_vel:Number = 0;
		private const tm_flip_vel:Number = 0.5;
		
		
		[Embed(source = "../../../res/sprites/npcs/suburb_killers.png")] public static const embed_suburb_killer:Class;
		public function Suburb_Killer(args:Array)
		{
			super(args);
			
			loadGraphic(embed_suburb_killer, true, false, 16, 16);
			
			var off:int = Math.random() * 6;
			off *= 9;
			addAnimation("idle_d", [off+0], 1);
			addAnimation("idle_r", [off+2], 1);
			addAnimation("idle_u", [off+4], 1);
			addAnimation("idle_l", [off+6], 1);
			
			addAnimation("walk_d", [off,off+1], 4);
			addAnimation("walk_r", [off+2,off+3], 4);
			addAnimation("walk_u", [off+4, off+5], 4);
			addAnimation("walk_l", [off+6, off+7], 4);
			
			play("idle_d");
			
			width = height = 6;
			offset.x = offset.y = 5;
			x += 5;
			y += 5;
		}
		
		override public function preUpdate():void 
		{
			if (state == s_move) {
				FlxG.collide(this, parent.curMapBuf);
			}
			super.preUpdate();
		}
		
		override public function update():void 
		{
			
			switch (state) {
				
				case s_idle:
					EventScripts.face_and_play(this, player, "idle");
					if (EventScripts.distance(player, this) < 36) {
						state = s_move;
					}
					break;
				case s_move:
					EventScripts.face_and_play(this, player, "walk");
					
					t_flip_vel += FlxG.elapsed;
					if (t_flip_vel > tm_flip_vel) {
						t_flip_vel = 0;
						EventScripts.scale_vector(this, player, velocity, 30);
					}
					
					if (player.overlaps(this)) {
						player.touchDamage(6);
					}
					
					break;
				
			}
			super.update();
		}
		
	}

}
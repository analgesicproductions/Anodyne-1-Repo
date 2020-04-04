package entity.enemy.redcave 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import global.Registry;
	import helper.EventScripts;
    import org.flixel.FlxSprite;
    import org.flixel.FlxG;
	/**
     * ...
     * @author seagaia

     */
    public class Mover extends FlxSprite 
    {
        /**
         * 
         * @param	_x duh
         * @param	_y duh
         * @param	target Where the Mover periodically moves toward.
         * @param   _move_timer Latency between dashes
         */
       
        public var move_timer:Number;
        public var move_timer_init:Number;
        public var target:FlxSprite;
		public var cid:int = CLASS_ID.MOVER;
		public var INCREMENTED_REG:Boolean = false;
		public var xml:XML;
        public var player:Player;
		private var parent:*;
		
		[Embed (source = "../../../res/sprites/enemies/redcave/f_mover.png")] public static var mover_sprite:Class;
		
        public function Mover(_x:int, _y:int, _target:FlxSprite, _move_timer:Number,_xml:XML,_p:Player,_parent:*) {
            super(_x, _y);
			
			loadGraphic(mover_sprite, true, false, 16, 16);
			addAnimation("foom", [0,1], 4, false);
			addAnimation("still", [1]);
			addAnimation("die", [0, 1, 2, 1, 2, 1, 2], 12, false);
			play("foom");
			
            move_timer = _move_timer;
            move_timer_init = move_timer;
            target = _target;
            drag.x = 100;
            drag.y = 100;
            xml = _xml;
			
			player = _p;
			parent = _parent;
			
			add_sfx("move", Registry.sound_data.mover_move_group);
			add_sfx("die", Registry.sound_data.mover_die_group);
        }
		
		override public function preUpdate():void 
		{
			FlxG.collide(parent.curMapBuf, this);
			super.preUpdate();
		}
        
		
        override public function update():void {
            
			if (alive) {
				if (move_timer > 0) {
					if (_curAnim.name == "foom" && (_curAnim.frames.length - 1 == _curFrame)) {
						play("still");
					}
					move_timer -= FlxG.elapsed;
				} else {
					play("foom");
					play_sfx("move");
					move_timer = move_timer_init;
					var dx:Number = target.x - x;
					var dy:Number = target.y - y;
					var norm:Number = Math.min(3, 100 / Math.sqrt(dx * dx + dy * dy));
					velocity.x = dx * norm + (-5 + 5*Math.random());
					velocity.y = dy * norm + ( -5 * 5 * Math.random());
				}
			}
				 
			if (!visible) {
				if (!INCREMENTED_REG) {
					INCREMENTED_REG = true;
					Registry.GRID_ENEMIES_DEAD++;
					EventScripts.make_explosion_and_sound(this);
				}
			
			}
            
			// If movers touch a laser they disappear
			if (visible) {
				if (player.overlaps(this)) {
					player.additional_x_vel = velocity.x;
					player.additional_y_vel = velocity.y;
				}
				
				if (_curAnim.name == "die" && (_curAnim.frames.length - 1 == _curFrame)) {
					visible = false;
				}
				
				for each (var l:On_Off_Laser in Registry.subgroup_on_off_lasers) {
					if (l == null) continue;
					if (l.laser.overlaps(this) && l.state == l.s_hurting) {
						if (_curAnim.name  != "die") {
							alive = false;
							play_sfx(HURT_SOUND_NAME);
							play_sfx("die");
						}
						play("die");
					}
				}
			}
        }
        
        
        
    }

}
package entity.enemy.etc 
{
	import data.CLASS_ID;
    import org.flixel.FlxSound;
    import org.flixel.FlxSprite;
    import org.flixel.FlxG;
    import global.Registry;
    import org.flixel.FlxObject;
    public class Wall_Laser extends FlxSprite
    {
        
        //[Embed (source = "../../../res/sprites/enemies/wall_laser.png")] public var Wall_Laser_Sprite:Class;
        [Embed (source = "../../../../../sfx/laser_charge.mp3")] public var Laser_Charge_Sound:Class;
        [Embed (source = "../../../../../sfx/laser_fire.mp3")] public var Laser_Fire_Sound:Class;


        
        public var dir_type:int; //left, right, down, up
        public var local_id:int;
        public var type:String = "Wall_Laser";
        public var is_charging:Boolean = false;
        public var charge_timer:Number = 0;
        public var laser:FlxSprite = new FlxSprite();
        public var sound_state:int = 0;
        public var sound_state_charge:int = 1;
        public var sound_state_fire:int = 2;
        public var soundObj:FlxSound = new FlxSound();
		
		public var cid:int = CLASS_ID.WALL_LASER;

        public function Wall_Laser(_x:int , _y:int, _type:String, _local_id:int ) 
        {
            super(_x , _y);
            local_id = _local_id;
            //FlxG.visualDebug = true;
            if (_type.indexOf("left") != -1) {
                dir_type = FlxObject.LEFT;
                //loadGraphic(Wall_Laser_Sprite, true, false, 16, 16);
                addAnimation("blink", [0, 1], 4, true);
                addAnimation("charge", [1, 2, 1, 3], 6, true);
            }
            laser = new FlxSprite(x - Registry.SCREEN_WIDTH_IN_PIXELS, y);
            laser.makeGraphic(Registry.SCREEN_WIDTH_IN_PIXELS, 16, 0xffffffff);
            laser.visible = false;
            laser.solid = false;
            play("blink");
        }
        
        override public function update():void {
            if (is_charging) {
                play("charge");
                if (sound_state == 0) {
                    sound_state = sound_state_charge;
                    soundObj.loadEmbedded(Laser_Charge_Sound, false);
                    soundObj.play();
                }
                charge_timer += FlxG.elapsed;
            } else {
                play("blink");
            }
            if (charge_timer > 1.5) {
                //BOOM!
                if (sound_state == sound_state_charge) {
                    soundObj.stop();
                    sound_state = sound_state_fire;
                    soundObj.loadEmbedded(Laser_Fire_Sound, false);
                    soundObj.play();
                }
                laser.visible = true;
                if (charge_timer > 3) {
                    charge_timer = 0;
                    sound_state = 0;
                    is_charging = false;
                    laser.visible = false;
                }
            }
            super.update();
        }

        public function touches(sprite:FlxSprite):void {
            if (dir_type == FlxObject.LEFT || dir_type == FlxObject.RIGHT) {
                if (sprite.y > (y - sprite.height) && sprite.y < (y + height)) {
                    is_charging = true;      
                }
            }
        }
    }

}
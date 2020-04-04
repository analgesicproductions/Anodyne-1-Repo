package entity.decoration 
{
	import data.CLASS_ID;
    import org.flixel.FlxSprite;
	/**
     * ...
     * @author seaga
     */
    public class Eye_Light extends FlxSprite
    {
        [Embed(source = "../../res/sprites/decoration/eyelight.png")] public var Eye_Light_Sprite:Class;
        public var type:String = "Eye_Light";
		public var xml:XML;
		public var darkness:FlxSprite;
		public var light:FlxSprite;
		public var cid:int = CLASS_ID.EYE_LIGHT;
		
        public function Eye_Light(x:int,y:int,_xml:XML, _darkness:FlxSprite) 
        {
            super(x, y);   
			xml = _xml;
            loadGraphic(Eye_Light_Sprite, true, false, 16, 16);
            immovable = true;
            addAnimation("glow", [0, 1, 2], 5, true);
            play("glow");
			darkness = _darkness;
			light = new Light(x - 16, y - 36, darkness, Light.T_FIVE_FRAME_GLOW,false,null);
			light.addAnimation("glow", [0, 0, 1, 2, 3, 4, 3, 2, 1, 0, 0, 0], 7, true);
			light.play("glow");
			
        }
		
		
        
    }

}
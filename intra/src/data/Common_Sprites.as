package data 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/* Embedded sprites common to multiple entities, e.g., shadows */
	public  class Common_Sprites 
	{ 	
		/* Normal shadow that is used by bullets and has two animations */
		[Embed (source = "../res/sprites/decoration/shadows/8x8_shadow.png")] public static var shadow_sprite_8_8:Class;
		[Embed(source = "../res/sprites/decoration/SPACE_BG.png")] public static var space_bg:Class;
		[Embed(source = "../res/sprites/decoration/briar_BG.png")] public static var briar_Bg:Class;
		[Embed(source = "../res/sprites/decoration/nexus_bg.png")] public static var nexus_bg:Class;
		
			/* This shadow has 5 frames, and its frame is determined by the fist's y-offset 
			 * (or height)  used by Wallboss fists, and Eyeboss Land form */
		[Embed (source = "../res/sprites/decoration/shadows/28x10_shadow.png")] public static var shadow_sprite_28_10:Class;
		
		
		[Embed(source = "../helper/static.pbj", mimeType = "application/octet-stream")] public static const static_shader:Class;
		
		// OVERLAYS
		
		// 160x160 image, tiled 2x2. No anims.
		[Embed(source = "../res/sprites/decoration/overlays/debug_overlay.png")] public static var debug_overlay:Class;
		[Embed(source = "../res/sprites/decoration/overlays/windmill_overlay.png")] public static var windmill_overlay:Class;
		[Embed(source = "../res/sprites/decoration/overlays/happy_overlay.png")] public static const happy_blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/redsea_overlay.png")] public static const redsea_blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/ending_overlay.png")] public static const ending_blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/forest_overlay.png")] public static const forest_blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/cliff_overlay.png")] public static const cliff_blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/apartment_overlay.png")] public static const apartment_Blend:Class; 
		[Embed(source = "../res/sprites/decoration/overlays/beach_overlay.png")] public static const beach_blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/space_overlay.png")]  public static const space_blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/hotel_overlay.png")] public static const hotel_blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/hotel_roof_overlay.png")] public static const  roof_blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/suburbs_overlay.png")] public static const  suburbs_Blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/bedroom_overlay.png")] public static const  bedroom_Blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/blue_overlay.png")] public static const  blue_blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/circus_overlay.png")] public static const circus_blend:Class;
		
		[Embed(source = "../res/sprites/decoration/overlays/windmill_overlay2.png")] public static const windmill2_Blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/terminal_overlay.png")] public static const  terminal_blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/street_overlay.png")] public static const  street_blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/nexus_overlay.png")] public static const nexus_Blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/crowd_overlay.png")]  public static const  crowd_blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/go_overlay.png")]  public static const  go_blend:Class;
		[Embed(source = "../res/sprites/decoration/overlays/redcave_overlay .png")]  public static const  redcave_blend:Class;
		
		public static var static_map:Bitmap;
		
		public static function init():void {
			static_map = new Bitmap(new BitmapData(320, 320,true,0x00000000));
			var alpha:uint;
			var gray:uint;
			var maxalpha:int = 80;
			var maxgray:int = 80;
			
			for (var i:int = 0; i < 320; i++) {
				for (var j:int = 0; j < 320; j++) {
					alpha = maxalpha * Math.random();
					gray = maxgray * Math.random();
					static_map.bitmapData.setPixel32(j, i, (alpha << 24) | (gray) | (gray << 8) | (gray << 16));
				}
			}
		}
	}

}
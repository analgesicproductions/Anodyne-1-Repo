package entity.decoration 
{
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;
	import org.flixel.FlxSprite;
	
	/**
	 * test
	 * @author Seagaia
	 */
	public class Map_Preview extends FlxSprite 
	{
		
		var erase_mask:FlxSprite = new FlxSprite();
		public function Map_Preview() 
		{
			makeGraphic(16, 16, 0xffff0000);
			erase_mask.makeGraphic(16, 16, 0x00000000);
			for (var i:int = 0; i < 256; i++) {
				if (i % 2 == 0) {
					erase_mask.framePixels.setPixel32(i % 16, i / 16, 0xff000000);
				} else {
					erase_mask.framePixels.setPixel32(i % 16, i / 16, 0x00000000);
				}
			}
			erase_mask.blend = 'erase';
			draw();
		}
		
		override public function draw():void 
		{
			pixels.copyChannel(erase_mask.framePixels, erase_mask.framePixels.rect, new Point, BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
			dirty = true;
			super.draw();			

		}
		
	}

}
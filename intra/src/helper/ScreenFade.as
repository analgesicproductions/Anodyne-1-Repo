package helper 
{
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	
	public class ScreenFade 
	{
		
		public var base:BitmapData;
		public var old:BitmapData;
		public var thing_to_draw:Bitmap;
		public var parent:FlxState;
		
		private var timer:Number;
		public var timer_max:Number;
		private var type:int;
		public var rate:int;
		private var cur:int = 1;
		public static var T_RECT:int = 0;
		public static var T_DS:int = 1; //downsample
		public static var T_US:int = 2; //upsample
		
		public static var DONE:int = 0;
		public static var NOT_DONE:int = 1;
		
		public var width:int = 160;
		public var height:int = 180; //change as needed
		
		public var offset:int = 0;
		public var ADDED_CHILD:Boolean = false;
		public function ScreenFade(width:int,height:int,_parent:FlxState,_type:int) 
		{
			base = new BitmapData(width, height, true,0x00000000);
			old = new BitmapData(width, height, true,0x00000000);
			thing_to_draw  = new Bitmap(base);
			
			type = _type;
			switch (type) {
				case T_RECT:
					FlxG.stage.addChild(thing_to_draw);
					rate = 8;
					timer = timer_max = 0.02;
					break;
				case T_DS:
					rate = 10;
					cur = 1;
					thing_to_draw = new Bitmap(FlxG.camera.buffer);
					timer = timer_max = 0.01;
					break;
				case T_US: 
					rate = 1; //min 
					cur = 10; //start 
					thing_to_draw = new Bitmap(FlxG.camera.buffer);
					timer = timer_max = 0.01;
					break;
			}
			parent = _parent;
		}
		
		public function reset():void {
				if (type == T_DS)  {
					rate = 10;
					cur = 1;
				} else if (type == T_US) {
					rate = 1;
					cur = 10;
				}
				
		}
		
		public function do_effect():int {
			
			timer -= FlxG.elapsed;
			if (timer < 0) {
				timer = timer_max;
				switch (type) {
					case T_RECT:
						return fx_rect(rate); 
						break;
					case T_DS:			
						FlxG.camera.buffer.copyPixels(thing_to_draw.bitmapData, thing_to_draw.bitmapData.rect, thing_to_draw.bitmapData.rect.topLeft);
						cur++;
						return fx_downsample(cur,rate);
						break;
					case T_US:
						FlxG.camera.buffer.copyPixels(thing_to_draw.bitmapData, thing_to_draw.bitmapData.rect, thing_to_draw.bitmapData.rect.topLeft);
						cur--;
						return fx_downsample(cur, rate);
				}
			} else {
				if (type == T_DS) {
					return fx_downsample(cur,rate);
				} else if (type == T_US) {
					return fx_downsample(cur, rate);
				}
				
			}
			return NOT_DONE;
		}
		
		private function fx_rect(rate:int):int {
			
			for (var i:int = offset; i < offset + rate; i++) {
				for (var j:int = 0; j < base.width; j++) {
					base.setPixel32(j, i, 0xff000000);
				}
			}
			offset += rate;
			if (offset >= base.height) return DONE;
			return NOT_DONE;
		}
		
		/*
		 * Downsamples the camera buffer with a from-top-left-square-downsample effect.
		 * This is a post-processing effect. The camera's buffer is copied to thing_to_draw,
		 * then on every iteration it copies a downsampled version on top
		 **/
		private function fx_downsample(stride:int, max:int):int {
			var next_color:uint;
			if (stride < 1) stride = 1; //prevent infinite loop
			for (var y:int = 0; y < height; y += stride) {
				for (var x:int = 0; x < width; x += stride) {
					next_color = thing_to_draw.bitmapData.getPixel32(x,y);
					for (var _x:int = x; _x < x + stride; _x++) {
						for (var _y:int = y; _y < y + stride; _y++) {
							thing_to_draw.bitmapData.setPixel32(_x, _y, next_color);
						}
					}
				}
			}
			FlxG.camera.buffer.copyPixels(thing_to_draw.bitmapData, thing_to_draw.bitmapData.rect, thing_to_draw.bitmapData.rect.topLeft);
			if (type == T_DS) {
				if (stride > max) return DONE;
			} else if (type == T_US) {
				if (stride <= max) return DONE;
			}
			return NOT_DONE;
		}
		
		/* Downsamples buf based on the top-left squares method.
		 * Internal locking of buf. 
		 * This should be called before this buffer gets copied out to
		 * flash. */
		public static function dumsample(stride:int, buf:BitmapData):void {
			
			var next_color:uint;
			buf.lock();
			for (var y:int = 0; y < buf.height; y += stride) {
				for (var x:int = 0; x < buf.width; x += stride) {
					next_color = buf.getPixel32(x,y);
					for (var _x:int = x; _x < x + stride; _x++) {
						for (var _y:int = y; _y < y + stride; _y++) {
							buf.setPixel32(_x, _y, next_color);
						}
					}
				}
			}
			buf.unlock();
		}
		public function destroy():void {
			if (type == T_RECT) {
				FlxG.stage.removeChild(thing_to_draw);
			}
			
			base = old =  null; 
			thing_to_draw = null;
			parent = null
		}
	}

}
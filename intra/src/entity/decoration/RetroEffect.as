/**
 * RetroEffect
 * -- Generates a retro CRT distortion effect on the requested camera.
 * Inspired from the article http://active.tutsplus.com/tutorials/effects/create-a-retro-crt-distortion-effect-using-rgb-shifting/
 * 
 * @version 1.0 - 31st January 2012
 * @link http://www.alanzucconi.com
 * @author Alan Zucconi
*/
package entity.decoration
{
	import flash.display.Bitmap;	
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import org.flixel.FlxCamera;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/** Class to generate a retro CRT distortion effect.
	 * @author Alan Zucconi
	 */
	public class RetroEffect extends FlxSprite
	{
		private static var _zeroPoint:Point = new Point();
		
		/** The camera where the effect should be applied. */
		private static var _camera:FlxCamera;
		/** The buffer where the effect is constructed. */
		private var _buffer : BitmapData;
		/** The buffer where the effect is constructed. */
		private var _output : BitmapData;
		
		private var _bitmap : Bitmap;
		
		/** The counter for the distortion effect. */
		private var _counter : Number = 0;
		/** The matrix to distort the image. */
		private var _distortion : Matrix = new Matrix();
		
		/** Generates a new istance of the retro CTR distortion effect.
		 * @param camera	The camera where the effect should be applied.
		 */
		public function RetroEffect(camera:FlxCamera)
		{
			_camera = camera;
			
			_buffer = new BitmapData(_camera.width, _camera.height, true, 0xFF000000);
			_output = new BitmapData(_camera.width, _camera.height, true, 0xFF000000);
			
			_bitmap = new Bitmap();
			_bitmap.bitmapData = _buffer;
		}
		
		/** Updates the counter. */
		override public function update():void 
		{
			_counter += FlxG.elapsed;
			super.update();
		}
		
		/** Apply the effect. */
		override public function draw ():void
		{
			var output : BitmapData = effect(_camera.screen.pixels);
			_camera.screen.pixels.draw(output);
		}
		
		public function randRange(min:Number, max:Number):Number {
            var randomNum:Number = (Math.random() * (max - min)) + min;
            return randomNum;
        }

		/** Apply the effect on the image.
		 * @param source	The bitamp to change.
		 * @return		The changed bitmap.
		 */
		private function effect (source:BitmapData):BitmapData
		{
			// Red channel ------------------------------------------
			_buffer.fillRect(source.rect, 0xFF000000);
			_buffer.copyChannel(source, source.rect, _zeroPoint, BitmapDataChannel.RED,   BitmapDataChannel.RED  );
			_bitmap.alpha = randRange(8, 10) / 10;
			
			_distortion.a = sinusoid(_counter + 0 / 5, 1.09, 1.2 , 0.5);
			_distortion.d = sinusoid(_counter + 2 / 5, 1, 1.21 , 0.5);
          
			//_distortion.ty = sinusoid(_counter + 0/5, 0, -1 ,0.5)
			_output.draw(_bitmap, _distortion, null, null, null, true);
			
			// Green channel ------------------------------------------
			_buffer.fillRect(source.rect, 0xFF000000);
			_buffer.copyChannel(source, source.rect, _zeroPoint, BitmapDataChannel.GREEN, BitmapDataChannel.GREEN);
			_bitmap.alpha = randRange(8, 10) / 10;
	       
			_distortion.a = sinusoid(_counter + 1 / 5, 0.89, 1.00 , 0.5);
			_distortion.d = sinusoid(_counter + 1 / 5, 1, 1.01 , 0.5);
			//_distortion.ty = sinusoid(_counter + 1/5, 0, -1 ,0.5)
			_output.draw(_bitmap, _distortion, null, BlendMode.SCREEN, null, true);
			
			// Blue channel ------------------------------------------
			_buffer.fillRect(source.rect, 0xFF000000);
			_buffer.copyChannel(source, source.rect, _zeroPoint, BitmapDataChannel.BLUE,  BitmapDataChannel.BLUE );
			_bitmap.alpha = randRange(8, 10)/10;
			
			_distortion.a = sinusoid(_counter + 2 / 5, 0.99, 1.20 , 3.5);
			_distortion.d = sinusoid(_counter + 0 / 5, 1, 1.01 , 3.5);
			//_distortion.ty = sinusoid(_counter + 2/5, 0, -1 ,0.5)
			_output.draw(_bitmap, _distortion, null, BlendMode.SCREEN, null, true);
			
			return _output;
		}
		
		/** Generate a custom sinusoid curve.
		 * @param x		The x value.
		 * @param min		The minimun value of this sinusoid.
		 * @param max		The maximum value of this sinusoid.
		 * @param period	The period of this sinusoid.
		 * @return		The y value.
		 */
		public function sinusoid (x:Number, min:Number, max:Number, periodo:Number) : Number {
			var escursione :Number = max - min;
			var coefficiente :Number = Math.PI * 2 / periodo;
			return escursione / 2 * (1 + Math.sin(x * coefficiente)) + min;
		}
	}
}
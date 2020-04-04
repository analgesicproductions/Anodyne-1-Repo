/**
 * FlxColor
 * -- Part of the Flixel Power Tools set
 * 
 * v1.5 Added RGBtoWebString
 * v1.4 getHSVColorWheel now supports an alpha value per color
 * v1.3 Added getAlphaFloat
 * v1.2 Updated for the Flixel 2.5 Plugin system
 * 
 * @version 1.5 - August 4th 2011
 * @link http://www.photonstorm.com
 * @author Richard Davey / Photon Storm
 * @see Depends upon FlxMath
*/

package org.flixel.plugin.photonstorm
{
	import org.flixel.*;
	
	/**
	 * <code>FlxColor</code> is a set of fast color manipulation and color harmony methods.<br />
	 * Can be used for creating gradient maps or general color translation / conversion.
	 */
	public class FlxColor
	{
		public function FlxColor()
		{
		}
		
		/**
		 * Get HSV color wheel values in an array which will be 360 elements in size
		 * 
		 * @param	alpha	Alpha value for each color of the color wheel, between 0 (transparent) and 255 (opaque)
		 * 
		 * @return	Array
		 */
		public static function getHSVColorWheel(alpha:uint = 255):Array
		{
			var colors:Array = new Array();
			
			for (var c:int = 0; c <= 359; c++)
			{
				colors[c] = HSVtoRGB(c, 1.0, 1.0, alpha);
			}
			
			return colors;
		}
		
		/**
		 * Returns a Complementary Color Harmony for the given color.
		 * <p>A complementary hue is one directly opposite the color given on the color wheel</p>
		 * <p>Value returned in 0xAARRGGBB format with Alpha set to 255.</p>
		 * 
		 * @param	color The color to base the harmony on
		 * 
		 * @return 0xAARRGGBB format color value
		 */
		public static function getComplementHarmony(color:uint):uint
		{
			var hsv:Object = RGBtoHSV(color);
			
			var opposite:int = FlxMath.wrapValue(hsv.hue, 180, 359);
			
			return HSVtoRGB(opposite, 1.0, 1.0);
		}
		
		/**
		 * Returns an Analogous Color Harmony for the given color.
		 * <p>An Analogous harmony are hues adjacent to each other on the color wheel</p>
		 * <p>Values returned in 0xAARRGGBB format with Alpha set to 255.</p>
		 * 
		 * @param	color The color to base the harmony on
		 * @param	threshold Control how adjacent the colors will be (default +- 30 degrees)
		 * 
		 * @return 	Object containing 3 properties: color1 (the original color), color2 (the warmer analogous color) and color3 (the colder analogous color)
		 */
		public static function getAnalogousHarmony(color:uint, threshold:int = 30):Object
		{
			var hsv:Object = RGBtoHSV(color);
			
			if (threshold > 359 || threshold < 0)
			{
				throw Error("FlxColor Warning: Invalid threshold given to getAnalogousHarmony()");
			}
			
			var warmer:int = FlxMath.wrapValue(hsv.hue, 359 - threshold, 359);
			var colder:int = FlxMath.wrapValue(hsv.hue, threshold, 359);
			
			return { color1: color, color2: HSVtoRGB(warmer, 1.0, 1.0), color3: HSVtoRGB(colder, 1.0, 1.0), hue1: hsv.hue, hue2: warmer, hue3: colder }
		}
		
		/**
		 * Returns an Split Complement Color Harmony for the given color.
		 * <p>A Split Complement harmony are the two hues on either side of the color's Complement</p>
		 * <p>Values returned in 0xAARRGGBB format with Alpha set to 255.</p>
		 * 
		 * @param	color The color to base the harmony on
		 * @param	threshold Control how adjacent the colors will be to the Complement (default +- 30 degrees)
		 * 
		 * @return 	Object containing 3 properties: color1 (the original color), color2 (the warmer analogous color) and color3 (the colder analogous color)
		 */
		public static function getSplitComplementHarmony(color:uint, threshold:int = 30):Object
		{
			var hsv:Object = RGBtoHSV(color);
			
			if (threshold >= 359 || threshold <= 0)
			{
				throw Error("FlxColor Warning: Invalid threshold given to getSplitComplementHarmony()");
			}
			
			var opposite:int = FlxMath.wrapValue(hsv.hue, 180, 359);
			
			var warmer:int = FlxMath.wrapValue(hsv.hue, opposite - threshold, 359);
			var colder:int = FlxMath.wrapValue(hsv.hue, opposite + threshold, 359);
			
			FlxG.log("hue: " + hsv.hue + " opposite: " + opposite + " warmer: " + warmer + " colder: " + colder);
			
			//return { color1: color, color2: HSVtoRGB(warmer, 1.0, 1.0), color3: HSVtoRGB(colder, 1.0, 1.0), hue1: hsv.hue, hue2: warmer, hue3: colder }
			
			return { color1: color, color2: HSVtoRGB(warmer, hsv.saturation, hsv.value), color3: HSVtoRGB(colder, hsv.saturation, hsv.value), hue1: hsv.hue, hue2: warmer, hue3: colder }
		}
		
		/**
		 * Returns a Triadic Color Harmony for the given color.
		 * <p>A Triadic harmony are 3 hues equidistant from each other on the color wheel</p>
		 * <p>Values returned in 0xAARRGGBB format with Alpha set to 255.</p>
		 * 
		 * @param	color The color to base the harmony on
		 * 
		 * @return 	Object containing 3 properties: color1 (the original color), color2 and color3 (the equidistant colors)
		 */
		public static function getTriadicHarmony(color:uint):Object
		{
			var hsv:Object = RGBtoHSV(color);
			
			var triadic1:int = FlxMath.wrapValue(hsv.hue, 120, 359);
			var triadic2:int = FlxMath.wrapValue(triadic1, 120, 359);
			
			return { color1: color, color2: HSVtoRGB(triadic1, 1.0, 1.0), color3: HSVtoRGB(triadic2, 1.0, 1.0) }
		}
		
		/**
		 * Returns a String containing handy information about the given color including String hex value,
		 * RGB format information and HSL information. Each section starts on a newline, 3 lines in total.
		 * 
		 * @param	color A color value in the format 0xAARRGGBB
		 * 
		 * @return	String containing the 3 lines of information
		 */
		public static function getColorInfo(color:uint):String
		{
			var argb:Object = getRGB(color);
			var hsl:Object = RGBtoHSV(color);
			
			//	Hex format
			var result:String = RGBtoHexString(color) + "\n";
			
			//	RGB format
			result = result.concat("Alpha: " + argb.alpha + " Red: " + argb.red + " Green: " + argb.green + " Blue: " + argb.blue) + "\n";
			
			//	HSL info
			result = result.concat("Hue: " + hsl.hue + " Saturation: " + hsl.saturation + " Lightnes: " + hsl.lightness);
			
			return result;
		}
		
		/**
		 * Return a String representation of the color in the format 0xAARRGGBB
		 * 
		 * @param	color The color to get the String representation for
		 * 
		 * @return	A string of length 10 characters in the format 0xAARRGGBB
		 */
		public static function RGBtoHexString(color:uint):String
		{
			var argb:Object = getRGB(color);
			
			return "0x" + colorToHexString(argb.alpha) + colorToHexString(argb.red) + colorToHexString(argb.green) + colorToHexString(argb.blue);
		}
		
		/**
		 * Return a String representation of the color in the format #RRGGBB
		 * 
		 * @param	color The color to get the String representation for
		 * 
		 * @return	A string of length 10 characters in the format 0xAARRGGBB
		 */
		public static function RGBtoWebString(color:uint):String
		{
			var argb:Object = getRGB(color);
			
			return "#" + colorToHexString(argb.red) + colorToHexString(argb.green) + colorToHexString(argb.blue);
		}

		/**
		 * Return a String containing a hex representation of the given color
		 * 
		 * @param	color The color channel to get the hex value for, must be a value between 0 and 255)
		 * 
		 * @return	A string of length 2 characters, i.e. 255 = FF, 0 = 00
		 */
		public static function colorToHexString(color:uint):String
		{
			var digits:String = "0123456789ABCDEF";
			
			var lsd:Number = color % 16;
			var msd:Number = (color - lsd) / 16;
			
			var hexified:String = digits.charAt(msd) + digits.charAt(lsd);
			
			return hexified;
		}
		
		/**
		 * Convert a HSV (hue, saturation, lightness) color space value to an RGB color
		 * 
		 * @param	h 		Hue degree, between 0 and 359
		 * @param	s 		Saturation, between 0.0 (grey) and 1.0
		 * @param	v 		Value, between 0.0 (black) and 1.0
		 * @param	alpha	Alpha value to set per color (between 0 and 255)
		 * 
		 * @return 32-bit ARGB color value (0xAARRGGBB)
		 */
		public static function HSVtoRGB(h:Number, s:Number, v:Number, alpha:uint = 255):uint
		{
			var result:uint;
			
			if (s == 0.0)
			{
				result = getColor32(alpha, v * 255, v * 255, v * 255);
			}
			else
			{
				h = h / 60.0;
				var f:Number = h - int(h);
				var p:Number = v * (1.0 - s);
				var q:Number = v * (1.0 - s * f);
				var t:Number = v * (1.0 - s * (1.0 - f));
				
				switch (int(h))
				{
					case 0:
						result = getColor32(alpha, v * 255, t * 255, p * 255);
						break;
						
					case 1:
						result = getColor32(alpha, q * 255, v * 255, p * 255);
						break;
						
					case 2:
						result = getColor32(alpha, p * 255, v * 255, t * 255);
						break;
						
					case 3:
						result = getColor32(alpha, p * 255, q * 255, v * 255);
						break;
						
					case 4:
						result = getColor32(alpha, t * 255, p * 255, v * 255);
						break;
						
					case 5:
						result = getColor32(alpha, v * 255, p * 255, q * 255);
						break;
						
					default:
						FlxG.log("FlxColor Error: HSVtoRGB : Unknown color");
				}
			}
			
			return result;
		}
		
		/**
		 * Convert an RGB color value to an object containing the HSV color space values: Hue, Saturation and Lightness
		 * 
		 * @param	color In format 0xRRGGBB
		 * 
		 * @return 	Object with the properties hue (from 0 to 360), saturation (from 0 to 1.0) and lightness (from 0 to 1.0, also available under .value)
		 */
		public static function RGBtoHSV(color:uint):Object
		{
			var rgb:Object = getRGB(color);
			
			var red:Number = rgb.red / 255;
			var green:Number = rgb.green / 255;
			var blue:Number = rgb.blue / 255;
			
			var min:Number = Math.min(red, green, blue);
            var max:Number = Math.max(red, green, blue);
            var delta:Number = max - min;
            var lightness:Number = (max + min) / 2;
			var hue:Number;
			var saturation:Number;
			
            //  Grey color, no chroma
            if (delta == 0)
            {
                hue = 0;
                saturation = 0;
            }
            else
            {
                if (lightness < 0.5)
                {
                    saturation = delta / (max + min);
                }
                else
                {
                    saturation = delta / (2 - max - min);
                }
                
                var delta_r:Number = (((max - red) / 6) + (delta / 2)) / delta;
                var delta_g:Number = (((max - green) / 6) + (delta / 2)) / delta;
                var delta_b:Number = (((max - blue) / 6) + (delta / 2)) / delta;
                
                if (red == max)
                {
                    hue = delta_b - delta_g;
                }
                else if (green == max)
                {
                    hue = (1 / 3) + delta_r - delta_b;
                }
                else if (blue == max)
                {
                    hue = (2 / 3) + delta_g - delta_r;
                }
                
                if (hue < 0)
                {
                    hue += 1;
                }
                
                if (hue > 1)
                {
                    hue -= 1;
                }
            }
            
			//	Keep the value with 0 to 359
			hue *= 360;
			hue = Math.round(hue);
			
			//	Testing
			//saturation *= 100;
			//lightness *= 100;
			
            return { hue: hue, saturation: saturation, lightness: lightness, value: lightness };
		}
		
        
		
		
		
		
		
		
		public static function interpolateColor(color1:uint, color2:uint, steps:uint, currentStep:uint, alpha:uint = 255):uint
        {
			var src1:Object = getRGB(color1);
			var src2:Object = getRGB(color2);
			
            var r:uint = (((src2.red - src1.red) * currentStep) / steps) + src1.red;
            var g:uint = (((src2.green - src1.green) * currentStep) / steps) + src1.green;
            var b:uint = (((src2.blue - src1.blue) * currentStep) / steps) + src1.blue;

			return getColor32(alpha, r, g, b);
        }
		
        public static function interpolateColorWithRGB(color:uint, r2:uint, g2:uint, b2:uint, steps:uint, currentStep:uint):uint
        {
			var src:Object = getRGB(color);
			
            var r:uint = (((r2 - src.red) * currentStep) / steps) + src.red;
            var g:uint = (((g2 - src.green) * currentStep) / steps) + src.green;
            var b:uint = (((b2 - src.blue) * currentStep) / steps) + src.blue;
        
			return getColor24(r, g, b);
        }
		
        public static function interpolateRGB(r1:uint, g1:uint, b1:uint, r2:uint, g2:uint, b2:uint, steps:uint, currentStep:uint):uint
        {
            var r:uint = (((r2 - r1) * currentStep) / steps) + r1;
            var g:uint = (((g2 - g1) * currentStep) / steps) + g1;
            var b:uint = (((b2 - b1) * currentStep) / steps) + b1;
        
			return getColor24(r, g, b);
        }
		
		/**
		 * Returns a random color value between black and white
		 * <p>Set the min value to start each channel from the given offset.</p>
		 * <p>Set the max value to restrict the maximum color used per channel</p>
		 * 
		 * @param	min		The lowest value to use for the color
		 * @param	max 	The highest value to use for the color
		 * @param	alpha	The alpha value of the returning color (default 255 = fully opaque)
		 * 
		 * @return 32-bit color value with alpha
		 */
		public static function getRandomColor(min:uint = 0, max:uint = 255, alpha:uint = 255):uint
		{
			//	Sanity checks
			if (max > 255)
			{
				FlxG.log("FlxColor Warning: getRandomColor - max value too high");
				return getColor24(255, 255, 255);
			}
			
			if (min > max)
			{
				FlxG.log("FlxColor Warning: getRandomColor - min value higher than max");
				return getColor24(255, 255, 255);
			}
			
			var red:uint = min + int(Math.random() * (max - min));
			var green:uint = min + int(Math.random() * (max - min));
			var blue:uint = min + int(Math.random() * (max - min));
			
			return getColor32(alpha, red, green, blue);
		}
		
		/**
		 * Given an alpha and 3 color values this will return an integer representation of it
		 * 
		 * @param	alpha	The Alpha value (between 0 and 255)
		 * @param	red		The Red channel value (between 0 and 255)
		 * @param	green	The Green channel value (between 0 and 255)
		 * @param	blue	The Blue channel value (between 0 and 255)
		 * 
		 * @return	A native color value integer (format: 0xAARRGGBB)
		 */
		public static function getColor32(alpha:uint, red:uint, green:uint, blue:uint):uint
		{
			return alpha << 24 | red << 16 | green << 8 | blue;
		}
		
		/**
		 * Given 3 color values this will return an integer representation of it
		 * 
		 * @param	red		The Red channel value (between 0 and 255)
		 * @param	green	The Green channel value (between 0 and 255)
		 * @param	blue	The Blue channel value (between 0 and 255)
		 * 
		 * @return	A native color value integer (format: 0xRRGGBB)
		 */
		public static function getColor24(red:uint, green:uint, blue:uint):uint
		{
			return red << 16 | green << 8 | blue;
		}
		
		/**
		 * Return the component parts of a color as an Object with the properties alpha, red, green, blue
		 * 
		 * <p>Alpha will only be set if it exist in the given color (0xAARRGGBB)</p>
		 * 
		 * @param	color in RGB (0xRRGGBB) or ARGB format (0xAARRGGBB)
		 * 
		 * @return Object with properties: alpha, red, green, blue
		 */
		public static function getRGB(color:uint):Object
		{
			var alpha:uint = color >>> 24;
			var red:uint = color >> 16 & 0xFF;
			var green:uint = color >> 8 & 0xFF;
			var blue:uint = color & 0xFF;
			
			return { alpha: alpha, red: red, green: green, blue: blue };
		}
		
		/**
		 * Given a native color value (in the format 0xAARRGGBB) this will return the Alpha component, as a value between 0 and 255
		 * 
		 * @param	color	In the format 0xAARRGGBB
		 * 
		 * @return	The Alpha component of the color, will be between 0 and 255 (0 being no Alpha, 255 full Alpha)
		 */
		public static function getAlpha(color:uint):uint
		{
			return color >>> 24;
		}
		
		/**
		 * Given a native color value (in the format 0xAARRGGBB) this will return the Alpha component as a value between 0 and 1
		 * 
		 * @param	color	In the format 0xAARRGGBB
		 * 
		 * @return	The Alpha component of the color, will be between 0 and 1 (0 being no Alpha (opaque), 1 full Alpha (transparent))
		 */
		public static function getAlphaFloat(color:uint):Number
		{
			var f:uint = color >>> 24;
			
			return f / 255;
		}
		
		/**
		 * Given a native color value (in the format 0xAARRGGBB) this will return the Red component, as a value between 0 and 255
		 * 
		 * @param	color	In the format 0xAARRGGBB
		 * 
		 * @return	The Red component of the color, will be between 0 and 255 (0 being no color, 255 full Red)
		 */
		public static function getRed(color:uint):uint
		{
			return color >> 16 & 0xFF;
		}
		
		/**
		 * Given a native color value (in the format 0xAARRGGBB) this will return the Green component, as a value between 0 and 255
		 * 
		 * @param	color	In the format 0xAARRGGBB
		 * 
		 * @return	The Green component of the color, will be between 0 and 255 (0 being no color, 255 full Green)
		 */
		public static function getGreen(color:uint):uint
		{
			return color >> 8 & 0xFF;
		}
		
		/**
		 * Given a native color value (in the format 0xAARRGGBB) this will return the Blue component, as a value between 0 and 255
		 * 
		 * @param	color	In the format 0xAARRGGBB
		 * 
		 * @return	The Blue component of the color, will be between 0 and 255 (0 being no color, 255 full Blue)
		 */
		public static function getBlue(color:uint):uint
		{
			return color & 0xFF;
		}
		
	}

}
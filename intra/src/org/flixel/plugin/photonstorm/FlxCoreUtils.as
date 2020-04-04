/**
 * FlxCoreUtils
 * -- Part of the Flixel Power Tools set
 * 
 * v1.1 Added get mouseIndex and gameContainer
 * v1.0 First release with copyObject
 * 
 * @version 1.1 - August 4th 2011
 * @link http://www.photonstorm.com
 * @author Richard Davey / Photon Storm
*/

package org.flixel.plugin.photonstorm 
{
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	import org.flixel.*;
	
	public class FlxCoreUtils 
	{
		
		public function FlxCoreUtils() 
		{
		}
		
		/**
		 * Performs a complete object deep-copy and returns a duplicate (not a reference)
		 * 
		 * @param	value	The object you want copied
		 * @return	A copy of this object
		 */
		public static function copyObject(value:Object):Object
		{
			var buffer:ByteArray = new ByteArray();
			buffer.writeObject(value);
			buffer.position = 0;
			var result:Object = buffer.readObject();
			return result;
		}
		
		/**
		 * Returns the Display List index of the mouse pointer
		 */
		public static function get mouseIndex():int
		{
			var mouseIndex:int = -1;
			
			try
			{
				mouseIndex = FlxG.camera.getContainerSprite().parent.numChildren - 4;
			}
			catch (e:Error)
			{
				//trace
			}
			
			return mouseIndex;
		}
		
		/**
		 * Returns the Sprite that FlxGame extends (which contains the cameras, mouse, etc)
		 */
		public static function get gameContainer():Sprite
		{
			return Sprite(FlxG.camera.getContainerSprite().parent);
		}
		
	}

}
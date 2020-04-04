package  
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import org.flixel.system.FlxPreloader;
	
	/**
	 * ...
	 * @author Seagaia
	 */
	[SWF(width="480", height="540", backgroundColor="#06101a")]
	public class Preloader extends FlxPreloader 
	{
		public static var display:DisplayObject;
		public function Preloader() 
		{
			className = "Main";		  
			super();
		}
		
	}

}
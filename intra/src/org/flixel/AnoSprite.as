package org.flixel 
{
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	/**
	 * ...
	 * @author ...
	 */
	public class AnoSprite extends FlxSprite 
	{
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		protected var state:int;
		public var tl:Point;
		protected var dame_frame:int;
		protected var did_init:Boolean = false;
		
		/**
		 * Creates a flxsprite but with the args that most entities in anodyne have.
		 * Should be: [XML,Player ref,Parent,offset_the_y]
		 * offset_the_y is a boolean, if true then we add 20 to the DAME y- value
		 * @param	args
		 */
		public function AnoSprite(args:Array) 
		{
			xml = args[0];
			player = args[1];
			parent = args[2];
			
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			if (args.length > 3) {
				args[3] ? y += Registry.HEADER_HEIGHT : 1;
			}
			
			tl = new Point(Registry.CURRENT_GRID_X * 160, Registry.CURRENT_GRID_Y * 160 + Registry.HEADER_HEIGHT);
			
		}
		
		override public function destroy():void 
		{
			tl = null;
			super.destroy();
		}
		
	}

}
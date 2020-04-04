package org.flixel.system
{
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	/**
	 * A miniature linked list class.
	 * Useful for optimizing time-critical or highly repetitive tasks!
	 * See <code>FlxQuadTree</code> for how to use it, IF YOU DARE.
	 */
	public class FlxList
	{
		/**
		 * Stores a reference to a <code>FlxObject</code>.
		 */
		public var object:FlxObject;
		/**
		 * Stores a reference to the next link in the list.
		 */
		public var next:FlxList;
		
		/**
		 * A pool to prevent repeated <code>new</code> calls.
		 */
		static public var listPool:ObjectPool = new ObjectPool(FlxList);
		
		/**
		 * Creates a new link, and sets <code>object</code> and <code>next</code> to <code>null</code>.
		 */
		public function FlxList()
		{
			object = null;
			next = null;
		}
		
		/**
		 * Clean up memory.
		 */
		public function destroy():void
		{
			object = null;
			if(next != null)
				next.destroy();
			next = null;
			
			listPool.disposeObject(this);
		}
	}
}
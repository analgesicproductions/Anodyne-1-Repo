package states 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	
	/* A totally needless abstraction. oh well */
	public class PushableFlxState extends FlxState
	{
		public var parent:*;
		override public function create():void {
		
		}
		
		public function PushableFlxState() {
			
		}
		/**
		 * Pushes all of this state's ADDED OBJETS onto its parents draw group
		 * @param	_parent 	The FlxState that is being drawn.
		 */
		public function push(_parent:FlxState):void {
			parent = _parent;
			for (var i:int = 0; i < members.length; i++) {
				if (members[i] != null) {
					_parent.add(members[i]);
				}
			}
		}
		/**
		 * Removes this state's ADDED OBJECTS from its parents draw group
		 * If you allocate memory that isn't added, don't forget to null it!
		 * @param	FlxState	The FlxState that is being drawn.
		 */
		public function pop(parent:FlxState):void {
			for (var i:int = 0; i < members.length; i++) {
				if (members[i] != null) {
					parent.remove(members[i], true);
					
				}
			}
		}
		
		override public function destroy():void {
			super.destroy();
			parent = null;
		}
		
	}

}
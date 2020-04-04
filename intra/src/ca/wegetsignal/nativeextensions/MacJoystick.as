package ca.wegetsignal.nativeextensions
{
	public class MacJoystick
	{
		public var id:int = -1;
		
		public var axes:Vector.<Number>;
		public var buttons:Vector.<Boolean>;
		
		public function MacJoystick(id:int,numAxes:int,numButtons:int)
		{
			this.id = id;
			this.axes = new Vector.<Number>(numAxes);
			this.buttons = new Vector.<Boolean>(numButtons);
		}
		
		/** Returns the value for axis at index between -1 and 1
		 * Returns 0 for invalid axis index queries */
		public function getAxis(index:int=0):Number {
			if (index < 0 || index >= axes.length)
				return 0;
			return axes[index];
		}
		
		/** Returns true if the button is on, false if released.
		 * Returns false if button index is out of valid range */
		public function getButton(index:int=0):Boolean {
			if (index < 0 || index >= buttons.length)
				return false;
			return buttons[index];
		}
		
		internal function updateAxes(params:Array):void {
			// first param is this joystick id.. or should be..
			if (params[0] != id)
				throw new Error("Invalid joystick ID for Axes update");
			
			for (var i:int=1; i<params.length; ++i) {
				axes[i-1] = Number(params[i]);
			}
		}
	}
}
package ca.wegetsignal.nativeextensions
{
	import flash.events.Event;
	
	/** joystick property is the affected MacJoystick object
	 * elementIndex means the button index that was updated
	 * axes updates include all axes as a limitation of the IOKit HID Manager */
	public class MacJoystickEvent extends Event
	{
		public static const	JOYSTICK_ADDED:String = "JOYSTICK_ADDED",
							JOYSTICK_REMOVED:String = "JOYSTICK_REMOVED",
							JOYSTICK_BUTTON_PUSHED:String = "JOYSTICK_BUTTON_PUSHED",
							JOYSTICK_BUTTON_RELEASED:String = "JOYSTICK_BUTTON_RELEASED",
							JOYSTICK_AXES_UPDATED:String = "JOYSTICK_AXES_UPDATED";
		
		public var joystick:MacJoystick;
		public var elementIndex:int;
		
		public function MacJoystickEvent(type:String,joystick:MacJoystick,elementIndex:int=-1)
		{
			super(type);
			
			this.joystick = joystick;
			this.elementIndex = elementIndex;
		}
	}
}
package ca.wegetsignal.nativeextensions
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import global.Keys;
	
	public class MacJoystickManager extends EventDispatcher
	{
		private static const EXTENSION_ID : String = "ca.wegetsignal.nativeextensions.MacJoyANE";
		
		private var context:ExtensionContext;
		private var numJoysticks:uint = 0;
		
		public var joysticks:Array = [];
		
		private static const	JOYSTICK_ADDED:String = "JOYSTICK_ADDED",
								JOYSTICK_REMOVED:String = "JOYSTICK_REMOVED",
								JOYSTICK_BUTTON_PUSHED:String = "JOYSTICK_BUTTON_PUSHED",
								JOYSTICK_BUTTON_RELEASED:String = "JOYSTICK_BUTTON_RELEASED",
								JOYSTICK_AXES_UPDATED:String = "JOYSTICK_AXES_UPDATED";
		
		public function MacJoystickManager()
		{
			super();
			
			context = ExtensionContext.createExtensionContext(EXTENSION_ID,null);
			context.addEventListener(StatusEvent.STATUS,onStatus);
			context.call("initializeGamepads",null);
		}
		
		public function numberOfJoysticks():uint {
			return numJoysticks;
		}
		
		protected function onStatus(event:StatusEvent):void
		{
			var params:Array = event.level.split(',');
			var affectedJoystick:MacJoystick;
			var elementIndex:int = -1;
			
			switch (event.code) {
				case JOYSTICK_ADDED:
					// level is joystickID,numAxes,numButtons
					affectedJoystick = new MacJoystick(int(params[0]),int(params[1]),int(params[2]));
					joysticks[int(params[0])] = affectedJoystick;
					numJoysticks++;
					break;
				case JOYSTICK_REMOVED:
					affectedJoystick = joysticks[int(params[0])];
					joysticks[int(params[0])] = null;
					numJoysticks--;
					break;
				case JOYSTICK_BUTTON_PUSHED:
					// level is joystickID,buttonIndex
					affectedJoystick = joysticks[int(params[0])]
					affectedJoystick.buttons[int(params[1])] = true;
					elementIndex = int(params[1]);
					break;
				case JOYSTICK_BUTTON_RELEASED:
					// level is joystickID,buttonIndex
					affectedJoystick = joysticks[int(params[0])]
					affectedJoystick.buttons[int(params[1])] = false;
					elementIndex = int(params[1]);
					break;
				case JOYSTICK_AXES_UPDATED:
					// level is joystickID,[axes]
					affectedJoystick = joysticks[int(params[0])]
					affectedJoystick.updateAxes(params);
					break;
			}
			
			dispatchEvent(new MacJoystickEvent(event.code,affectedJoystick,elementIndex));
		}
	}
}
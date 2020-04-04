/*
JoyQuery ActionScript 3.0 Class    Version: 1

(C) 2011 Alexander O'Mara

The following line must be added to the AIR Application XML
descriptor file between the root ("application") tags:
<supportedProfiles>extendedDesktop</supportedProfiles>
Additionally, for release, the Joy Query executable must be 
included in the installer and published as a native installer.

This class file is designed to be used with AIR to give
Native Windows AIR applications a set of APIs to interface
with joystick input through the JoyQuery extension. This
class file is free software. You may copy, edit, reuse, and
redistribute this class freely provided that altered versions
are not distrubuted as the original.

This class file is provided "as is" without warranty of any
kind, either expressed or implied, including, but not
limited to, the implied warranties of merchantability and
fitness for a particular purpose. In no event will the
author of this program be liable for any damages of any kind.
*/
package extension.JoyQuery
{
	import flash.filesystem.File;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.NativeProcessExitEvent;

	public class Joystick extends Object
	{
		private var capable:Array;
		private var inputStatus:Array;
		private var isRunning:Boolean;
		private var ready:Boolean;
		private var total:Number;
		private var callerObject:Object;
		private var extensionPath:File;
		private var process:NativeProcess;
		public var exists:Boolean = false;

		public function Joystick(mainWindowObject:Object, joystickExtensionPath:String):void
		{
			callerObject = mainWindowObject;
			var file:File = File.applicationDirectory;
			extensionPath = file.resolvePath(joystickExtensionPath);
			exists = true;
		}
		//Main handler for the extension.
		private function main(command:String):void
		{
			//Process info.
			var processInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			processInfo.executable = extensionPath;
			
			//Process arguments.
			var commandSplit:Array = command.split(" ");
			var args:Vector.<String> = new Vector.<String>();
			for(var i:int = 0; i < commandSplit.length; i++)
			{
				args.push(commandSplit[i]);
			}
			processInfo.arguments = args;
			
			//Create process.
			process = new NativeProcess();
			process.start(processInfo);

			//Listen for program to close.
			process.addEventListener(NativeProcessExitEvent.EXIT, onExit);
			function onExit(e:NativeProcessExitEvent):void
			{
				capable = null;
				inputStatus = null;
				ready = false;
				total = 0;
			}
			//Listen for output.
			process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
			function onOutputData(e:ProgressEvent):void
			{
				//Check if not running.
				if(!isRunning)
				{
					return;
				}
				try {
				//Get STD:OUT.
				var input:String = process.standardOutput.readUTFBytes(process.standardOutput.bytesAvailable);
				//Check that the extension is giving state output.
				if(input.split(":")[0] != "S")
				{
					ready = true;
					return;
				}

				//Array for each joystick string.
				var inputArray:Array = input.split(":")[1].split("|");

				//Split up axis positions and button states for each axis.
				var loc_inputStatus:Array = new Array(inputArray.length);
				for(var i:int = 0; i < inputArray.length; i++)
				{
					loc_inputStatus[i] = inputArray[i].split("~");
				}
				//Set total joysticks.
				if(inputArray[0] == "none")
				{
					total = 0;
				}
				else
				{
					total = loc_inputStatus.length;
				}
				
				//Index each axis and button.
				for(i = 0; i < total; i++)
				{
					loc_inputStatus[i][0] = loc_inputStatus[i][0].split(",");
					loc_inputStatus[i][1] = loc_inputStatus[i][1].split(",");
				} 
				
				
				//Set each joystick axis and button capabilities.
				var loc_capable:Array = new Array(total);
				for(i = 0; i < total; i++)
				{
					loc_capable[i] = new Array(2);
					loc_capable[i][0] = loc_inputStatus[i][0].length;
					loc_capable[i][1] = loc_inputStatus[i][1].length;
				}
				//Set the arrays.
				capable = loc_capable;
				inputStatus = loc_inputStatus;
				ready = true;
				} catch (e:TypeError) {
					// Sometimes the state's number gets formatted wrong, so let's not freeze the game...
					trace("Awesome type error we'll ignore it");
				}
			}
			
			//Close the extension when the main window is closed.
			callerObject.stage.nativeWindow.addEventListener(Event.CLOSING, onCloseOut);
			function onCloseOut(e:Event):void
			{
				kill();
			}
		}
		//Initialize extension.
		public function init(speed:* = "auto"):void
		{
			//If no output speed set for the extension, create one from the frame rate.
			if(speed == "auto")
			{
				speed = Math.floor(1 / callerObject.stage.frameRate * 1000) / 1000;
			}
			capable = null;
			inputStatus = null;
			isRunning = true;
			ready = false;
			total = 0;
			main("-s " + speed);
		}
		//Kill the extension.
		public function kill():void
		{
			process.exit(true);
			capable = null;
			inputStatus = null;
			ready = false;
			total = 0;
			isRunning = false;
		}
		//Check if the extension is ready to use.
		public function isReady():Boolean
		{
			return ready;
		}
		//Get the total number of joysticks.
		public function getTotal():Number
		{
			return total;
		}
		//Find if button is down.
		public function buttonIsDown(joystickNum:Number, buttonNum:Number):Boolean
		{
			try
			{
				return inputStatus[joystickNum][1][buttonNum] == "1";
			}
			catch(error:Error)
			{
				return false;
			}
			return false;
		}
		//Get axis position.
		public function getAxis(joystickNum:Number, axisNum:Number):Number
		{
			try
			{
				return Number(inputStatus[joystickNum][0][axisNum]);
			}
			catch(error:Error)
			{
				return 0;
			}	
			return 0;
		}
		//Get total buttons.
		public function getTotalButtons(joystickNum:Number):Number
		{
			try
			{
				return Number(capable[joystickNum][1]);
			}
			catch(error:Error)
			{
				return 0;
			}	
			return 0;
		}
		//Get total axes.
		public function getTotalAxes(joystickNum:Number):Number
		{
			try
			{
				return Number(capable[joystickNum][0]);
			}
			catch(error:Error)
			{
				return 0;
			}	
			return 0;
		}
	}
}
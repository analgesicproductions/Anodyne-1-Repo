package 
{
	//import com.amanitadesign.steam.FRESteamWorks;
	import helper.DH;
	//import ca.wegetsignal.nativeextensions.MacJoystick;
	//import ca.wegetsignal.nativeextensions.MacJoystickManager;
	//import com.amanitadesign.steam.SteamEvent;
	import extension.JoyQuery.Joystick;
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.StageDisplayState;
	import flash.media.AudioPlaybackMode; // Add for iOS
	import flash.media.SoundMixer;
	import flash.system.Capabilities;
	import flash.utils.getTimer;
	import global.Keys;
	import global.Registry;
	import helper.Achievements;
	import helper.UI_Offsets;
	import org.flixel.FlxGame;
	
	import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.ui.Mouse;
	import helper.ANEFix;

	[Frame(factoryClass = "Preloader")]
	public class Main extends Sprite
	{
		
		public static var joy:Joystick;
		//public static var joy:*;
		//public static var mac_joy_manager:MacJoystickManager;
		public static var mac_joy_manager:*;
		
		
		public static var macmanready:Boolean = false;
		public static var macmanexists:Boolean = false;
		//public static var fff:FRESteamWorks;
		//public static var fff:*;
		public static var pixel_overlay:Bitmap;
		public static var fixedsteam:Boolean = false;
		public static var fixedjoy:Boolean = false;
		
		public static var ui_offsets:UI_Offsets;
		public static var max_uo:UI_Offsets;
		public function Main():void
		{	    
			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(event:Event=null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Intra.is_air = true;
			
			if (NativeApplication.nativeApplication.applicationID.indexOf("ouya") != -1) {
				//game_input = new GameInput();
				//game_input.addEventListener(GameInputEvent.DEVICE_ADDED, handleDeviceAttached);
				//game_input.addEventListener(GameInputEvent.DEVICE_REMOVED, handleDeviceRemoved);
				//debugstring += GameInput.isSupported.toString() + "\n";
			} else if (NativeApplication.nativeApplication.applicationID.indexOf("humble") != -1) {
				Intra.is_mobile = true;
				Intra.is_air = false;
				Intra.is_ios = false;
				//Intra.is_ios = true;
				Achievements.DEBUG_TEXT += "humble\n";
			} else if (NativeApplication.nativeApplication.applicationID.indexOf("mobile") != -1) {
				Intra.is_mobile = true;
				Intra.is_air = false;
				Intra.is_ios = true;
				Achievements.DEBUG_TEXT += "mobile\n";
			} 
			
			if (Intra.is_ios) {
				// ADd for ios
				SoundMixer.audioPlaybackMode = AudioPlaybackMode.AMBIENT;
			}			
			//Achievements.IS_KONG = true;
			Achievements.IS_STEAM = false;
			if (Intra.is_air) {
				Achievements.DEBUG_TEXT += Capabilities.os+"\n";
				if (Capabilities.os.indexOf("Windows") != -1) { // WERE ON WINDOWS
					joy = new Joystick(this, "joyquery.exe");
					joy.init();
					Intra.IS_WINDOWS = true;
					Achievements.DEBUG_TEXT += "windows\n";
				} else if (Capabilities.os.indexOf("Mac") != -1 && !Intra.is_mobile) {
					
					function onJoyFix (extensionID:String, success:Boolean):void {
						if (success && !fixedjoy) {
							trace("in OnJoyFix, success");
							Main.fixedjoy = true;
						} else {
							trace("in onJoyFix, fail");
						}
					}
					trace("ENTERING... FIXING JOYSTICK");
					ANEFix.fixANE("ca.wegetsignal.nativeextensions.MacJoyANE", onJoyFix);
					Intra.IS_MAC = true;
				} else {
					Intra.IS_LINUX = true;
				}
			}
			// Create steamworks object, references by load/save for cloud
			if (Intra.IS_MAC) {
				function onFix(extensionID:String, success:Boolean):void {
					
					 if (success && !fixedsteam) {
						 trace("in onFix , succes");
						 fixedsteam = true;
						Achievements.init_steam();
					 } else {
						 trace("in onfix, fail");
					 }
				}
				trace("ENTERING...fIX STEAM");
				ANEFix.fixANE("com.amanitadesign.steam.FRESteamWorks", onFix,true);
			} else {
				trace("Initing steam from LINE 69");
				if (Intra.IS_WINDOWS) {
					Achievements.init_steam();
				} else if (Intra.IS_LINUX)  {
					Achievements.init_steam();
					
				}
			}
			ui_offsets = new UI_Offsets();
			max_uo = new UI_Offsets();
			
			
			
            var game:Intra = new Intra;
			
			// Initialize joypad shit
            addChild(game);
			
			//addEventListener(MouseEvent.CLICK, on_click);
			
			
		}

		
		public static var debugstring:String = "aa";
		/// lalala ok this is set up,now poll it every frame elsehwere and hook that up...
		//private var active_id:String = "";
		//private function handleDeviceAttached(event:GameInputEvent):void {
			//debugstring += "dev. " + event.device.id + " attached\n";
			//if (active_id == "") {
				//game_input_device = event.device;
				//GameInputControlName.initialize(game_input_device);
				//active_id = event.device.id;
				//game_input_device.enabled = true;
				//debugstring += "enabled\n";
				//for (var i:int = 0; i < game_input_device.numControls; i++) {
					//switch (game_input_device.getControlAt(i).name) {
						//case GameInputControlName.DPAD_UP:
							//debugstring += "\nu " + game_input_device.getControlAt(i).minValue.toFixed(2) + game_input_device.getControlAt(i).maxValue.toFixed(2);
							//Registry.joybinds[Keys.IDX_UP] = i; break;
						//case GameInputControlName.DPAD_DOWN:
							//debugstring += "\nd " + game_input_device.getControlAt(i).minValue.toFixed(2) + game_input_device.getControlAt(i).maxValue.toFixed(2);
							//Registry.joybinds[Keys.IDX_DOWN] = i; break;
						//case GameInputControlName.DPAD_LEFT:
							//debugstring += "\nl " + game_input_device.getControlAt(i).minValue.toFixed(2) + game_input_device.getControlAt(i).maxValue.toFixed(2);
							//Registry.joybinds[Keys.IDX_LEFT] = i; break;
						//case GameInputControlName.DPAD_RIGHT:
							//debugstring += "\nr " + game_input_device.getControlAt(i).minValue.toFixed(2) + game_input_device.getControlAt(i).maxValue.toFixed(2);
							//Registry.joybinds[Keys.IDX_RIGHT] = i; break;
						//case GameInputControlName.BUTTON_O:
							//debugstring += "\na2 " + game_input_device.getControlAt(i).minValue.toFixed(2) + game_input_device.getControlAt(i).maxValue.toFixed(2);
							//Registry.joybinds[Keys.IDX_ACTION_2] = i; break;
						//case GameInputControlName.BUTTON_U:
							//debugstring += "\na1 " + game_input_device.getControlAt(i).minValue.toFixed(2) + game_input_device.getControlAt(i).maxValue.toFixed(2);
							//Registry.joybinds[Keys.IDX_ACTION_1] = i; break;
						//case GameInputControlName.BUTTON_START:
							//debugstring += "\np " + game_input_device.getControlAt(i).minValue.toFixed(2) + game_input_device.getControlAt(i).maxValue.toFixed(2);
							//Registry.joybinds[Keys.IDX_PAUSE] = i; break;
					//}
				//}
			//}
		//}
		//
		//private function handleDeviceRemoved(event:GameInputEvent):void {
			//if (event.device.id == active_id) {
				//active_id = "";
				//game_input_device = null;
			//}
			//
			//
		//}
		
		//public function on_click(e:MouseEvent):void {
			//if (e.type == MouseEvent.CLICK) {
				//FlxGame.HARD_PAUSED = !FlxGame.HARD_PAUSED;
				//trace("nice");
			//}
		//}
		
  
	}
	
	

}
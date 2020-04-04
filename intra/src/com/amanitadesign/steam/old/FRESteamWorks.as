package com.amanitadesign.steam
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.utils.ByteArray;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	public class FRESteamWorks extends EventDispatcher
	{
		[Event(name="steam_response", type="com.amanitadesign.steam.SteamEvent")]
		
		private var _ExtensionContext:ExtensionContext;
		private var _tm:int;
		
		public var isReady:Boolean = false;
		
		public function FRESteamWorks(target:IEventDispatcher=null)
		{
			_ExtensionContext = ExtensionContext.createExtensionContext("com.amanitadesign.steam.FRESteamWorks", null);
			_ExtensionContext.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			super(target);
		}
		
		private function handleStatusEvent(event:StatusEvent):void{
			//_ExtensionContext.removeEventListener(StatusEvent.STATUS, handleStatusEvent);
			var req_type:int = new int(event.code);
			var response:int = new int(event.level);
			var sEvent:SteamEvent = new SteamEvent(SteamEvent.STEAM_RESPONSE, req_type, response);
			trace("handleStatusEvent: "+req_type+" "+response);
			switch(req_type)
			{
				case SteamConstants.RESPONSE_OnUserStatsReceived:
					trace("RESPONSE_OnUserStatsReceived");
				break;
				case SteamConstants.RESPONSE_OnAchievementStored:
					trace("RESPONSE_OnAchievementStored");
				break;
			}
			dispatchEvent(sEvent);
		}
		
		public function dispose():void
		{
			clearInterval(_tm);
			_ExtensionContext.removeEventListener(StatusEvent.STATUS, handleStatusEvent);
			_ExtensionContext.dispose();
		}

		public function init():Boolean
		{
			isReady = _ExtensionContext.call("AIRSteam_Init") as Boolean;
			if(isReady)	_tm = setInterval(runCallbacks, 100);
			return isReady;
		}
		public function requestStats():Boolean
		{
			return _ExtensionContext.call("AIRSteam_RequestStats") as Boolean;
		}
		
		public function runCallbacks():Boolean
		{
			return _ExtensionContext.call("AIRSteam_RunCallbacks") as Boolean;
		}
		
		public function setAchievement(id:String):Boolean
		{
			return _ExtensionContext.call("AIRSteam_SetAchievement", id) as Boolean;
		}
		
		public function clearAchievement(id:String):Boolean
		{
			return _ExtensionContext.call("AIRSteam_ClearAchievement", id) as Boolean;
		}
		
		public function isAchievement(id:String):Boolean
		{
			return _ExtensionContext.call("AIRSteam_IsAchievement", id) as Boolean;
		}
		
		public function getStatInt(id:String):int
		{
			return _ExtensionContext.call("AIRSteam_GetStatInt", id) as int;
		}
		
		public function getStatFloat(id:String):Number
		{
			return _ExtensionContext.call("AIRSteam_GetStatFloat", id) as Number;
		}
		
		public function setStatInt(id:String, value:int):Boolean
		{
			return _ExtensionContext.call("AIRSteam_SetStatInt", id, value) as Boolean;
		}
		
		public function setStatFloat(id:String, value:Number):Boolean
		{
			return _ExtensionContext.call("AIRSteam_SetStatFloat", id, value) as Boolean;
		}
		
		public function storeStats():Boolean
		{
			return _ExtensionContext.call("AIRSteam_StoreStats") as Boolean;
		}
		
		public function resetAllStats(bAchievementsToo:Boolean):Boolean
		{
			return _ExtensionContext.call("AIRSteam_ResetAllStats", bAchievementsToo) as Boolean;
		}
		
		
		public function getFileCount():int
		{
			return _ExtensionContext.call("AIRSteam_GetFileCount") as int;
		}
		
		public function getFileSize(fileName:String):int
		{
			return _ExtensionContext.call("AIRSteam_GetFileSize", fileName) as int;
		}
		
		public function fileExists(fileName:String):Boolean
		{
			return _ExtensionContext.call("AIRSteam_FileExists", fileName) as Boolean;
		}
		
		public function fileWrite(fileName:String, data:ByteArray):Boolean
		{
			return _ExtensionContext.call("AIRSteam_FileWrite", fileName, data) as Boolean;
		}
		
		public function fileRead(fileName:String, data:ByteArray):Boolean
		{
			return _ExtensionContext.call("AIRSteam_FileRead", fileName, data) as Boolean;
		}
		
		public function fileDelete(fileName:String):Boolean
		{
			return _ExtensionContext.call("AIRSteam_FileDelete", fileName) as Boolean;
		}
		
		public function isCloudEnabledForApp():Boolean
		{
			return _ExtensionContext.call("AIRSteam_IsCloudEnabledForApp") as Boolean;
		}
		
		public function setCloudEnabledForApp(enabled:Boolean):Boolean
		{
			return _ExtensionContext.call("AIRSteam_SetCloudEnabledForApp", enabled) as Boolean;
		}
	}
}
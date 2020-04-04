package helper 
{
	import com.amanitadesign.steam.FRESteamWorks;
	import com.amanitadesign.steam.SteamConstants;
	import com.amanitadesign.steam.SteamEvent;
	import flash.desktop.NativeApplication;
	import flash.utils.ByteArray;
	import global.Registry;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	public class Achievements 
	{
		
		private static var IS_NEWGROUNDS:Boolean = false;
		public static var IS_KONG:Boolean = false;
		public static var KONG_LOADED:Boolean = false;
		public static var IS_STEAM:Boolean = true;
		
		public static const Card_1:int = 0;
		public static const Card_7:int = 1;
		public static const Extra_health_1:int = 2;
		public static const Fast_fields:int = 3;
		public static const No_damage_sunguy:int = 4;
		public static const Trophy_1:int = 5;
		public static const Greenlit:int = 6;
		public static const Website:int = 7;	
		
		public static const A_GET_BROOM:int = 8;
		public static const A_GET_WINDMILL_CARD:int = 9;
		public static const A_DEFEAT_BRIAR:int = 10;
		
		public static const A_100_PERCENT_ANY_TIME:int = 11;
		public static const A_200_PERCENT:int = 12;
		public static const A_GET_RED_CUBE:int = 13;
		public static const A_GET_GREEN_CUBE:int = 14;
		public static const A_GET_BLUE_CUBE:int = 15;
		public static const A_GET_BW_CUBES:int = 16;
		public static const A_CONSOLE:int = 17;
		public static const A_GET_GOLDEN_POO:int = 18;
		public static const A_GET_48_CARDS:int = 19;
		public static const A_GET_49TH_CARD:int = 20;
		
		public static const A_ENDING_SUB_15_M:int = 21;
		public static const A_100_PERCENT_SUB_3_HR:int = 22;
		
		public static const achvname:Object = { 8:"broom", 9: "windmill", 10: "briar", 
		11: "100" , 12: "200" , 13: "red", 14: "green", 15: "blue", 16: "bw",
		17: "console", 18: "poo", 19: "48", 20: "49", 21: "fast", 22:"100fast"};
		
		public static var Steamworks:FRESteamWorks;
		
		private static var did_init:Boolean = false;
		public static var DEBUG_TEXT:String = "";
		
		public static function init(root:*):void {
			if (did_init) return;
			did_init = true;
			
		}
		
		public static function kong_loaded():void {
			KONG_LOADED = true;
		}
		
		public static function init_steam():void {
			DEBUG_TEXT += "In Init Steam\n";
			if (IS_STEAM && Steamworks == null) {
				if (Intra.IS_LINUX) {
					//return;
				}
				DEBUG_TEXT += "LOADING STEAM\n";
				Steamworks = new FRESteamWorks();
				Steamworks.addEventListener(SteamEvent.STEAM_RESPONSE, onSteamResponse);
				if (Steamworks.init()) {
					if (Steamworks.isReady) {
						if (false == Intra.IS_LINUX) {
							Steamworks.setCloudEnabledForApp(true);
						}
						DEBUG_TEXT += "STEAM LOADED\n";
					}
					//DEBUG_TEXT = DEBUG_TEXT + "atest: " + Steamworks.setAchievement("ACH_WIN_ONE_GAME").toString() + "\n";
					//Steamworks.clearAchievement("ACH_WIN_ONE_GAME");
					//Steamworks.setStatFloat('FeetTraveled', 42.42);
					//Steamworks.storeStats();
					//DEBUG_TEXT = DEBUG_TEXT + Steamworks.getStatFloat('FeetTraveled').toString() + "\n";
					//
					
				} else {
					DEBUG_TEXT += "FAILED\n";
				}
			} 
		}
		
		public static function get_completion_rate():int {
			
			// 36 Cards (+2) = 72
			// 10 health ups (+1) = 10
			// 4 broom upgrades (+4) = 16
			// Jump shoes (+2) = 2
			
			// 12 Cards
			// 13 weird items - all + 5
			
			var rate:int = 0;
			
			for (var i:int = 0; i < 48; i++) {
				if (Registry.card_states[i] == 1) {
					if (i < 36) {						
						rate += 2;
					} else {
						rate += 4;
					}
				}
			}
			
			rate += (Registry.MAX_HEALTH - 6);
			
			if (Registry.inventory[Registry.IDX_BROOM]) rate += 4;
			if (Registry.inventory[Registry.IDX_WIDEN]) rate += 4;
			if (Registry.inventory[Registry.IDX_LENGTHEN]) rate += 4;
			if (Registry.inventory[Registry.IDX_TRANSFORMER]) rate += 4;
			
			if (Registry.inventory[Registry.IDX_JUMP]) rate += 2;
			
			for (i = 11; i <= Registry.IDX_WHITE; i++) {
				if (Registry.inventory[i]) {
					rate += 4;
				}
			}
			
			Achievements.DEBUG_TEXT += rate.toString() + "\n";
			return rate;
		}
		
		public static function set_steam_achievements():void {
			if (IS_STEAM && Steamworks != null && Steamworks.isReady) {
				trace("Steam achievement state:", Registry.achivement_state);
				for (var i:int = 8; i < 23; i++) {
					if (Registry.achivement_state[i]) {
						Steamworks.setAchievement(achvname[i]);
					}
				}
			}
		}
		
		public static function writeFileToCloud(fileName:String, data:Object):Boolean {
			var dataOut:ByteArray = new ByteArray();
			dataOut.writeObject(data);
			return Steamworks.fileWrite(fileName, dataOut);
		}
		
		public static function readFileFromCloud(fileName:String):Object {
			var dataIn:ByteArray = new ByteArray();
			var dataOut:Object = new Object();
			dataIn.position = 0;
			dataIn.length = Steamworks.getFileSize(fileName);
			DEBUG_TEXT += dataIn.length.toString();
			
			if(dataIn.length>0 && Steamworks.fileRead(fileName,dataIn)){
				return dataIn.readObject();
			}
			return null;
		}
		
		
		public static function is_100_percent():Boolean {
			if (Registry.MAX_HEALTH >= 16 && Registry.inventory[Registry.IDX_TRANSFORMER] && Registry.inventory[Registry.IDX_WIDEN] && Registry.inventory[Registry.IDX_LENGTHEN] && Registry.nr_growths >= 37) {
				Achievements.unlock(Achievements.A_100_PERCENT_ANY_TIME);
				if (Registry.playtime < 3 * 60 * 60) {
					Achievements.unlock(Achievements.A_100_PERCENT_SUB_3_HR);
				}
				return true;
			}
			return false;
		}
		
		public static function is_200_percent():Boolean {
			var a:Array = Registry.inventory;
			if (is_100_percent() && Registry.nr_growths >= 49 && a[Registry.IDX_BLUE] && a[Registry.IDX_GREEN] && a[Registry.IDX_RED] && a[Registry.IDX_BLACK] && a[Registry.IDX_WHITE] && a[Registry.IDX_KITTY] && a[Registry.IDX_POO] && a[Registry.IDX_AUS_HEART] && a[Registry.IDX_ELECTRIC] && a[Registry.IDX_MARINA] && a[Registry.IDX_MELOS] && a[Registry.IDX_MISSINGNO] && a[Registry.IDX_SPAM]) {
				Achievements.unlock(Achievements.A_200_PERCENT);
				return true;
			}
			return false;
		}
		
		public static function onSteamResponse(e:SteamEvent):void {
			//Achievements.DEBUG_TEXT = DEBUG_TEXT + "STEAMresponse type:" + e.req_type + " response:" + e.response + "\n";	
			switch(e.req_type){
				case SteamConstants.RESPONSE_OnUserStatsStored:
					//DEBUG_TEXT = DEBUG_TEXT + "RESPONSE_OnUserStatsStored: " + e.response + "\n";
					break;
				case SteamConstants.RESPONSE_OnUserStatsReceived:
					//DEBUG_TEXT = DEBUG_TEXT + "RESPONSE_OnUserStatsReceived: " + e.response + "\n";
					break;
				case SteamConstants.RESPONSE_OnAchievementStored:
					//DEBUG_TEXT = DEBUG_TEXT + "RESPONSE_OnAchievementStored: " + e.response + "\n";
					break;
				case 3:
				//case SteamConstants.RESPONSE_OnGameOverlayActivated:
					//FlxGame.HARD_PAUSED = !FlxGame.HARD_PAUSED; // This is probably not the right hting to do.
					break;
				default:
			}
		}
		
		
		
		public static function unlock_all():void {
			for (var i:int = 8; i < 23; i++) {
				unlock(i);
			}
		}
		public static function unlock(id:int):void {
			if (!IS_STEAM && false == Intra.is_web) return;
			
			if (IS_STEAM) {
				trace("Achievement: ", id, achvname[id]);
				
				
				if (Steamworks != null && Steamworks.isReady) {
					switch (id) {
						case A_GET_BROOM://**
							Registry.achivement_state[id] = true;
							Steamworks.setAchievement(achvname[id]);
							break;
						case A_GET_WINDMILL_CARD: //**
							Registry.achivement_state[id] = true;
							Steamworks.setAchievement(achvname[id]);
							break;
							Registry.achivement_state[id] = true;
							Steamworks.setAchievement(achvname[id]);
							break;
						case A_100_PERCENT_ANY_TIME:// **
							Registry.achivement_state[id] = true;
							Steamworks.setAchievement(achvname[id]);
							break;
						case A_100_PERCENT_SUB_3_HR:// **
							Registry.achivement_state[id] = true;
							Steamworks.setAchievement(achvname[id]);
							break;
						case A_GET_48_CARDS://
							Registry.achivement_state[id] = true;
							Steamworks.setAchievement(achvname[id]);
							break;
					}	
				}
			}
			
			
			
		}
		
	}

}
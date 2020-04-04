package helper 
{
	import com.amanitadesign.steam.FRESteamWorks;
	/**
	 * ...
	 * @author Melos Han-Tani
	 */
	public class SteamThing 
	{
		
		public var SteamWorks:FRESteamWorks;
		public function init():void {
			SteamWorks = new FRESteamWorks();
		}
		
	}

}
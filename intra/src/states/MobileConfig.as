package states 
{
	/**
	 * update loop for configuring mobile ui
	 * @author Copyright Melos Han-Tani, Developer of Analgesic Productions LLC, 2013 - ? , www.twitter.com/seagaia2
	 */
	public class MobileConfig 
	{
		
		public function MobileConfig() 
		{
			
		}
		
		
		public static var did_init:Boolean = false;
		public static var in_progress:Boolean = false;
		public static var done:Boolean = false;
		public static function update():Boolean {
			
			if (!did_init) {
				did_init = true;
				in_progress = true;
			}
			
			if (done) {
				done = false;
				in_progress = false;
				did_init = false;
				return true;
			}
			return false;
		}
		
		
		
	}

}
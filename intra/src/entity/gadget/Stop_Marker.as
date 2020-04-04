package entity.gadget 
{
	import data.CLASS_ID;
	import global.Registry;
	import org.flixel.FlxSprite;
	
	/**
	 * Interacts with Propelled, stops them on a dime
	 * @author Seagaia
	 */
	public class Stop_Marker extends FlxSprite 
	{
		public var xml:XML;
		
		public var cid:int = CLASS_ID.STOP_MARKER;
		
		public var parent:*;
		
		public function Stop_Marker(_xml:XML,_parent:*) 
		{
			xml = _xml;
			super(parseInt(xml.@x), parseInt(xml.@y));
			makeGraphic(16, 16, 0x69386243);
			visible = false;
			parent = _parent;
			immovable = true; 
			solid = false;
		}
		
		
		override public function update():void 
		{
			for each (var propelled:Propelled in Registry.subgroup_propelled) {
				if (propelled.is_propelling && Math.abs(x - propelled.x) <= 2 && Math.abs(y - propelled.y) <= 2) {
					propelled.stop_from_stop_marker(this);
				}
			}
			super.update();
		}
	}

}
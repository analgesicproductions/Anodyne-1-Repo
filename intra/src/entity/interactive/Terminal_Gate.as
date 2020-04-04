package entity.interactive 
{
	import entity.player.Player;
	import global.Registry;
	import helper.Cutscene;
	import org.flixel.FlxSprite;
	
	/**
	 * The gate in TERMINAL with three tiers. One is removed for each
	 * of the first three bosses defeated.
	 * A container class for the associated entities
	 * @author Seagaia
	 */
	public class Terminal_Gate extends FlxSprite 
	{
		
		public var xml:XML;
		public var p:Player;
		public var parent:*;
		
		public var gate_bedroom:FlxSprite;
		public var gate_redcave:FlxSprite;
		public var gate_crowd:FlxSprite;
		public var button:FlxSprite;
		
		public function Terminal_Gate(_xml:XML, _p:Player, _parent:*,is_cutscene:Boolean=false) 
		{
			xml = _xml;
			p = _p;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			gate_bedroom = new FlxSprite(x, y + 16 + Registry.HEADER_HEIGHT);
			gate_redcave = new FlxSprite(x, y + 32 + Registry.HEADER_HEIGHT);
			gate_crowd = new FlxSprite(x, y + 48 + Registry.HEADER_HEIGHT);
			
			gate_bedroom.makeGraphic(16, 16, 0xff00ee00);
			gate_redcave.makeGraphic(16, 16, 0xffee0000);
			gate_crowd.makeGraphic(16, 16, 0xff0000ee);
			
			
				if (Registry.CUTSCENES_PLAYED[Cutscene.Terminal_Gate_Bedroom]) {
					gate_bedroom.exists = false;
				}
				if (Registry.CUTSCENES_PLAYED[Cutscene.Terminal_Gate_Redcave]) {
					gate_redcave.exists = false;
				}
				if (Registry.CUTSCENES_PLAYED[Cutscene.Terminal_Gate_Crowd]) {
					gate_crowd.exists = false;
				}
			visible = false;
			button = new FlxSprite(x, y + Registry.HEADER_HEIGHT);
			button.makeGraphic(16, 16, 0xff000000);
			
			if (!is_cutscene) {
				parent.sortables.add(button);
				parent.sortables.add(gate_bedroom);
				parent.sortables.add(gate_redcave);
				parent.sortables.add(gate_crowd);
			}
			
		}
		
		override public function update():void 
		{
			
			super.update();
			
			
		}
		
		override public function destroy():void {
			parent.sortables.remove(gate_bedroom, true);
			parent.sortables.remove(gate_redcave, true);
			parent.sortables.remove(gate_crowd, true);
			parent.sortables.remove(button, true);
			gate_bedroom = gate_redcave = gate_crowd = button = null;
			super.destroy();
		}
		
		
		
	}

}
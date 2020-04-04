package entity.gadget 
{
	import data.CLASS_ID;
	import flash.geom.Point;
	import helper.DH;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import global.Registry;
	public class Dust extends FlxSprite
	{
		
		public var xml:XML;
		[Embed (source = "../../res/sprites/gadgets/dust.png")] public static var DUST_SPRITE:Class;
		[Embed (source = "../../../../sfx/dustpoof.mp3")] public static var S_DUST_POOF:Class;
		public static var dust_sound:FlxSound = new FlxSound();
		public static var EMPTY_FRAME:int = 4;
		public var cid:int = CLASS_ID.DUST;
		public var midpoint:Point = new Point();
		public var ON_CONVEYER:Boolean = false;
		public var fell_in_hole:Boolean = false;
		public var on_propelled:Boolean = false;
		public var poofed_by_player_landing:Boolean = false;
		
		public var parent:*;
		
		public var T_NORMAL:int = 0;
		public var T_PUZZLE:int = 1; //Only used in BEDROOM
		public var INCREMENTED_PUZCT:Boolean = false;
		public var dame_frame:int = 0;
		
		//dust blocks lasers but can be walked over! AH can move it too
		public function Dust(_x:int, _y:int, _xml:XML,_parent:*) 
		{
			super(_x, _y);
			xml = _xml;
			parent = _parent;
			if (xml == null) xml = <Dust></Dust>;
			loadGraphic(DUST_SPRITE, true, false, 16, 16);
			dust_sound.loadEmbedded(S_DUST_POOF);
			addAnimation("poof", [0, 1, 2, 3, 4], 13, false);
			addAnimation("unpoof", [3, 2, 1, 0], 13, false);
			addAnimationCallback(on_anim_change);
			
			Registry.subgroup_dust.push(this);
			
			if (parseInt(xml.@frame) == 1) {
				dame_frame = T_PUZZLE;
			}
		}	
		
		public function hit(hitter:String, player_dir:uint):int {
			if (hitter == "broom" && visible) {
				play("poof");
				if (!Registry.GE_States[Registry.GE_Swept_Dust]) {
					Registry.GE_States[Registry.GE_Swept_Dust] = true;
					if (!Intra.is_test) {
						//DH.dialogue_popup("Your broom is now full of dust!  Attack again to place it.");
						DH.dialogue_popup(DH.lk("dust", 0));
					}
				}
				dust_sound.play();
				
			}
			if (frame == 4) {
				visible = false;
				
			}
			return Registry.HIT_NORMAL;
		}
		
		override public function update():void 
		{
			if (velocity == null) {
				exists = false;
				return;
			}
			/* Set midpoint for collision with conveyer-type tiles. */
			midpoint.x = x + 8;
			midpoint.y = y + 8;
			if (!ON_CONVEYER) {
				velocity.x = velocity.y = 0;
			}
			
			
			
			/* Check for overlap with a Propelled and if so, 
			 * don't fall in a hole. If just poofed, then propel the Propelled. o_o*/
			for each (var propelled:Propelled in Registry.subgroup_propelled) {
				if (propelled != null) {
					if (propelled.overlaps(this)) {
						
						// Instead, if the propelled is inactive, turn it on, and remove teh dust
						// If the propelled is active do nothing
						
						propelled.turn_on();
						play("poof");
						if (frame == 4) {
							x = -5000;
							exists = false;
						}
						
						on_propelled = true;
						
						/*if (poofed_by_player_landing) {
							propelled.propel_from_dust_poof();
						}*/
					}
				}
			}
			
			if (!on_propelled && (this != parent.player.raft)) {
				if (fell_in_hole) {
					play("poof");
					if (frame == 4) x = -5000;
				}
			}
			on_propelled = false;
			
			
			if (parent.player.raft != this){
				FlxG.collide(this, parent.curMapBuf); // Can set ON_CONVEYER to true.
			}
			
			/* If dust is on the conveyer and player touches it, then the
			 * played should ride on top of it */
			if (ON_CONVEYER) {
				if (parent.player.ON_RAFT == false && parent.player.state != parent.player.S_AIR && parent.player.midpoint.x < x + width && parent.player.midpoint.x > x && 
				parent.player.midpoint.y > y && parent.player.midpoint.y < y + height) {
					parent.player.ON_RAFT = true;
					parent.player.raft = this;
					parent.bg_sprites.remove(this, true);
					parent.player_group.add(this);
					parent.player_group.move_to_front(this);
					var g:FlxGroup;
				}
			} 
			
			ON_CONVEYER = false;
			
			/* Collision with broom */
			if (!parent.player.broom.has_dust && parent.player.broom.overlaps(this) && !parent.player.broom.just_released_dust && (parent.player.raft != this)) {
				if (parent.player.broom.visible) {
					hit("broom", parent.player.broom.root.facing);
					parent.player.broom.has_dust = true;
					parent.player.broom.dust = this;
				}
			}
			
			super.update();
		}
		
		override public function destroy():void 
		{
			// Weird edge case: You die, sortables "cleaned",
			// but then the dust that is a raft becomes not a raft,
			// but is destroyed? so need to set this to false so you go away later
			exists = false;
			super.destroy();
		}
		public function on_anim_change(name:String,a:int,b:int):void {
			if (name == "unpoof") {
				if (dame_frame == T_PUZZLE) {
					if (!INCREMENTED_PUZCT) {
						INCREMENTED_PUZCT = true;
						Registry.GRID_PUZZLES_DONE++;
					}
				}
			}
		}
	}
}
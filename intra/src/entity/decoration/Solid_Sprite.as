package entity.decoration 
{
	import data.CLASS_ID;
	import entity.interactive.NPC;
	import entity.player.Player;
	import global.Registry;
	import helper.Cutscene;
	import helper.DH;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Solid_Sprite extends FlxSprite 
	{
		/* * * * * 
		 * a dame-placed solid sprite. can be animated.
		 * * * * */
		[Embed (source = "../../res/sprites/decoration/red_cave_left.png")] public static var red_cave_left_sprite:Class;
		[Embed(source = "../../res/sprites/decoration/TREE.png")] public static var trees_sprites:Class;
		public var xml:XML;
		public var type_str:String;
		public var cid:int = CLASS_ID.SOLID_SPRITE;
		public var player:Player;
		public var dame_frame:int;
		public var active_region:FlxObject;
		
		
		public function Solid_Sprite(_xml:XML,is_cutscene:Boolean=false,_player:Player=null)
		{
			x = parseInt(_xml.@x);
			y = parseInt(_xml.@y);
			xml = _xml;
			type_str = _xml.@type;
			dame_frame = parseInt(_xml.@frame);
			
			super(x, y);
			player = _player;
			if (type_str == "red_cave_l_ss" && Registry.CURRENT_GRID_X != 3 && Registry.CURRENT_GRID_Y > 3) {
				immovable = true;
				if (!is_cutscene && !Registry.CUTSCENES_PLAYED[Cutscene.Red_Cave_Left]) {
					exists = false;
				} else {
					loadGraphic(red_cave_left_sprite, true, false, 64, 64);
				width = 56;  height = 28;
				offset.y = 32; y += 32;
				offset.x = 4; x += 4;
					if (is_cutscene) {
						addAnimation("a", [0], 20, true); play("a"); scrollFactor.x = scrollFactor.y = 0;
					} 
				}
			} else if (type_str == "red_cave_l_ss") { // CENTRAL ACTUALLY.
				immovable = true;
				loadGraphic(red_cave_left_sprite, true, false, 64, 64);
				width = 56;  height = 28;
				offset.y = 32; y += 32;
				offset.x = 4; x += 4;
				
			} else if (type_str == "red_cave_r_ss") {
				immovable = true;
				if (!is_cutscene && !Registry.CUTSCENES_PLAYED[Cutscene.Red_Cave_Right]) {
					exists = false;
				} else {
					loadGraphic(red_cave_left_sprite, true, false, 64, 64);
					width = 56;  height = 28;
					offset.y = 32; y += 32;
					offset.x = 4; x += 4;
					if (is_cutscene) {
						addAnimation("a", [0], 20, true); play("a"); scrollFactor.x = scrollFactor.y = 0;
					} 
				}
			} else if (type_str == "red_cave_n_ss") {
				immovable = true;
				if (!is_cutscene && !Registry.CUTSCENES_PLAYED[Cutscene.Red_Cave_North]) {
					exists = false;
				} else {
					loadGraphic(red_cave_left_sprite, true, false, 64, 64);
					width = 56;  height = 28;
					offset.y = 32; y += 32;
					offset.x = 4; x += 4;
					if (is_cutscene) {
						addAnimation("a", [0], 20, true); play("a"); scrollFactor.x = scrollFactor.y = 0;
					} 
				}
			}  else if (type_str == "blocker") {
				immovable = true;
				makeGraphic(64, 4, 0x00000000);
			} else if (type_str == "vblock") {
				immovable = true;
				makeGraphic(4, 16, 0x00000000);
			} else if (type_str == "tree") {
				// Change the w/h of this draw call if you want the max size of a tree (or whatever) to be bigger/smaller
				loadGraphic(trees_sprites, true, false, 64,64);
				frame = dame_frame;
				
				immovable = true;
				switch (dame_frame) {
					case 0:
						// Set where the hitbox is and its size
						set_props(16, 32, 32, 32);
						
						break;
					default:
						break;
				}
				
			} else if (type_str == "sign") {
				loadGraphic(NPC.note_rock, true, false, 16, 16);
				frame = parseInt(xml.@frame);
				active_region = new FlxObject(x - 2, y + 14, 20, 5);
				Registry.subgroup_interactives.push(this);
				immovable = true;
			}
		}
		
		/**
		 * Sets this solid sprites properites
		 * @param	ox offset of the hitbox
		 * @param	oy offset of the hitbox (y)
		 * @param	w width of hitbox
		 * @param	h
		 */
		private function set_props(ox:int, oy:int, w:int, h:int):void {
			offset.x = ox;
			offset.y = oy;
			width = w;
			height = h;
			x += ox;
			y += oy;
		}
		override public function update():void 
		{
			
			if (player != null) {
				if (type_str == "blocker") {
					if (player.overlaps(this) && player.velocity.y > 0 && player.y < y) {
						player.y = y - player.height;
					} else if (player.overlaps(this) && player.velocity.y < 0 && player.y > y) {
						player.y = y + height;
					}
				} else if (type_str == "vblock") {
					if (player.overlaps(this)) {
						if (player.velocity.x < 0) {
							player.x = x + width;
						} else {
							player.x = x - player.width;
						}
					}
				} else if (type_str == "tree") {
					FlxG.collide(player, this);
				} else if (type_str == "sign") {
					FlxG.collide(player, this);
					active_region.x = x - 2;
					active_region.y = y + 14;
					if (DH.nc(player, active_region)) {
						if (frame == 2) { //r
							//DH.dialogue_popup("The sign points to the east but the words on it are faded.");
							DH.dialogue_popup(DH.lk("solidsprite", 0));
						} else if (frame == 3) { //l
							//DH.dialogue_popup("The sign points to the west but the words on it are faded.");
							DH.dialogue_popup(DH.lk("solidsprite", 1));
						} else if (frame == 4) { // u/d
							//DH.dialogue_popup("The words on the sign are faded.");
							DH.dialogue_popup(DH.lk("solidsprite", 2));
						}
						
					}
				} else {
					FlxG.collide(player, this);
				}
			} 
			super.update();
		}
		
	}

}
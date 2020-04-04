package entity.gadget
{
	import data.CLASS_ID;
	import entity.player.Player;
	import global.Registry;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	
	/**
	 * a big door. either alive or not alive.
	 * if alive, approaching this without enough growths has a bunch of outlines
	 * of squares pop-up, with as many filled in as you have. The squares then fade out.
	 *		otherwise approaching with enough leads to the square sprites coming from
	 * 		the character, circling around him, eventually leaving trails of blurred sprites, which
	 * 		'attack' the door, make it glow, then fizzle away. sets a global event.
	 * if not alive, the doorway is 'open', so the actual Door entity will be alive
	 * @author Seagaia
	 */
	
	public class Big_Door extends FlxSprite 
	{
		
		public var xml:XML;
		public var cid:int = CLASS_ID.BIG_DOOR;
		[Embed (source = "../../res/sprites/gadgets/big_door.png")] public static var big_door_sprite:Class;
		public var active_region:FlxSprite;
		public var player:Player;
		public var state:int = 0;
		public var s_normal:int = 0;
		public var s_opening:int = 1;
		
		public var s_locked_anim:int = 2;
		public var s_locked_fade:int = 3;
		public var s_wait_to_not_overlap:int = 4;
		
		public var s_open_anim:int = 6;
		public var s_open_anim_ctr:int = 0;
		public var center_sprite:FlxSprite = new FlxSprite(80, 80);
		public var init_open_radius:Number = 45;
		
		
		public var s_open:int = 5;
		public var timer:Number = 0.06;
		public var timer_max:Number = 0.06;
		
		public var s_locked_ctr:int = 0;
		public var locked_squares:FlxGroup = new FlxGroup(36);
		
		public var score_text_1:FlxBitmapFont;
		public var score_text_2:FlxBitmapFont;
		public var white_flash:FlxSprite = new FlxSprite(0, 0);
		
		/* Based on frame, which Big door */
		public static var bd_nexus1:int = 0;
		/* 
		 * dame params: frame is which door this corresponds to
		 **/
		public function Big_Door(_xml:XML,_player:Player):void {
			super(parseInt(_xml.@x), parseInt(_xml.@y));
			xml = _xml;
			loadGraphic(big_door_sprite, true, false, 32, 32);
			active_region = new FlxSprite(x + width / 2 - 1, y + height + 2 + Registry.HEADER_HEIGHT);;
			active_region.makeGraphic(2, 2, 0xffff0000);
			player = _player;
			immovable = true;
			init_squares();
			center_sprite.makeGraphic(1, 1);
			center_sprite.scrollFactor = new FlxPoint(0, 0);
			
			score_text_1 = EventScripts.init_bitmap_font();
			score_text_2 = EventScripts.init_bitmap_font();
			score_text_2.scrollFactor = score_text_1.scrollFactor = new FlxPoint(0, 0);
			score_text_1.y = 30;
			score_text_2.y = 50;
			white_flash.makeGraphic(160, 160, 0xffffffff);  white_flash.alpha = 0;
			white_flash.y += Registry.HEADER_HEIGHT;
			white_flash.scrollFactor = new FlxPoint(0, 0);
			
			if (Registry.Big_Door_State[parseInt(xml.@frame)]) exists = false;
			
		}
		
		private var hoooooops:Boolean = false;
		override public function update():void 
		{
			FlxG.collide(player, this);
			
			/* If the player overlaps the active region set off the event to open door. */
			if (state == s_normal) {
				if (player.overlaps(active_region)) {
					//if (false == hoooooops && Registry.nr_growths >=  Registry.Big_Door_Reqs[parseInt(xml.@frame)]) {
					if (true == hoooooops) {
						state = s_open_anim;
						hoooooops = false;
						
					} else {
						hoooooops = true;
						state = s_locked_anim;
						/* Set the "0.x" text".. */
						score_text_1.setText(Registry.nr_growths.toString()+"\n---", true, 0, 0, "center", true);
						score_text_2.setText(Registry.Big_Door_Reqs[parseInt(xml.@frame)].toString(), true, 0, 0, "center", true);
						score_text_1.x = -20;
						score_text_2.x = Registry.SCREEN_WIDTH_IN_PIXELS + 20;
						Registry.sound_data.big_door_locked.play();
					}
				}	 
			} else if (state == s_opening) {
				alpha -= 0.01;
				if (alpha < 0.01) { 
					state = s_open;
					exists = false;
					Registry.Big_Door_State[parseInt(xml.@frame)] = true;
				}
			} else if (state == s_open) {
				
				/* FADE IN FOR LOCKED DOOR */
			} else if (state == s_locked_anim) {
				timer -= FlxG.elapsed;
				if (timer < 0 && s_locked_ctr < locked_squares.maxSize) {
					timer = timer_max;
					s_locked_ctr ++;
				}
				for (var i:int = 0; i < s_locked_ctr; i++) {
					if (i < Registry.nr_growths) {
						locked_squares.members[i].makeGraphic(20, 20, 0xff000000);
					}
					locked_squares.members[i].alpha += 0.03;
					if (locked_squares.members[i].scale.x >= 1) {
						locked_squares.members[i].scale.x -= 0.04;
						locked_squares.members[i].scale.y -= 0.04;
					}
				}
				
				var text_move_ctr:int = 0;
				if (EventScripts.send_property_to(score_text_1, "x", Registry.SCREEN_WIDTH_IN_PIXELS / 2 - 8, 4)) text_move_ctr++;
				if (EventScripts.send_property_to(score_text_2, "x", Registry.SCREEN_WIDTH_IN_PIXELS / 2, 4	)) text_move_ctr++;
				
				if (text_move_ctr == 2 && locked_squares.members[locked_squares.maxSize - 1].alpha >= 1) {
					
					white_flash.alpha += 0.05;
					if (white_flash.alpha == 1) text_move_ctr++;
					if (text_move_ctr == 3) {
						state = s_locked_fade;
						s_locked_ctr = 0;
					}
				}
				/* FADE OUT FOR LOCKED DOOR */
			} else if (state == s_locked_fade) {
				timer -= FlxG.elapsed;
				if (timer < 0 && s_locked_ctr < locked_squares.maxSize) {
					timer = timer_max;
					s_locked_ctr ++;
				}
				for (var j:int = 0; j < s_locked_ctr; j++) {
					locked_squares.members[j].angularVelocity += 5;
					if (locked_squares.members[j].scale.x > 0.02) {
						locked_squares.members[j].scale.x -= 0.01; 
						locked_squares.members[j].scale.y -= 0.01;
					}
					locked_squares.members[j].alpha -= 0.03;
					
				}
				
				white_flash.alpha -= 0.05;
				EventScripts.send_property_to(score_text_1, "x", Registry.SCREEN_WIDTH_IN_PIXELS + 20, 3);
				EventScripts.send_property_to(score_text_2, "x", -20, 3	);
				score_text_1.alpha -= 0.02;
				score_text_2.alpha -= 0.02;
				
				if ((score_text_1.alpha == 0 && score_text_2.alpha == 0) && locked_squares.members[locked_squares.maxSize - 1].alpha == 0) {
					locked_squares.setAll("angularVelocity", 0);
					locked_squares.setAll("angle", 0);
					locked_squares.setAll("alpha", 0);
					for (i = 0; i < locked_squares.maxSize; i++) {
						locked_squares.members[i].scale.x = 2;
						locked_squares.members[i].scale.y = 2;
					}
					state = s_wait_to_not_overlap;
					s_locked_ctr = 0;
				}
				/* WAIT NOT TO OVERLAP */
			} else if (state == s_wait_to_not_overlap) {
				if (!player.overlaps(active_region)) {
					state = s_normal;
					score_text_1.alpha = score_text_2.alpha = 1;
					score_text_2.x = Registry.SCREEN_WIDTH_IN_PIXELS + 20;
					score_text_1.x = -30;
				}
			} else if (state == s_open_anim) {
			//	var nr_squares = Registry.Big_Door_Reqs[parseInt(xml.@frame)];
				var nr_squares:int = 20;
				var square:FlxSprite;
				if (s_open_anim_ctr == 0) {
					player.dontMove = true;
					
					for (i = 0; i < nr_squares; i++) {
						square = locked_squares.members[i];
						square.rotate_angle = i * (360 / nr_squares);
						square.scale.x = square.scale.y = 1;
						square.color = 0xff000000;
					}
					s_open_anim_ctr ++;
				} else if (s_open_anim_ctr == 1) { //rotate, fade in squaers
				
					for (i = 0; i < nr_squares; i++) {
						square = locked_squares.members[i];
						square.alpha += (((i + 1) / nr_squares) * 0.008);
						EventScripts.rotate_about_center_of_sprite(center_sprite, square, init_open_radius, 0.05, -8, -8);
						if (i == nr_squares - 1) {
							if (square.alpha > 0.8) s_open_anim_ctr++;
						}
						
					}
				} else if (s_open_anim_ctr == 2) { // move squares to center and outwars
					for (i = 0; i < nr_squares; i++) {
						square = locked_squares.members[i];
						EventScripts.rotate_about_center_of_sprite(center_sprite, square, init_open_radius, 0.1, -8, -8);
					}
					init_open_radius -= 1.4;
					if (init_open_radius < -100) s_open_anim_ctr++;
				} else if (s_open_anim_ctr == 3) { // move back to center
					for (i = 0; i < nr_squares; i++) {
						square = locked_squares.members[i];
						EventScripts.rotate_about_center_of_sprite(center_sprite, square, init_open_radius, 0.15, -8, -8);
					}
					init_open_radius += 1.4;
					if (init_open_radius > 0) s_open_anim_ctr++;
				} else if (s_open_anim_ctr == 4) { //flash in, rearrange squares
					white_flash.alpha += 0.04;
					if (white_flash.alpha > 0.99) { 
						s_open_anim_ctr++;
						for each (square in locked_squares.members) {
							square.scale.y = square.scale.x = 0.5 + 2 * Math.random();
							square.x += ( -80 + 160 * Math.random());
							square.y += ( -80 + 160 * Math.random());
							square.angularVelocity = 400 - 800 * Math.random();
						}
						
					}
				} else if (s_open_anim_ctr == 5) { // flash out
					white_flash.alpha -= 0.01;
					if (white_flash.alpha < 0.01) { 
						s_open_anim_ctr++;
					}
				} else { // move squares inwards
					var ctr_ctr:int = 0;
					var nr_done:int = 0;
					white_flash.alpha -= 0.1;
					for each (square in locked_squares.members) {
						if (square.alpha == 0) {
							nr_done++;
							if (nr_done == locked_squares.maxSize) {
								s_open_anim_ctr++;
								state = s_opening;
								white_flash.alpha = 0;
								player.dontMove = false;
								break;
							}
							continue;
						}
						if (EventScripts.send_property_to(square, "x", getScreenXY().x + width / 2, 1)) ctr_ctr++;
						if (EventScripts.send_property_to(square, "y", getScreenXY().y, 1)) ctr_ctr++;
						if (ctr_ctr == 2) {
							square.alpha = 0;
						}
						ctr_ctr = 0;
					}
				}
			}
			
			
			/* The event will freeze controls, and then show the squares in a grid if not enough,
			 * or play the animation if there are enough. */
			
			super.update();
		}
		
		private function init_squares():void {
			for (var i:int = 0; i < locked_squares.maxSize; i++) {
				var s:FlxSprite = new FlxSprite(10 + 24 * (i % 6), 20 + 24 * int(i / 6));
				
				if (i < Registry.nr_growths) {
					s.makeGraphic(20, 20, 0xff000000);
				} else {
					s.makeGraphic(20, 20, 0xffffff00);
				}
				s.scale.x = s.scale.y = 2;
				locked_squares.add(s);
			}
			locked_squares.setAll("scrollFactor", new FlxPoint(0, 0));
			locked_squares.setAll("alpha", 0);
		}
	}
	
}
package entity.interactive 
{
	import entity.gadget.Checkpoint;
	import entity.player.HealthBar;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.Achievements;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Health_Cicada extends FlxSprite 
	{
		
		private var player:Player;
		private var parent:*;
		private var xml:XML;
		
		private var state:int;
		private var s_invisible:int = 0;
		private var s_visible:int = 1;
		private var s_animating:int = 2;
		private var ctr:int = 0;
		
		
		private var logic:Function;
		
		private var tl:Point;
		private var target:Point = new Point;
		private var t:Number = 0;
		private var tm:Number = 1.7	;
		private var nr_gnaws:int = 0;
		
		private var t_sound:Number = 0;
		
		
		public var boxes:FlxGroup = new FlxGroup(10);
		public var fly_away_distance:int = 80;
		
		
		[Embed (source = "../../res/sprites/inventory/life_cicada.png")] public static var health_cicada_embed:Class;
		public function Health_Cicada(_player:Player,_parent:*,_xml:XML) 
		{
			player = _player;
			parent = _parent;
			xml = _xml;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			loadGraphic(health_cicada_embed, true, false, 16, 16);
			if (Registry.CURRENT_MAP_NAME == "TRAIN") {
				addAnimation("idle", [6,7,6,7,6,6,6,6], 8);
				addAnimation("fly", [4,5], 14);
				addAnimation("gnaw", [6,7], 14);
			} else {
				addAnimation("idle", [2, 3, 2, 3, 2, 2, 2, 2], 8);
				addAnimation("fly", [0, 1], 14);
				addAnimation("gnaw", [2, 3], 14);
			}
			play("idle");
			width = height = 8;
			offset.x = offset.y = 4;
			x += 4;
			y += 4;
			
			visible = false;
			
			if (Registry.is_playstate) {
				tl = new Point;
				tl.x = Registry.CURRENT_GRID_X * 160;
				tl.y = Registry.CURRENT_GRID_Y * 160 + Registry.HEADER_HEIGHT;
				logic = dungeon_logic;
			} else {
				logic = roam_logic;
			}
			
			if (xml.@alive == "false") {
				exists = false;
			}
			
			for (var i:int = 0; i < boxes.maxSize; i++) {
				var box:FlxSprite = new FlxSprite;
				if (i % 2 == 0) {
					box.makeGraphic(4, 4, 0xff000000);
				} else {
					box.makeGraphic(3, 3, 0xff000000);
				}
				box.visible = false;
				boxes.add(box);
			}
		}
		
		
		private function dungeon_logic():void {
			if (state == s_visible || (state == s_animating && ctr < 1)) {
				Registry.sound_data.cicada_chirp.play();
			}
			switch (state) {
				case s_invisible:
					if (Registry.CURRENT_MAP_NAME == "BEDROOM") {
						if (Registry.GE_States[Registry.GE_Bedroom_Boss_Dead_Idx]) {
							start(tl.x + 72, tl.y + 60, tl.x - 16, tl.y + 30);
						}
					} else if (Registry.CURRENT_MAP_NAME == "REDCAVE") {
						if (Registry.GE_States[Registry.GE_Redcave_Boss_Dead_Idx]) {
							start(tl.x + 90, tl.y + 75, tl.x - 16, tl.y  + 30);
						}
					} else if (Registry.CURRENT_MAP_NAME == "CROWD") {
						if (Registry.GE_States[Registry.GE_Crowd_Boss_Dead_Idx]) {
							start(tl.x + 70, tl.y + 60, tl.x - 16, tl.y  + 30);
						}
					} else if (Registry.CURRENT_MAP_NAME == "APARTMENT") {
						if (Registry.GE_States[Registry.GE_Apartment_Boss_Dead_Idx]) {
							start(tl.x + 50, tl.y + 60, tl.x - 16, tl.y + 30);
						}
					} else if (Registry.CURRENT_MAP_NAME == "CIRCUS") {
						if (Registry.GE_States[Registry.GE_Circus_Boss_Dead_Idx]) {
							start(tl.x + 70, tl.y + 8 , tl.x - 16, tl.y + 30);
							fly_away_distance = 160;
						}
					} else if (Registry.CURRENT_MAP_NAME == "HOTEL") {
						if (Registry.GE_States[Registry.GE_Hotel_Boss_Dead_Idx]) {
							start(tl.x + 60, tl.y + 70, tl.x -16, tl.y + 30);
						}
					} else if (Registry.CURRENT_MAP_NAME == "OVERWORLD") {
						start(x, y, tl.x - 16, tl.y + 30);
					} else if (Registry.CURRENT_MAP_NAME == "SUBURB") {
						start(x, y, tl.x - 16, tl.y + 30);
					} else if (Registry.CURRENT_MAP_NAME == "TRAIN") {
						start(x, y, tl.x - 16, tl.y + 30);
					} else if (Registry.CURRENT_MAP_NAME == "BEACH") {
						start(x, y, tl.x - 16, tl.y + 30);
					}
					
					break;
				case s_visible: //Touch the player, freeze them. 
					if (ctr == 0 && player.overlaps(this) && player.state == player.S_GROUND) {
						state = s_animating;
						ctr = 0;
						play("fly");
						player.state = player.S_INTERACT;
						player.be_idle();
						// Or fly away if plaer goes too far
					} else if (ctr == 1 || EventScripts.distance(player, this) > fly_away_distance) {
						play("fly");
						velocity.y = -100;
						ctr = 1;
						alpha -= 0.02;
					}
					break;
				case s_animating:
					switch (ctr) {
						case -1: //move to target point
							DH.disable_menu();
							var sub_ctr:int = 0;
							if (EventScripts.send_property_to(this, "x", target.x, 0.5)) sub_ctr++;
							if (EventScripts.send_property_to(this, "y", target.y, 0.5)) sub_ctr++;
							if (sub_ctr == 2) {
								ctr++;
								state = s_visible;
								play("idle");
							}
							break;
						case 0:  //After touched, heal the player
							if (player.health_bar.max_health > player.health_bar.cur_health) {
								t += FlxG.elapsed;
								if (t > 0.5) {
									Registry.sound_data.get_small_health.play();
									t = 0;
									player.health_bar.modify_health(1);
								}
							} else { //eventually upgrade the health and set a target point in the spot of the new health thing
								ctr++;
								if (Registry.CURRENT_MAP_NAME == "OVERWORLD") {
									Achievements.unlock(Achievements.Extra_health_1);
								}
								HealthBar.upgrade_health(player);
								player.health_bar.members[player.health_bar.max_health - 1].visible = false;
								target.x = player.health_bar.members[player.health_bar.max_health - 1].x + tl.x;
								target.y = player.health_bar.members[player.health_bar.max_health - 1].y + tl.y - Registry.HEADER_HEIGHT;
							}
							break;
						case 1: //move there then nibble
							sub_ctr = 0;
							if (EventScripts.send_property_to(this, "x", target.x, 0.5)) sub_ctr++;
							if (EventScripts.send_property_to(this, "y", target.y, 0.5)) sub_ctr++;
							if (sub_ctr == 2) {
								ctr++;
								play("gnaw");
								boxes.setAll("visible", true);
								set_boxes();
							}
							break;
						case 2: // do the box animation a few more times
							for each (var b:FlxSprite in boxes.members) {
								if (b == null) continue;
								b.alpha -= 0.005;
							}
							t += FlxG.elapsed;
							if (t > tm) {
								t = 0;
								set_boxes();
							}
							if (nr_gnaws == 3) {
								ctr++;
								player.health_bar.members[player.health_bar.max_health -1].visible = true;
								play("fly");
								velocity.y = -40;
								xml.@alive = "false";
							}
							break;
						case 3: //fade the last boxes out, then disappear after flying off
							for each (var b2:FlxSprite in boxes.members) {
								if (b2 == null) continue;
								b2.alpha -= 0.005;
							}
							alpha -= 0.01;
							if (alpha == 0) {
								DH.enable_menu();
								player.state = player.S_GROUND;
								exists = false;
							}
							break;
					}
					break;
			}
		}
		
		private function set_boxes():void {
			nr_gnaws++;
			Registry.sound_data.play_sound_group(Registry.sound_data.four_shooter_pop_group);
			for each (var box:FlxSprite in boxes.members) {
				if (box == null) continue;
				box.alpha = 1;
				box.acceleration.y = 50 + 20 * Math.random();
				box.velocity.x = -40 + 80 * Math.random();
				box.velocity.y = 10 + 20 * Math.random();
				box.x = x + 6;
				box.y = y + 6;
			}
		}
		private function roam_logic():void {
			
		}
		
		private function start(target_x:int,target_y:int,start_x:int,start_y:int):void 
		{
			state = s_animating;
			visible = true;
			target.x = target_x;
			target.y = target_y;
			x = start_x;
			y = start_y;
			ctr = -1;
			play("fly");
		}
		override public function update():void 
		{
			logic();
			super.update();
		}
		
		override public function destroy():void 
		{
			tl = null;
			logic = null;
			DH.enable_menu();
			Registry.sound_data.cicada_chirp.stop();
			parent.header_group.remove(this, true);
			parent.header_group.remove(boxes, true);
			boxes = null;
			super.destroy();
		}
	}

}